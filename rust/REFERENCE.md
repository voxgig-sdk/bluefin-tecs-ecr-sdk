# BluefinTecsEcr Rust SDK Reference

Complete API reference for the BluefinTecsEcr Rust SDK.


## BluefinTecsEcrSDK

### Constructor

```rust
use bluefin_tecs_ecr_sdk::{BluefinTecsEcrSDK, Value};

let client = BluefinTecsEcrSDK::new(options);
```

Create a new SDK client instance. `options` is a `Value` map
(`Value::Noval` for none).

**Parameters:**

| Key | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides. |


### Static Functions

#### `test_sdk(testopts: Value, sdkopts: Value) -> Rc<BluefinTecsEcrSDK>`

Create a test client with mock features active. Both arguments may be
`Value::Noval`.

```rust
use bluefin_tecs_ecr_sdk::{test_sdk, Value};

let client = test_sdk(Value::Noval, Value::Noval);
```


### Instance Methods

#### `ecr_api(entopts: Value) -> Rc<EcrApiEntity>`

Create a new `EcrApiEntity` instance. Pass `Value::Noval` for no
initial options.

#### `options_map() -> Value`

Return a deep copy of the current SDK options.

#### `get_utility() -> Rc<Utility>`

Return a copy of the SDK utility object.

#### `direct(fetchargs: Value) -> Result<Value, BluefinTecsEcrError>`

Make a direct HTTP request to any API endpoint. `Ok` is a result `Value::Map`
with `ok`, `status`, `headers`, and `data` (or `err` on failure). This
escape hatch resolves to `Ok` even on a non-2xx response — branch on
`getp(&result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `prepare(fetchargs: Value) -> Result<Value, BluefinTecsEcrError>`

Prepare a fetch definition without sending. Returns the fetchdef on `Ok`.


---

## EcrApiEntity

```rust
let ecr_api = client.ecr_api(Value::Noval);
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
| `payment_reasonAsByte` | `Vec<Value>` | No | Payment reason represented as a byte array. |
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

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, BluefinTecsEcrError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.ecr_api(Value::Noval).create(jo(vec![
    ("amount", Value::str("example_amount")),  // String
    ("card_number", Value::str("example_card_number")),  // String
    ("currency", Value::str("example_currency")),  // String
    ("terminal_number", Value::str("example_terminal_number")),  // String
    ("transaction_date_time", Value::str("example_transaction_date_time")),  // String
    ("transaction_id", Value::str("example_transaction_id")),  // String
]), Value::Noval).unwrap();
```

#### `load(reqmatch: Value, ctrl: Value) -> Result<Value, BluefinTecsEcrError>`

Load a single entity matching the given criteria. Returns the entity data on `Ok` and `Err` on failure.

```rust
let result = client.ecr_api(Value::Noval).load(Value::Noval, Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `EcrApiEntity` instance with the same options.

#### `get_name() -> String`

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

```rust
let client = BluefinTecsEcrSDK::new(jo(vec![
    ("feature", jo(vec![
        ("audit", jo(vec![("active", Value::Bool(true))])),
        ("clienttrack", jo(vec![("active", Value::Bool(true))])),
        ("idempotency", jo(vec![("active", Value::Bool(true))])),
        ("log", jo(vec![("active", Value::Bool(true))])),
        ("metrics", jo(vec![("active", Value::Bool(true))])),
        ("paging", jo(vec![("active", Value::Bool(true))])),
        ("ratelimit", jo(vec![("active", Value::Bool(true))])),
        ("retry", jo(vec![("active", Value::Bool(true))])),
        ("telemetry", jo(vec![("active", Value::Bool(true))])),
        ("test", jo(vec![("active", Value::Bool(true))])),
        ("timeout", jo(vec![("active", Value::Bool(true))])),
    ])),
]));
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

