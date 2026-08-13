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
| `amount` | `string` | Yes |  |
| `authorization_number` | `string` | No |  |
| `card_number` | `string` | Yes |  |
| `currency` | `string` | Yes |  |
| `cvc2` | `string` | No |  |
| `desired_currency` | `string` | No |  |
| `ecr_data` | `string` | No |  |
| `language` | `string` | No |  |
| `message_type` | `string` | No |  |
| `password` | `string` | No |  |
| `payment_reason` | `string` | No |  |
| `payment_reasonAsByte` | `List<object?>` | No |  |
| `personal_id` | `string` | No |  |
| `receipt_layout` | `string` | No |  |
| `receipt_number` | `string` | No |  |
| `terminal_number` | `string` | Yes |  |
| `transaction_date_time` | `string` | Yes |  |
| `transaction_id` | `string` | Yes |  |
| `transaction_origin_identifier` | `string` | No |  |
| `transaction_origin_indicator` | `string` | No |  |
| `transaction_place` | `string` | No |  |
| `transaction_source_id` | `string` | No |  |

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

