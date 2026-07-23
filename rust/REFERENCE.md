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
| `amount` | `String` | Yes |  |
| `authorization_number` | `String` | No |  |
| `card_number` | `String` | Yes |  |
| `currency` | `String` | Yes |  |
| `cvc2` | `String` | No |  |
| `desired_currency` | `String` | No |  |
| `ecr_data` | `String` | No |  |
| `language` | `String` | No |  |
| `message_type` | `String` | No |  |
| `password` | `String` | No |  |
| `payment_reason` | `String` | No |  |
| `payment_reason_as_byte` | `Vec<Value>` | No |  |
| `personal_id` | `String` | No |  |
| `receipt_layout` | `String` | No |  |
| `receipt_number` | `String` | No |  |
| `terminal_number` | `String` | Yes |  |
| `transaction_date_time` | `String` | Yes |  |
| `transaction_id` | `String` | Yes |  |
| `transaction_origin_identifier` | `String` | No |  |
| `transaction_origin_indicator` | `String` | No |  |
| `transaction_place` | `String` | No |  |
| `transaction_source_id` | `String` | No |  |

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
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```rust
let client = BluefinTecsEcrSDK::new(jo(vec![
    ("feature", jo(vec![
        ("test", jo(vec![("active", Value::Bool(true))])),
    ])),
]));
```

