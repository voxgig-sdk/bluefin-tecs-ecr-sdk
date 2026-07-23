# BluefinTecsEcr OCaml SDK Reference

Complete API reference for the BluefinTecsEcr OCaml SDK.


## Sdk_client

### Constructor

```ocaml
open Voxgig_struct
open Sdk_helpers

let client = Sdk_client.make options
```

Create a new SDK client instance from a `value` options map. Use
`Sdk_client.make0 ()` for defaults.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `value` | SDK configuration options (a Map). |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides (e.g. custom fetch). |


### Static constructors

#### `Sdk_client.test testopts sdkopts`

Create a test client with mock features active. Both arguments may be `Noval`
(`Sdk_client.test ()` uses defaults, `Sdk_client.test_with` takes explicit
options).

```ocaml
let client = Sdk_client.test ()
```


### Instance functions

#### `Sdk_client.ecr_api client entopts : entity_obj`

Create a `EcrApi` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.direct client fetchargs : value`

Make a direct HTTP request to any API endpoint. Returns a result `value` map
with `ok`, `status`, `headers`, and `data` (or `err` on failure). This
escape hatch never raises — branch on `getp result "ok"`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `value` | Request body (Maps are JSON-serialized). |

**Returns:** a result `value` map.

#### `Sdk_client.prepare client fetchargs : value`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises
on error.


---

## EcrApi

```ocaml
let ecr_api = Sdk_client.ecr_api client Noval
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
| `payment_reason_as_byte` | `value list` | No |  |
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

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.ecr_api client Noval).e_create (jo [
    ("amount", (Str "example_amount"));  (* string *)
    ("card_number", (Str "example_card_number"));  (* string *)
    ("currency", (Str "example_currency"));  (* string *)
    ("terminal_number", (Str "example_terminal_number"));  (* string *)
    ("transaction_date_time", (Str "example_transaction_date_time"));  (* string *)
    ("transaction_id", (Str "example_transaction_id"));  (* string *)
]) Noval
```

#### `e_load reqmatch ctrl : value`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```ocaml
let result = (Sdk_client.ecr_api client Noval).e_load (Noval) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `EcrApi` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ocaml
let client = Sdk_client.make (jo [
    ("feature", jo [
        ("test", jo [("active", Bool true)]);
    ]);
])
```

