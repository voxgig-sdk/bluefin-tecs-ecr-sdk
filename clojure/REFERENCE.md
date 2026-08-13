# BluefinTecsEcr Clojure SDK Reference

Complete API reference for the BluefinTecsEcr Clojure SDK.


## Client

### make-sdk

```clojure
(require '[sdk.api :as api]
         '[voxgig.struct :as vs])

(def client (api/make-sdk options))
```

Create a new SDK client instance. `options` is a `voxgig.struct` map.

**Options:**

| Key | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides (e.g. custom fetch). |


### Test client

#### `(api/test-sdk testopts sdkopts)`

Create a test client with mock features active. Both arguments may be `nil`.

```clojure
(def client (api/test-sdk nil nil))
```


### Client functions

#### `(api/ecr_api client data)`

Create a new `EcrApi` entity instance. Pass `nil` for no initial data.

#### `(api/options-map client) -> map`

Return a deep copy of the current SDK options.

#### `(api/get-utility client) -> utility`

Return a copy of the SDK utility object.

#### `(api/direct client fetchargs) -> map`

Make a direct HTTP request to any API endpoint. Returns a result `map` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `(vs/getprop result "ok")`.

**Fetch args:**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

**Returns:** a result `map`.

#### `(api/prepare client fetchargs) -> map`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## EcrApi

```clojure
(require '[sdk.entity.ecr_api :as e-ecr_api])

(def ecr_api (api/ecr_api client nil))
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
| `payment_reasonAsByte` | `vector` | No |  |
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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-ecr_api/create (api/ecr_api client nil)
    (vs/jm
      "amount" "example_amount"  ;; string
      "card_number" "example_card_number"  ;; string
      "currency" "example_currency"  ;; string
      "terminal_number" "example_terminal_number"  ;; string
      "transaction_date_time" "example_transaction_date_time"  ;; string
      "transaction_id" "example_transaction_id"  ;; string
      )
    nil))
```

#### `(load ent reqmatch ctrl) -> map`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```clojure
(def result (e-ecr_api/load (api/ecr_api client nil) nil nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `EcrApi` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```clojure
(def client
  (api/make-sdk
    (vs/jm "feature"
      (vs/jm
        "test" (vs/jm "active" true)
        ))))
```

