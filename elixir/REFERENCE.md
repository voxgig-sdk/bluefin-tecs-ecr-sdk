# BluefinTecsEcr Elixir SDK Reference

Complete API reference for the BluefinTecsEcr Elixir SDK.


## BluefinTecsEcr

### Constructor

```elixir
sdk = BluefinTecsEcr.new(options)
```

Create a new SDK client. `options` is a struct value node — build one from a
native map with `BluefinTecsEcr.Helpers.deep/1`.

**Options:**

| Name | Type | Description |
| --- | --- | --- |
| `apikey` | `String.t()` | API key for authentication. |
| `base` | `String.t()` | Base URL for API requests. |
| `prefix` | `String.t()` | URL prefix appended after base. |
| `suffix` | `String.t()` | URL suffix appended after path. |
| `headers` | `map()` | Custom headers for all requests. |
| `feature` | `map()` | Feature configuration. |
| `system` | `map()` | System overrides (e.g. custom fetch). |


### Constructors

#### `BluefinTecsEcr.test(testopts \\ nil, sdkopts \\ nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```elixir
sdk = BluefinTecsEcr.test()
```


### Functions

#### `BluefinTecsEcr.ecr_api(client, entopts \\ nil)`

Create a `BluefinTecsEcr.Entity.EcrApi` handle.

#### `options_map(client) :: map()`

Return a deep copy of the current SDK options.

#### `get_utility(client) :: map()`

Return the SDK utility node.

#### `direct(client, fetchargs) :: map()`

Make a direct HTTP request to any API endpoint. Returns a result node with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never raises — branch on `Voxgig.Struct.getprop(result, "ok")`.

**fetchargs keys:**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `String.t()` | URL path with optional `{param}` placeholders. |
| `method` | `String.t()` | HTTP method (default: `"GET"`). |
| `params` | `map()` | Path parameter values. |
| `query` | `map()` | Query string parameters. |
| `headers` | `map()` | Request headers (merged with defaults). |
| `body` | `any()` | Request body (maps are JSON-serialized). |

#### `prepare(client, fetchargs) :: map()`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises
on error.


---

## BluefinTecsEcr.Entity.EcrApi

```elixir
ecr_api = BluefinTecsEcr.ecr_api(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `amount` | `String.t()` | Yes | Numeric Transaction Amount. |
| `authorization_number` | `String.t()` | No | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `String.t()` | Yes | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `String.t()` | Yes | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `String.t()` | No | Card Verification Code. |
| `desired_currency` | `String.t()` | No | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `String.t()` | No | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `String.t()` | No | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `String.t()` | No | Message type code. |
| `password` | `String.t()` | No | Password - currently not used (filled with spaces). |
| `payment_reason` | `String.t()` | No | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `list()` | No | Payment reason represented as a byte array. |
| `personal_id` | `String.t()` | No | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `String.t()` | No | Receipt layout identifier. |
| `receipt_number` | `String.t()` | No | Receipt number. |
| `terminal_number` | `String.t()` | Yes | Terminal number provided by TECS. |
| `transaction_date_time` | `String.t()` | Yes | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `String.t()` | Yes | Unique transaction identifier. |
| `transaction_origin_identifier` | `String.t()` | No | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `String.t()` | No | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `String.t()` | No | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `String.t()` | No | Identification number of the authorization source. |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = BluefinTecsEcr.Entity.EcrApi.create(ecr_api, BluefinTecsEcr.Helpers.deep(%{
  "amount" => "example_amount",  # String.t()
  "card_number" => "example_card_number",  # String.t()
  "currency" => "example_currency",  # String.t()
  "terminal_number" => "example_terminal_number",  # String.t()
  "transaction_date_time" => "example_transaction_date_time",  # String.t()
  "transaction_id" => "example_transaction_id",  # String.t()
}))
```

#### `load(entity, reqmatch, ctrl \\ nil) :: map()`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```elixir
record = BluefinTecsEcr.Entity.EcrApi.load(ecr_api, BluefinTecsEcr.Helpers.deep(%{}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `BluefinTecsEcr.Entity.EcrApi` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```elixir
sdk = BluefinTecsEcr.new(BluefinTecsEcr.Helpers.deep(%{
  "feature" => %{
    "test" => %{"active" => true},
  }
}))
```

