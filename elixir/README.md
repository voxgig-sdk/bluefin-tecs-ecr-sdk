# BluefinTecsEcr Elixir SDK



The Elixir SDK for the BluefinTecsEcr API — an entity-oriented client
following idiomatic, functional Elixir conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `BluefinTecsEcr.ecr_api(sdk)` — each
carrying a small, uniform set of operations (`load`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to [Hex](https://hex.pm). Install it from
the GitHub release tag (`elixir/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/releases))
by adding a git dependency to your `mix.exs`:

```elixir
def deps do
  [
    {:bluefin_tecs_ecr, git: "https://github.com/voxgig-sdk/bluefin-tecs-ecr-sdk.git", tag: "elixir/vX.Y.Z"}
  ]
end
```

Or from a local source checkout:

```elixir
def deps do
  [
    {:bluefin_tecs_ecr, path: "../bluefin-tecs-ecr-sdk/elixir"}
  ]
end
```

Then run `mix deps.get`.


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```elixir
alias BluefinTecsEcr.Helpers, as: H

sdk = BluefinTecsEcr.new(H.deep(%{"apikey" => System.get_env("BLUEFIN_TECS_ECR_APIKEY")}))
```

### 3. Load an ecrapi

`load/2` returns the bare record and raises on error.

```elixir
try do
  ecr_api = BluefinTecsEcr.ecr_api(sdk)
  record = BluefinTecsEcr.Entity.EcrApi.load(ecr_api, H.deep(%{}))
  IO.inspect(record)
rescue
  err -> IO.puts("load failed: " <> inspect(err))
end
```

### 4. Create, update, and remove

```elixir
ecr_api = BluefinTecsEcr.ecr_api(sdk)

# Create — returns the bare created record
created = BluefinTecsEcr.Entity.EcrApi.create(ecr_api, H.deep(%{"amount" => "example_amount", "card_number" => "example_card_number", "currency" => "example_currency", "terminal_number" => "example_terminal_number", "transaction_date_time" => "example_transaction_date_time", "transaction_id" => "example_transaction_id"}))

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

For endpoints not covered by entity operations. `direct/2` never raises —
it returns a result node you branch on with `Voxgig.Struct.getprop/2`:

```elixir
alias Voxgig.Struct, as: S
alias BluefinTecsEcr.Helpers, as: H

result = BluefinTecsEcr.direct(sdk, H.deep(%{
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => %{"id" => "example"}
}))

if S.getprop(result, "ok") do
  IO.inspect(S.getprop(result, "status"))  # 200
  IO.inspect(S.getprop(result, "data"))    # response body
else
  # A non-2xx response carries status + data (the error body); a
  # transport-level failure carries err instead.
  IO.inspect(S.getprop(result, "err"))
end
```

### Prepare a request without sending it

```elixir
alias BluefinTecsEcr.Helpers, as: H

# prepare/2 returns the fetch definition and raises on error.
fetchdef = BluefinTecsEcr.prepare(sdk, H.deep(%{
  "path" => "/api/resource/{id}",
  "method" => "DELETE",
  "params" => %{"id" => "example"}
}))

IO.inspect(Voxgig.Struct.getprop(fetchdef, "url"))
IO.inspect(Voxgig.Struct.getprop(fetchdef, "method"))
```

### Use test mode

Create a mock client for unit testing — no server required:

```elixir
alias BluefinTecsEcr.Helpers, as: H

sdk = BluefinTecsEcr.test()

# Entity ops return the bare record (raise on error).
ecr_api = BluefinTecsEcr.ecr_api(sdk)
record = BluefinTecsEcr.Entity.EcrApi.load(ecr_api, H.deep(%{}))
IO.inspect(record)
```

### Use a custom fetch function

Replace the HTTP transport with your own function. It receives `(url,
fetchdef)` and returns a `{response, error}` tuple:

```elixir
alias Voxgig.Struct, as: S
alias BluefinTecsEcr.Helpers, as: H

mock_fetch = fn _url, _fetchdef ->
  response = H.deep(%{
    "status" => 200,
    "statusText" => "OK",
    "headers" => %{},
    "json" => fn -> %{"id" => "mock01"} end
  })
  {response, nil}
end

sdk = BluefinTecsEcr.new(H.deep(%{
  "base" => "http://localhost:8080",
  "system" => %{"fetch" => mock_fetch}
}))
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_TECS_ECR_TEST_LIVE=TRUE
BLUEFIN_TECS_ECR_APIKEY=<your-key>
```

Then run:

```bash
cd elixir && mix test
```


## Reference

### BluefinTecsEcr

```elixir
sdk = BluefinTecsEcr.new(options)
```

Creates a new SDK client. `options` is a struct value node — build one from a
native map with `BluefinTecsEcr.Helpers.deep/1`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String.t()` | API key for authentication. |
| `base` | `String.t()` | Base URL of the API server. |
| `prefix` | `String.t()` | URL path prefix prepended to all requests. |
| `suffix` | `String.t()` | URL path suffix appended to all requests. |
| `feature` | `map()` | Feature activation flags. |
| `extend` | `list()` | Additional feature instances to load. |
| `system` | `map()` | System overrides (e.g. custom `fetch` function). |

### test

```elixir
sdk = BluefinTecsEcr.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### BluefinTecsEcr functions

| Function | Signature | Description |
| --- | --- | --- |
| `options_map` | `(client) :: map()` | Deep copy of current SDK options. |
| `get_utility` | `(client) :: map()` | The SDK utility node. |
| `prepare` | `(client, fetchargs) :: map()` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(client, fetchargs) :: map()` | Build and send an HTTP request. Returns a result node (branch on `ok`). |
| `ecr_api` | `(client, entopts \\ nil) :: entity` | Create an EcrApi entity handle. |

### Entity interface

Every entity's `BluefinTecsEcr.Entity.<Name>` module shares the same interface.

| Function | Signature | Description |
| --- | --- | --- |
| `load` | `(entity, reqmatch, ctrl \\ nil) :: map()` | Load a single entity by match criteria. Raises on error. |
| `create` | `(entity, reqdata, ctrl \\ nil) :: map()` | Create a new entity. Raises on error. |
| `data_get` | `(entity) :: map()` | Get entity data. |
| `data_set` | `(entity, data)` | Set entity data. |
| `match_get` | `(entity) :: map()` | Get entity match criteria. |
| `match_set` | `(entity, match)` | Set entity match criteria. |
| `make` | `(entity) :: entity` | Create a new handle with the same options. |
| `get_name` | `(entity) :: String.t()` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a value node — a map for
single-entity ops, a list for `list`) and raise a `BluefinTecsEcr.Error` on
failure. Wrap calls in `try`/`rescue` to handle errors.

The `direct/2` escape hatch never raises — it returns a result node you
branch on via `Voxgig.Struct.getprop(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `boolean()` | `true` if the HTTP status is 2xx. |
| `status` | `integer()` | HTTP status code. |
| `headers` | `map()` | Response headers. |
| `data` | `any()` | Parsed JSON response body. |

On error, `ok` is `false` and `err` carries the error value.

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

Operations: Create, Load.

API path: `/makeTransaction`



## Entities

Every operation lives on the entity's `BluefinTecsEcr.Entity.<Name>` module and
takes an entity handle built from the client:


### EcrApi

Create a handle: `ecr_api = BluefinTecsEcr.ecr_api(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `load(entity, match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `amount` | `String.t()` | Numeric Transaction Amount. |
| `authorization_number` | `String.t()` | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `String.t()` | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `String.t()` | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `String.t()` | Card Verification Code. |
| `desired_currency` | `String.t()` | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `String.t()` | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `String.t()` | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `String.t()` | Message type code. |
| `password` | `String.t()` | Password - currently not used (filled with spaces). |
| `payment_reason` | `String.t()` | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `list()` | Payment reason represented as a byte array. |
| `personal_id` | `String.t()` | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `String.t()` | Receipt layout identifier. |
| `receipt_number` | `String.t()` | Receipt number. |
| `terminal_number` | `String.t()` | Terminal number provided by TECS. |
| `transaction_date_time` | `String.t()` | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `String.t()` | Unique transaction identifier. |
| `transaction_origin_identifier` | `String.t()` | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `String.t()` | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `String.t()` | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `String.t()` | Identification number of the authorization source. |

#### Example: Load

```elixir
ecr_api = BluefinTecsEcr.ecr_api(sdk)
record = BluefinTecsEcr.Entity.EcrApi.load(ecr_api, BluefinTecsEcr.Helpers.deep(%{}))
```

#### Example: Create

```elixir
ecr_api = BluefinTecsEcr.ecr_api(sdk)
record = BluefinTecsEcr.Entity.EcrApi.create(ecr_api, BluefinTecsEcr.Helpers.deep(%{
  "amount" => "example_amount",  # String.t()
  "card_number" => "example_card_number",  # String.t()
  "currency" => "example_currency",  # String.t()
  "terminal_number" => "example_terminal_number",  # String.t()
  "transaction_date_time" => "example_transaction_date_time",  # String.t()
  "transaction_id" => "example_transaction_id",  # String.t()
}))
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

### Data as struct value nodes

The Elixir SDK models every runtime object — clients, contexts, results and
record data — as reference-stable struct value nodes from the vendored
`Voxgig.Struct` library rather than as compile-time structs. This mirrors
the dynamic nature of the API and lets a feature hook mutate a shared node
that every later pipeline stage observes — the immutable-Elixir way to honour
the shared-mutable hook contract.

Build inputs from native Elixir maps with `BluefinTecsEcr.Helpers.deep/1`,
and read fields off results with `Voxgig.Struct.getprop/2`.

### Module structure

```
elixir/
├── lib/
│   ├── bluefin-tecs-ecr.ex                 -- Main SDK module (entity factories)
│   ├── config.ex                 -- Resolved configuration
│   ├── features.ex               -- Feature factory
│   ├── pipeline.ex               -- Operation pipeline
│   └── bluefin-tecs-ecr/
│       ├── context.ex            -- Operation context
│       ├── entity_base.ex        -- Shared entity behaviour
│       ├── error.ex              -- SDK error type
│       ├── feature.ex            -- Built-in features
│       ├── helpers.ex            -- Value helpers (deep/1, ...)
│       ├── json.ex               -- JSON encode/decode
│       └── utility.ex            -- Utility functions
│   └── entity/                   -- Per-entity modules
├── mix.exs                       -- Package manifest
└── test/                         -- ExUnit suites
```

The main module `BluefinTecsEcr` exposes the SDK constructors and one entity
factory function per entity. Call an operation on the matching
`BluefinTecsEcr.Entity.<Name>` module.

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
