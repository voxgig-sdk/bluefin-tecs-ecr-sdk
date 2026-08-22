# BluefinTecsEcr C SDK Reference

Complete API reference for the BluefinTecsEcr C SDK.


## BluefinTecsEcrSDK

### Constructor

```c
#include "core/api.h"

BluefinTecsEcrSDK* client = bluefintecsecr_sdk_new(options);
```

Create a new SDK client instance. `options` is a `voxgig_value*` map
(`NULL` for none).

**Parameters (`options` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides. |


### Test Constructor

#### `BluefinTecsEcrSDK* test_sdk(voxgig_value* testopts, voxgig_value* sdkopts)`

Create a test client with mock features active. Both arguments may be
`NULL`.

```c
BluefinTecsEcrSDK* client = test_sdk(NULL, NULL);
```


### Entity Accessors

#### `Entity* bluefintecsecr_ecr_api(BluefinTecsEcrSDK* client, voxgig_value* entopts)`

Create a new `EcrApi` entity instance. Pass `NULL` for no initial
options.

#### `voxgig_value* sdk_direct(BluefinTecsEcrSDK* client, voxgig_value* fetchargs, PNError** err)`

Make a direct HTTP request to any API endpoint. Returns a result map with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never sets `*err` for a non-2xx response — branch on
`getp(result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `voxgig_value* sdk_prepare(BluefinTecsEcrSDK* client, voxgig_value* fetchargs, PNError** err)`

Prepare a fetch definition without sending. Returns the fetchdef and sets
`*err` on failure.


---

## EcrApi

```c
Entity* ecr_api = bluefintecsecr_ecr_api(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `amount` | `char*` | Yes | Numeric Transaction Amount. |
| `authorization_number` | `char*` | No | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `char*` | Yes | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `char*` | Yes | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `char*` | No | Card Verification Code. |
| `desired_currency` | `char*` | No | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `char*` | No | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `char*` | No | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `char*` | No | Message type code. |
| `password` | `char*` | No | Password - currently not used (filled with spaces). |
| `payment_reason` | `char*` | No | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `voxgig_value* (list)` | No | Payment reason represented as a byte array. |
| `personal_id` | `char*` | No | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `char*` | No | Receipt layout identifier. |
| `receipt_number` | `char*` | No | Receipt number. |
| `terminal_number` | `char*` | Yes | Terminal number provided by TECS. |
| `transaction_date_time` | `char*` | Yes | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `char*` | Yes | Unique transaction identifier. |
| `transaction_origin_identifier` | `char*` | No | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `char*` | No | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `char*` | No | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `char*` | No | Identification number of the authorization source. |

### Operations

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* ecr_api = bluefintecsecr_ecr_api(client, NULL);
voxgig_value* result = ecr_api->vt->create(ecr_api, cmap(6,
    "amount", v_str("example_amount"),  // char*
    "card_number", v_str("example_card_number"),  // char*
    "currency", v_str("example_currency"),  // char*
    "terminal_number", v_str("example_terminal_number"),  // char*
    "transaction_date_time", v_str("example_transaction_date_time"),  // char*
    "transaction_id", v_str("example_transaction_id"))  // char*
, NULL, &err);
```

#### `vt->load(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

Load a single entity matching the given criteria. Returns the entity data and sets `*err` on failure.

```c
Entity* ecr_api = bluefintecsecr_ecr_api(client, NULL);
voxgig_value* result = ecr_api->vt->load(ecr_api, NULL, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `EcrApi` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```c
BluefinTecsEcrSDK* client = bluefintecsecr_sdk_new(cmap(1,
    "feature", cmap(1,
        "test", cmap(1, "active", v_bool(true)))
));
```

