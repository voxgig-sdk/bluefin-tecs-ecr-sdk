# BluefinTecsEcr C++ SDK Reference

Complete API reference for the BluefinTecsEcr C++ SDK.


## BluefinTecsEcrSDK

### Constructor

```cpp
#include "core/sdk.hpp"

using namespace sdk;

auto client = std::make_shared<BluefinTecsEcrSDK>(options);
```

Create a new SDK client instance. `options` is an `sdk::Value` map.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Value` | SDK configuration options (a map). |
| `options["apikey"]` | `std::string` | API key for authentication. |
| `options["base"]` | `std::string` | Base URL for API requests. |
| `options["prefix"]` | `std::string` | URL prefix appended after base. |
| `options["suffix"]` | `std::string` | URL suffix appended after path. |
| `options["headers"]` | `Value` | Custom headers for all requests. |
| `options["feature"]` | `Value` | Feature configuration. |
| `options["system"]` | `Value` | System overrides. |


### Static Methods

#### `BluefinTecsEcrSDK::testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be
`Value::undef()`; a no-arg overload is also provided.

```cpp
auto client = BluefinTecsEcrSDK::testSDK();
```


### Instance Methods

#### `ecr_api(entopts = Value::undef()) -> std::shared_ptr<EcrApiEntity>`

Create a new `EcrApiEntity` instance bound to this client.

#### `optionsMap() -> Value`

Return a deep copy of the current SDK options.

#### `getUtility() -> UtilityPtr`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Value`

Make a direct HTTP request to any API endpoint. Returns a result `Value` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never throws — branch on `getp(result, "ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `std::string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `std::string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Value` | Path parameter values. |
| `fetchargs["query"]` | `Value` | Query string parameters. |
| `fetchargs["headers"]` | `Value` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Value` | Request body (maps are JSON-serialized). |

**Returns:** `Value` (result map)

#### `prepare(fetchargs) -> Value`

Prepare a fetch definition without sending. Returns the `fetchdef` and throws on error.


---

## EcrApiEntity

```cpp
auto ecr_api = client->ecr_api();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `amount` | `std::string` | Yes | Numeric Transaction Amount. |
| `authorization_number` | `std::string` | No | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `std::string` | Yes | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `std::string` | Yes | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `std::string` | No | Card Verification Code. |
| `desired_currency` | `std::string` | No | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `std::string` | No | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `std::string` | No | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `std::string` | No | Message type code. |
| `password` | `std::string` | No | Password - currently not used (filled with spaces). |
| `payment_reason` | `std::string` | No | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `std::vector<Value>` | No | Payment reason represented as a byte array. |
| `personal_id` | `std::string` | No | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `std::string` | No | Receipt layout identifier. |
| `receipt_number` | `std::string` | No | Receipt number. |
| `terminal_number` | `std::string` | Yes | Terminal number provided by TECS. |
| `transaction_date_time` | `std::string` | Yes | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `std::string` | Yes | Unique transaction identifier. |
| `transaction_origin_identifier` | `std::string` | No | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `std::string` | No | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `std::string` | No | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `std::string` | No | Identification number of the authorization source. |

### Operations

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->ecr_api()->create(vmap({
    {"amount", Value("example_amount")},  // std::string
    {"card_number", Value("example_card_number")},  // std::string
    {"currency", Value("example_currency")},  // std::string
    {"terminal_number", Value("example_terminal_number")},  // std::string
    {"transaction_date_time", Value("example_transaction_date_time")},  // std::string
    {"transaction_id", Value("example_transaction_id")},  // std::string
}), Value::undef());
```

#### `load(reqmatch, ctrl) -> Value`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```cpp
Value result = client->ecr_api()->load(Value::undef(), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `EcrApiEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```cpp
auto client = std::make_shared<BluefinTecsEcrSDK>(vmap({
    {"feature", vmap({
        {"test", vmap({{"active", Value(true)}})},
    })},
}));
```

