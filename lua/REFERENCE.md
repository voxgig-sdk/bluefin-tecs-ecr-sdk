# BluefinTecsEcr Lua SDK Reference

Complete API reference for the BluefinTecsEcr Lua SDK.


## BluefinTecsEcrSDK

### Constructor

```lua
local sdk = require("bluefin-tecs-ecr_sdk")
local client = sdk.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `table` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `table` | Custom headers for all requests. |
| `options.feature` | `table` | Feature configuration. |
| `options.system` | `table` | System overrides (e.g. custom fetch). |


### Static Methods

#### `sdk.test(testopts?, sdkopts?)`

Create a test client with mock features active. Both arguments are optional.

```lua
local client = sdk.test()
```


### Instance Methods

#### `EcrApi(data)`

Create a new `EcrApi` entity instance. Pass `nil` for no initial data.

#### `options_map() -> table`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> table, err`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs.params` | `table` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `table` | Query string parameters. |
| `fetchargs.headers` | `table` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (tables are JSON-serialized). |
| `fetchargs.ctrl` | `table` | Control options (e.g. `{ explain = true }`). |

**Returns:** `table, err`

#### `prepare(fetchargs) -> table, err`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `table, err`


---

## EcrApiEntity

```lua
local ecr_api = client:EcrApi(nil)
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
| `payment_reasonAsByte` | `table` | No |  |
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

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:EcrApi():create({
  amount = --[[ string ]],
  card_number = --[[ string ]],
  currency = --[[ string ]],
  terminal_number = --[[ string ]],
  transaction_date_time = --[[ string ]],
  transaction_id = --[[ string ]],
})
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:EcrApi():load()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `EcrApiEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```lua
local client = sdk.new({
  feature = {
    test = { active = true },
  },
})
```

