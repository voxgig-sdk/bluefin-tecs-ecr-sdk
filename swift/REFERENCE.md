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
| `payment_reason_as_byte` | `[Value]` | No |  |
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
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```swift
let feature = VMap()
feature.entries["test"] = .map([("active", .bool(true))])
let options = VMap()
options.entries["feature"] = .map(feature)
let client = BluefinTecsEcrSDK(options)
```

