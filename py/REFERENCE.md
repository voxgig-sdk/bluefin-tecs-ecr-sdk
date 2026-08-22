# BluefinTecsEcr Python SDK Reference

Complete API reference for the BluefinTecsEcr Python SDK.


## BluefinTecsEcrSDK

### Constructor

```python
from bluefintecsecr_sdk import BluefinTecsEcrSDK

client = BluefinTecsEcrSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinTecsEcrSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = BluefinTecsEcrSDK.test()
```


### Instance Methods

#### `EcrApi(data=None)`

Create a new `EcrApiEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> dict`

Make a direct HTTP request to any API endpoint. Returns a result `dict` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `result_dict`

#### `prepare(fetchargs=None) -> dict`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## EcrApiEntity

```python
ecr_api = client.EcrApi()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `amount` | `str` | Yes | Numeric Transaction Amount. |
| `authorization_number` | `str` | No | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `str` | Yes | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `str` | Yes | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `str` | No | Card Verification Code. |
| `desired_currency` | `str` | No | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `str` | No | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `str` | No | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `str` | No | Message type code. |
| `password` | `str` | No | Password - currently not used (filled with spaces). |
| `payment_reason` | `str` | No | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `list` | No | Payment reason represented as a byte array. |
| `personal_id` | `str` | No | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `str` | No | Receipt layout identifier. |
| `receipt_number` | `str` | No | Receipt number. |
| `terminal_number` | `str` | Yes | Terminal number provided by TECS. |
| `transaction_date_time` | `str` | Yes | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `str` | Yes | Unique transaction identifier. |
| `transaction_origin_identifier` | `str` | No | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `str` | No | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `str` | No | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `str` | No | Identification number of the authorization source. |

### Operations

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.EcrApi().create({
    "amount": "example_amount",  # str
    "card_number": "example_card_number",  # str
    "currency": "example_currency",  # str
    "terminal_number": "example_terminal_number",  # str
    "transaction_date_time": "example_transaction_date_time",  # str
    "transaction_id": "example_transaction_id",  # str
})
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.EcrApi().load()
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `EcrApiEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```python
client = BluefinTecsEcrSDK({
    "feature": {
        "test": {"active": True},
    },
})
```

