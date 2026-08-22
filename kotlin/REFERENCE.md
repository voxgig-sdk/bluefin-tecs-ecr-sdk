# BluefinTecsEcr Kotlin SDK Reference

Complete API reference for the BluefinTecsEcr Kotlin SDK.


## BluefinTecsEcrSDK

### Constructor

```kotlin
val client = BluefinTecsEcrSDK(options)
```

Create a new SDK client instance. `options` is a `MutableMap<String, Any?>`.

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

```kotlin
val client = BluefinTecsEcrSDK.testSDK(null, null)
```


### Instance Methods

#### `ecrApi(entopts)`

Create a new `EcrApi` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `optionsMap() -> MutableMap`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> MutableMap`

Make a direct HTTP request to any API endpoint. Returns a result
`MutableMap<String, Any?>` with `ok`, `status`, `headers`, and `data`
(or `err` on failure). This escape hatch never raises — branch on
`result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Map` | Path parameter values. |
| `fetchargs["query"]` | `Map` | Query string parameters. |
| `fetchargs["headers"]` | `Map` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Any?` | Request body (maps are JSON-serialized). |

**Returns:** `MutableMap<String, Any?>`

#### `prepare(fetchargs) -> MutableMap`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## EcrApi

```kotlin
val ecrApi = client.ecrApi(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `amount` | `String?` | Yes | Numeric Transaction Amount. |
| `authorization_number` | `String?` | No | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `String?` | Yes | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `String?` | Yes | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `String?` | No | Card Verification Code. |
| `desired_currency` | `String?` | No | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `String?` | No | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `String?` | No | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `String?` | No | Message type code. |
| `password` | `String?` | No | Password - currently not used (filled with spaces). |
| `payment_reason` | `String?` | No | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `List<Any?>?` | No | Payment reason represented as a byte array. |
| `personal_id` | `String?` | No | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `String?` | No | Receipt layout identifier. |
| `receipt_number` | `String?` | No | Receipt number. |
| `terminal_number` | `String?` | Yes | Terminal number provided by TECS. |
| `transaction_date_time` | `String?` | Yes | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `String?` | Yes | Unique transaction identifier. |
| `transaction_origin_identifier` | `String?` | No | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `String?` | No | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `String?` | No | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `String?` | No | Identification number of the authorization source. |

### Operations

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.ecrApi(null).create(mutableMapOf<String, Any?>(
    "amount" to "example_amount",  // String?
    "card_number" to "example_card_number",  // String?
    "currency" to "example_currency",  // String?
    "terminal_number" to "example_terminal_number",  // String?
    "transaction_date_time" to "example_transaction_date_time",  // String?
    "transaction_id" to "example_transaction_id"  // String?
), null)
```

#### `load(reqmatch, ctrl) -> Any?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```kotlin
val result = client.ecrApi(null).load(null, null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `EcrApi` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```kotlin
val feature = mutableMapOf<String, Any?>(
    "test" to mapOf("active" to true),
)
val client = BluefinTecsEcrSDK(mutableMapOf<String, Any?>("feature" to feature))
```

