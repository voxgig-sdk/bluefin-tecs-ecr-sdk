# BluefinTecsEcr Scala SDK Reference

Complete API reference for the BluefinTecsEcr Scala SDK.


## BluefinTecsEcrSDK

### Constructor

```scala
val client = new BluefinTecsEcrSDK(options)
```

Create a new SDK client instance. `options` is a `java.util.Map[String, Object]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Map` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Map` | Custom headers for all requests. |
| `options["feature"]` | `Map` | Feature configuration. |
| `options["system"]` | `Map` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinTecsEcrSDK.testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `null`.

```scala
val client = BluefinTecsEcrSDK.testSDK(null, null)
```


### Instance Methods

#### `ecrApi(entopts)`

Create a new `EcrApi` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `optionsMap() -> Map`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Map`

Make a direct HTTP request to any API endpoint. Returns a result
`java.util.Map[String, Object]` with `ok`, `status`, `headers`, and
`data` (or `err` on failure). This escape hatch never raises — branch on
`result.get("ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Map` | Path parameter values. |
| `fetchargs["query"]` | `Map` | Query string parameters. |
| `fetchargs["headers"]` | `Map` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Object` | Request body (maps are JSON-serialized). |

**Returns:** `java.util.Map[String, Object]`

#### `prepare(fetchargs) -> Map`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## EcrApi

```scala
val ecrApi = client.ecrApi(null)
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
| `payment_reasonAsByte` | `java.util.List[Object]` | No |  |
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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.ecrApi(null).create(java.util.Map.of(
    "amount", "example_amount",  // String
    "card_number", "example_card_number",  // String
    "currency", "example_currency",  // String
    "terminal_number", "example_terminal_number",  // String
    "transaction_date_time", "example_transaction_date_time",  // String
    "transaction_id", "example_transaction_id"  // String
), null)
```

#### `load(reqmatch, ctrl) -> Object`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```scala
val result = client.ecrApi(null).load(null, null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

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

```scala
val feature = new java.util.LinkedHashMap[String, Object]()
feature.put("test", java.util.Map.of("active", true))
val options = new java.util.LinkedHashMap[String, Object]()
options.put("feature", feature)
val client = new BluefinTecsEcrSDK(options)
```

