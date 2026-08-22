# BluefinTecsEcr Ruby SDK Reference

Complete API reference for the BluefinTecsEcr Ruby SDK.


## BluefinTecsEcrSDK

### Constructor

```ruby
require_relative 'BluefinTecsEcr_sdk'

client = BluefinTecsEcrSDK.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Hash` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Hash` | Custom headers for all requests. |
| `options["feature"]` | `Hash` | Feature configuration. |
| `options["system"]` | `Hash` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinTecsEcrSDK.test(testopts = nil, sdkopts = nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```ruby
client = BluefinTecsEcrSDK.test
```


### Instance Methods

#### `EcrApi(data = nil)`

Create a new `EcrApi` entity instance. Pass `nil` for no initial data.

#### `options_map -> Hash`

Return a deep copy of the current SDK options.

#### `get_utility -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs = {}) -> Hash`

Make a direct HTTP request to any API endpoint. Returns a result hash
(`{ "ok" => ..., "status" => ..., "data" => ..., "err" => ... }`); it
does not raise — inspect `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Hash` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `Hash` | Query string parameters. |
| `fetchargs["headers"]` | `Hash` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (hashes are JSON-serialized). |
| `fetchargs["ctrl"]` | `Hash` | Control options (e.g. `{ "explain" => true }`). |

**Returns:** `Hash`

#### `prepare(fetchargs = {}) -> Hash`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`. Raises on error.

**Returns:** `Hash` (the fetch definition; raises on error)


---

## EcrApiEntity

```ruby
ecr_api = client.EcrApi
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
| `payment_reasonAsByte` | `Array` | No | Payment reason represented as a byte array. |
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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.EcrApi.create({
  "amount" => "example_amount", # String
  "card_number" => "example_card_number", # String
  "currency" => "example_currency", # String
  "terminal_number" => "example_terminal_number", # String
  "transaction_date_time" => "example_transaction_date_time", # String
  "transaction_id" => "example_transaction_id", # String
})
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.EcrApi.load()
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `EcrApiEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ruby
client = BluefinTecsEcrSDK.new({
  "feature" => {
    "test" => { "active" => true },
  },
})
```

