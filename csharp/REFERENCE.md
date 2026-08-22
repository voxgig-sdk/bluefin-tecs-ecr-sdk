# BluefinTecsEcr C# SDK Reference

Complete API reference for the BluefinTecsEcr C# SDK.


## BluefinTecsEcrSDK

### Constructor

```csharp
using BluefinTecsEcrSdk;

var client = new BluefinTecsEcrSDK(options);
```

Create a new SDK client instance. `options` is a
`Dictionary<string, object?>`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Dictionary` | SDK configuration options. |
| `options["apikey"]` | `string` | API key for authentication. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `Dictionary` | Custom headers for all requests. |
| `options["feature"]` | `Dictionary` | Feature configuration. |
| `options["system"]` | `Dictionary` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinTecsEcrSDK.TestSDK(testopts = null, sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```csharp
var client = BluefinTecsEcrSDK.TestSDK(null, null);
```


### Instance Methods

#### `EcrApi(entopts = null)`

Create a new `EcrApi` entity instance (returns
`BluefinTecsEcrEntityBase`). Pass `null` for no initial options.

#### `OptionsMap() -> Dictionary`

Return a deep copy of the current SDK options.

#### `GetUtility() -> Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs = null) -> Dictionary`

Make a direct HTTP request to any API endpoint. Returns a result
`Dictionary<string, object?>` with `ok`, `status`, `headers`, and `data`
(or `err` on failure). This escape hatch never raises — branch on
`result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Dictionary` | Path parameter values. |
| `fetchargs["query"]` | `Dictionary` | Query string parameters. |
| `fetchargs["headers"]` | `Dictionary` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `object?` | Request body (dictionaries are JSON-serialized). |

**Returns:** `Dictionary<string, object?>`

#### `Prepare(fetchargs = null) -> Dictionary`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## EcrApi

```csharp
var ecrApi = client.EcrApi();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `amount` | `string` | Yes | Numeric Transaction Amount. |
| `authorization_number` | `string` | No | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `string` | Yes | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `string` | Yes | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `string` | No | Card Verification Code. |
| `desired_currency` | `string` | No | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `string` | No | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `string` | No | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `string` | No | Message type code. |
| `password` | `string` | No | Password - currently not used (filled with spaces). |
| `payment_reason` | `string` | No | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `List<object?>` | No | Payment reason represented as a byte array. |
| `personal_id` | `string` | No | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `string` | No | Receipt layout identifier. |
| `receipt_number` | `string` | No | Receipt number. |
| `terminal_number` | `string` | Yes | Terminal number provided by TECS. |
| `transaction_date_time` | `string` | Yes | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `string` | Yes | Unique transaction identifier. |
| `transaction_origin_identifier` | `string` | No | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `string` | No | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `string` | No | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `string` | No | Identification number of the authorization source. |

### Operations

#### `Create(reqdata, ctrl = null) -> object?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```csharp
var result = client.EcrApi().Create(new Dictionary<string, object?>
{
    ["amount"] = "example_amount",  // string
    ["card_number"] = "example_card_number",  // string
    ["currency"] = "example_currency",  // string
    ["terminal_number"] = "example_terminal_number",  // string
    ["transaction_date_time"] = "example_transaction_date_time",  // string
    ["transaction_id"] = "example_transaction_id",  // string
});
```

#### `Load(reqmatch, ctrl = null) -> object?`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```csharp
var result = client.EcrApi().Load(null);
```

### Common Methods

#### `Data(newdata = null) -> object?`

Get or set the entity data.

#### `Match(newmatch = null) -> object?`

Get or set the entity match criteria.

#### `Make() -> IEntity`

Create a new `EcrApi` entity instance with the same options.

#### `GetName() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```csharp
var client = new BluefinTecsEcrSDK(new Dictionary<string, object?>
{
    ["feature"] = new Dictionary<string, object?>
    {
        ["test"] = new Dictionary<string, object?> { ["active"] = true },
    },
});
```

