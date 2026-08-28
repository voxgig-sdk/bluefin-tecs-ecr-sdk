# BluefinTecsEcr Java SDK



The Java SDK for the BluefinTecsEcr API — an entity-oriented client following idiomatic Java conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.ecrApi(null)` — each
carrying a small, uniform set of operations (`load`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Maven Central. Install it from the GitHub
release tag (`java/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/releases)) or
from a source checkout — build the library with Maven:

```bash
cd java && mvn install
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```java
import voxgig.bluefintecsecrsdk.core.BluefinTecsEcrSDK;

Map<String, Object> options = new java.util.LinkedHashMap<>();
options.put("apikey", System.getenv("BLUEFIN_TECS_ECR_APIKEY"));
BluefinTecsEcrSDK client = new BluefinTecsEcrSDK(options);
```

### 3. Load an ecrapi

`load()` returns the ENTITY — call data() for the record — and raises on error.

```java
try {
    Object ecrApi = client.ecrApi(null).load(null, null);
    System.out.println(ecrApi);
}
catch (RuntimeException err) {
    System.out.println("load failed: " + err.getMessage());
}
```

### 4. Create, update, and remove

```java
// Create — returns the ENTITY (call data() for the record)
Object created = client.ecrApi(null).create(Map.of("amount", "example_amount", "card_number", "example_card_number", "currency", "example_currency", "terminal_number", "example_terminal_number", "transaction_date_time", "example_transaction_date_time", "transaction_id", "example_transaction_id"), null);

```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const ecrapi = await client.EcrApi().load()
  console.log(ecrapi)
} catch (err) {
  console.error('load failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```java
Map<String, Object> result = client.direct(Map.of(
    "path", "/api/resource/{id}",
    "method", "GET",
    "params", Map.of("id", "example")));

if (Boolean.TRUE.equals(result.get("ok"))) {
    System.out.println(result.get("status"));  // 200
    System.out.println(result.get("data"));    // response body
}
else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present, so
    // read both — an absent key simply reads as null.
    System.out.println(result.get("status") + " " + result.get("err"));
}
```

### Prepare a request without sending it

```java
// prepare() returns the fetch definition and raises on error.
Map<String, Object> fetchdef = client.prepare(Map.of(
    "path", "/api/resource/{id}",
    "method", "DELETE",
    "params", Map.of("id", "example")));

System.out.println(fetchdef.get("url"));
System.out.println(fetchdef.get("method"));
System.out.println(fetchdef.get("headers"));
```

### Use test mode

Create a mock client for unit testing — no server required:

```java
BluefinTecsEcrSDK client = BluefinTecsEcrSDK.testSDK(null, null);

// Entity ops return the ENTITY and raises on error;
// call data() for the record.
Object ecrApi = client.ecrApi(null).load(null, null);
// ecrApi holds the mock response record
System.out.println(ecrApi);
```

### Use a custom fetch function

Replace the HTTP transport with your own `BiFunction`:

```java
java.util.function.BiFunction<String, Map<String, Object>, Object> mockFetch =
    (url, init) -> {
        Map<String, Object> res = new java.util.LinkedHashMap<>();
        res.put("status", 200);
        res.put("statusText", "OK");
        res.put("headers", new java.util.LinkedHashMap<String, Object>());
        res.put("json", (java.util.function.Supplier<Object>) () ->
            Map.of("id", "mock01"));
        return res;
    };

Map<String, Object> options = new java.util.LinkedHashMap<>();
options.put("base", "http://localhost:8080");
options.put("system", Map.of("fetch", mockFetch));
BluefinTecsEcrSDK client = new BluefinTecsEcrSDK(options);
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_TECS_ECR_TEST_LIVE=TRUE
BLUEFIN_TECS_ECR_APIKEY=<your-key>
```

Then run:

```bash
cd java && mvn test
```


## Reference

### BluefinTecsEcrSDK

```java
BluefinTecsEcrSDK client = new BluefinTecsEcrSDK(options);
```

Creates a new SDK client. `options` is a `Map<String, Object>`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Map` | Feature activation flags. |
| `extend` | `List` | Additional Feature instances to load. |
| `system` | `Map` | System overrides (e.g. custom `fetch` function). |

