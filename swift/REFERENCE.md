# BluefinTecsEcr Swift SDK Reference

Complete API reference for the BluefinTecsEcr Swift SDK.


## BluefinTecsEcrSDK

### Constructor

```swift
let client = BluefinTecsEcrSDK(options)
```

Create a new SDK client instance. `options` is a `VMap` of `Value`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `VMap` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `VMap` | Custom headers for all requests. |
| `options["feature"]` | `VMap` | Feature configuration. |
| `options["system"]` | `VMap` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinTecsEcrSDK.testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `nil`.

```swift
let client = BluefinTecsEcrSDK.testSDK(nil, nil)
```


### Instance Methods

#### `EcrApi(entopts)`

Create a new `EcrApi` entity instance. Pass `nil` for no initial
options.

#### `optionsMap() -> VMap`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> VMap`

Make a direct HTTP request to any API endpoint. Returns a result `VMap`
with `ok`, `status`, `headers`, and `data` (or `err` on failure).
This escape hatch never throws — branch on `result.entries["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `VMap` | Path parameter values. |
| `fetchargs["query"]` | `VMap` | Query string parameters. |
| `fetchargs["headers"]` | `VMap` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Value` | Request body (maps are JSON-serialized). |

**Returns:** `VMap`

#### `prepare(fetchargs) throws -> VMap`

Prepare a fetch definition without sending. Returns the `fetchdef` and throws on error.


---

## EcrApi

```swift
let ecrApi = client.EcrApi()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `amount` | `String` | Yes | Numeric Transaction Amount. |
| `authorization_number` | `String` | No | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `String` | Yes | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `String` | Yes | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `String` | No | Card Verification Code. |
| `desired_currency` | `String` | No | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `String` | No | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `String` | No | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `String` | No | Message type code. |
| `password` | `String` | No | Password - currently not used (filled with spaces). |
| `payment_reason` | `String` | No | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `[Value]` | No | Payment reason represented as a byte array. |
| `personal_id` | `String` | No | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `String` | No | Receipt layout identifier. |
| `receipt_number` | `String` | No | Receipt number. |
| `terminal_number` | `String` | Yes | Terminal number provided by TECS. |
| `transaction_date_time` | `String` | Yes | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `String` | Yes | Unique transaction identifier. |
| `transaction_origin_identifier` | `String` | No | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `String` | No | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `String` | No | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `String` | No | Identification number of the authorization source. |

### Operations

#### `create(reqdata, ctrl) throws -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```swift
let result = try client.EcrApi().create(VMap([
    ("amount", .string("example_amount")),  // String
    ("card_number", .string("example_card_number")),  // String
    ("currency", .string("example_currency")),  // String
    ("terminal_number", .string("example_terminal_number")),  // String
    ("transaction_date_time", .string("example_transaction_date_time")),  // String
    ("transaction_id", .string("example_transaction_id"))  // String
]), nil)
```

#### `load(reqmatch, ctrl) throws -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```swift
let result = try client.EcrApi().load(nil, nil)
```

### Common Methods

#### `data(newdata?) -> Value`

Get or set the entity data.

#### `matchv(newmatch?) -> Value`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `EcrApi` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `audit` | 0.0.1 | Structured audit trail of operations |
| `clienttrack` | 0.0.1 | Client identity and per-request correlation headers |
| `idempotency` | 0.0.1 | Idempotency keys for safe retries of mutating operations |
| `log` | 0.0.1 | Structured request and response logging |
| `metrics` | 0.0.1 | Statistics capture: per-operation counters and latency |
| `paging` | 0.0.1 | Pagination signals for list operations |
| `ratelimit` | 0.0.1 | Client-side rate limiting via a token bucket |
| `retry` | 0.0.1 | Automatic retry of transient failures with exponential backoff |
| `telemetry` | 0.0.1 | Distributed tracing spans with W3C trace-context propagation |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |
| `timeout` | 0.0.1 | Per-request timeout with transport abort |


Features are activated via the `feature` option:

```swift
let feature = VMap()
feature.entries["audit"] = .map([("active", .bool(true))])
feature.entries["clienttrack"] = .map([("active", .bool(true))])
feature.entries["idempotency"] = .map([("active", .bool(true))])
feature.entries["log"] = .map([("active", .bool(true))])
feature.entries["metrics"] = .map([("active", .bool(true))])
feature.entries["paging"] = .map([("active", .bool(true))])
feature.entries["ratelimit"] = .map([("active", .bool(true))])
feature.entries["retry"] = .map([("active", .bool(true))])
feature.entries["telemetry"] = .map([("active", .bool(true))])
feature.entries["test"] = .map([("active", .bool(true))])
feature.entries["timeout"] = .map([("active", .bool(true))])
let options = VMap()
options.entries["feature"] = .map(feature)
let client = BluefinTecsEcrSDK(options)
```


### Configuring features

Each feature is inactive until switched on, and an SDK with no feature
configured does no feature work at all. Every option below keeps its default
unless you name it.

The array form of \`feature\` is significant: several features wrap the
transport, and the order you list them in is the order they nest.

#### Ordering

`ratelimit`, `retry`, `timeout` wrap the transport. Each
wraps whatever is already installed, so **activation order is nesting order**:
a feature activated later sits OUTSIDE one activated earlier, and sees the call
first.

That decides behaviour, not just sequence: a feature that short-circuits the
call, such as a cache serving a hit, stops every feature nested inside it from
ever seeing that call.

`audit`, `clienttrack`, `idempotency`, `log`, `metrics`, `paging`, `telemetry`, `test` attach to pipeline hooks
rather than the transport, so their order does not affect what they observe.

#### `audit`

Structured audit trail of operations.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `actor` | `'anonymous'` |
| `max` | `1000` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.audit.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `clienttrack`

Client identity and per-request correlation headers.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `clientVersion` | `'0.0.1'` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.clienttrack.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `idempotency`

Idempotency keys for safe retries of mutating operations.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.idempotency.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `log`

Structured request and response logging.

**Configuration**

| Option | Default |
|---|---|
| `active` | `true` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.log.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `metrics`

Statistics capture: per-operation counters and latency.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.metrics.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `paging`

Pagination signals for list operations.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `afterVar` | `'after'` |
| `cursorParam` | `'cursor'` |
| `firstVar` | `'first'` |
| `limitParam` | `'limit'` |
| `pageParam` | `'page'` |
| `startPage` | `1` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.paging.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `ratelimit`

Client-side rate limiting via a token bucket.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.ratelimit.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `retry`

Automatic retry of transient failures with exponential backoff.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.retry.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

#### `telemetry`

Distributed tracing spans with W3C trace-context propagation.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.telemetry.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Inactive by default: leaving it out costs nothing at runtime.

#### `test`

In-memory mock transport for testing without a live server.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.test.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Installs the BASE transport that the wrapping features wrap, so it must be
  activated before them.
- Inactive by default: leaving it out costs nothing at runtime.

#### `timeout`

Per-request timeout with transport abort.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.timeout.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Wraps the transport: its place in the activation order decides what it
  sees. See [Ordering](#ordering) above.
- Inactive by default: leaving it out costs nothing at runtime.