### testSDK

```java
BluefinTecsEcrSDK client = BluefinTecsEcrSDK.testSDK(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### BluefinTecsEcrSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> Map` | Deep copy of current SDK options. |
| `getUtility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Map` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> Map` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `ecrApi` | `(entopts) -> SdkEntity` | Create an EcrApi entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> Object` | Load a single entity by match criteria. Raises on error. |
| `create` | `(reqdata, ctrl) -> Object` | Create a new entity. Raises on error. |
| `data` | `(newdata...) -> Object` | Get or set entity data. |
| `match` | `(newmatch...) -> Object` | Get or set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `getName` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the ENTITY (call data() for the record) (a `Map` for single-entity
ops, an aggregate `List` for `list`) as `Object` and raise on error. Wrap
calls in `try`/`catch` to handle failures.

The `direct()` escape hatch never raises — it returns a result
`Map<String, Object>` you branch on via `result.get("ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Boolean` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Map` | Response headers. |
| `data` | `Object` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

### Entities

#### EcrApi

| Field | Description |
| --- | --- |
| `amount` | Numeric Transaction Amount. |
| `authorization_number` | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | Card Verification Code. |
| `desired_currency` | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | Message type code. |
| `password` | Password - currently not used (filled with spaces). |
| `payment_reason` | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | Payment reason represented as a byte array. |
| `personal_id` | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | Receipt layout identifier. |
| `receipt_number` | Receipt number. |
| `terminal_number` | Terminal number provided by TECS. |
| `transaction_date_time` | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | Unique transaction identifier. |
| `transaction_origin_identifier` | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | Identification number of the authorization source. |

Operations: create, load.

API path: `/makeTransaction`



## Entities


### EcrApi

Create an instance: `SdkEntity ecrApi = client.ecrApi(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `load(match, null)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `amount` | `String` | Numeric Transaction Amount. |
| `authorization_number` | `String` | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `String` | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `String` | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `String` | Card Verification Code. |
| `desired_currency` | `String` | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `String` | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `String` | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `String` | Message type code. |
| `password` | `String` | Password - currently not used (filled with spaces). |
| `payment_reason` | `String` | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `List<Object>` | Payment reason represented as a byte array. |
| `personal_id` | `String` | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `String` | Receipt layout identifier. |
| `receipt_number` | `String` | Receipt number. |
| `terminal_number` | `String` | Terminal number provided by TECS. |
| `transaction_date_time` | `String` | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `String` | Unique transaction identifier. |
| `transaction_origin_identifier` | `String` | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `String` | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `String` | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `String` | Identification number of the authorization source. |

#### Example: Load

```java
Object ecrApi = client.ecrApi(null).load(null, null);
```

#### Example: Create

```java
Object ecrApi = client.ecrApi(null).create(Map.of(
    "amount", "example_amount",  // String
    "card_number", "example_card_number",  // String
    "currency", "example_currency",  // String
    "terminal_number", "example_terminal_number",  // String
    "transaction_date_time", "example_transaction_date_time",  // String
    "transaction_id", "example_transaction_id"  // String
), null);
```

## Features

This SDK ships 11 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`audit`](#audit) | Structured audit trail of operations |
| [`clienttrack`](#clienttrack) | Client identity and per-request correlation headers |
| [`idempotency`](#idempotency) | Idempotency keys for safe retries of mutating operations |
| [`log`](#log) | Structured request and response logging |
| [`metrics`](#metrics) | Statistics capture: per-operation counters and latency |
| [`paging`](#paging) | Pagination signals for list operations |
| [`ratelimit`](#ratelimit) | Client-side rate limiting via a token bucket |
| [`retry`](#retry) | Automatic retry of transient failures with exponential backoff |
| [`telemetry`](#telemetry) | Distributed tracing spans with W3C trace-context propagation |
| [`test`](#test) | In-memory mock transport for testing without a live server |
| [`timeout`](#timeout) | Per-request timeout with transport abort |

> **Order matters for `ratelimit`, `retry`, `timeout`.** These wrap the
> transport, so each one wraps whatever is already installed: the order you
> activate them in IS the nesting order. Activating them as an ordered list
> rather than a map is what fixes that order.

### audit

Structured audit trail of operations.

| Option | Default |
|---|---|
| `active` | `false` |
| `actor` | `'anonymous'` |
| `max` | `1000` |

Set `feature.audit.active` to enable it, then override any of the options above.

### clienttrack

Client identity and per-request correlation headers.

| Option | Default |
|---|---|
| `active` | `false` |
| `clientVersion` | `'0.0.1'` |

Set `feature.clienttrack.active` to enable it, then override any of the options above.

### idempotency

Idempotency keys for safe retries of mutating operations.

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

Set `feature.idempotency.active` to enable it, then override any of the options above.

### log

Structured request and response logging.

| Option | Default |
|---|---|
| `active` | `true` |

Set `feature.log.active` to enable it, then override any of the options above.

### metrics

Statistics capture: per-operation counters and latency.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.metrics.active` to enable it, then override any of the options above.

### paging

Pagination signals for list operations.

| Option | Default |
|---|---|
| `active` | `false` |
| `afterVar` | `'after'` |
| `cursorParam` | `'cursor'` |
| `firstVar` | `'first'` |
| `limitParam` | `'limit'` |
| `pageParam` | `'page'` |
| `startPage` | `1` |

Set `feature.paging.active` to enable it, then override any of the options above.

### ratelimit

Client-side rate limiting via a token bucket.

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

Set `feature.ratelimit.active` to enable it, then override any of the options above.

`ratelimit` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### retry

Automatic retry of transient failures with exponential backoff.

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

Set `feature.retry.active` to enable it, then override any of the options above.

`retry` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### telemetry

Distributed tracing spans with W3C trace-context propagation.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.telemetry.active` to enable it, then override any of the options above.

### test

In-memory mock transport for testing without a live server.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.

### timeout

Per-request timeout with transport abort.

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

Set `feature.timeout.active` to enable it, then override any of the options above.

`timeout` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **AuditFeature**: Structured audit trail of operations
- **ClienttrackFeature**: Client identity and per-request correlation headers
- **IdempotencyFeature**: Idempotency keys for safe retries of mutating operations
- **LogFeature**: Structured request and response logging
- **MetricsFeature**: Statistics capture: per-operation counters and latency
- **PagingFeature**: Pagination signals for list operations
- **RatelimitFeature**: Client-side rate limiting via a token bucket
- **RetryFeature**: Automatic retry of transient failures with exponential backoff
- **TelemetryFeature**: Distributed tracing spans with W3C trace-context propagation
- **TestFeature**: In-memory mock transport for testing without a live server
- **TimeoutFeature**: Per-request timeout with transport abort

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as maps

The Java SDK uses a loose object model — `Map<String, Object>` throughout —
rather than a bespoke typed class per endpoint. This mirrors the dynamic
nature of the API and keeps the SDK flexible: no regeneration is needed when
the API schema changes.

Use `Helpers.toMapAny(value)` to safely coerce a value to a
`Map<String, Object>`. A `BluefinTecsEcrTypes.java` module of reference
`record` types is also generated for editor documentation.

### Project structure

```
java/
├── pom.xml                     -- Maven project (compiles core/, utility/, feature/, entity/)
├── core/                       -- Main SDK client, config, entity base, error type
├── entity/                     -- Entity implementations
├── feature/                    -- Built-in features (Base, Test, Log, ...)
├── utility/                    -- Utility functions and the vendored struct library
└── test/                       -- JUnit test suites
```

The main client class (`BluefinTecsEcrSDK`, package `voxgig.bluefintecsecrsdk.core`)
exposes the entity accessors. Reference entity or utility types directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const ecrapi = client.EcrApi()
await ecrapi.load()

// ecrapi.data() now returns the ecrapi data from the last `load`
// ecrapi.match() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
