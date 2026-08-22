# BluefinTecsEcr JavaScript SDK Reference

Complete API reference for the BluefinTecsEcr JavaScript SDK.


## BluefinTecsEcrSDK

### Constructor

```ts
new BluefinTecsEcrSDK(options?: object)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `object` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `object` | Custom headers for all requests. |
| `options.feature` | `object` | Feature configuration. |
| `options.system` | `object` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinTecsEcrSDK.test(testopts?, sdkopts?)`

Create a test client with mock features active.

```ts
const client = BluefinTecsEcrSDK.test()
```

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `testopts` | `object` | Test feature options. |
| `sdkopts` | `object` | Additional SDK options merged with test defaults. |

**Returns:** `BluefinTecsEcrSDK` instance in test mode.


### Instance Methods

#### `EcrApi(data?: object)`

Create a new `EcrApi` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `EcrApiEntity` instance.

#### `options()`

Return a deep copy of the current SDK options.

**Returns:** `object`

#### `utility()`

Return a copy of the SDK utility object.

**Returns:** `object`

#### `direct(fetchargs?: object)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `GET`). |
| `fetchargs.params` | `object` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `object` | Query string parameters. |
| `fetchargs.headers` | `object` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (objects are JSON-serialized). |
| `fetchargs.ctrl` | `object` | Control options (e.g. `{ explain: true }`). |

**Returns:** `Promise<{ ok, status, headers, data } | Error>`

#### `prepare(fetchargs?: object)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `Promise<{ url, method, headers, body } | Error>`

#### `tester(testopts?, sdkopts?)`

Alias for `BluefinTecsEcrSDK.test()`.

**Returns:** `BluefinTecsEcrSDK` instance in test mode.


---

## EcrApiEntity

```ts
const ecr_api = client.EcrApi()
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
| `payment_reasonAsByte` | `Array` | No | Payment reason represented as a byte array. |
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.EcrApi().create({
  amount: 'example_amount',
  card_number: 'example_card_number',
  currency: 'example_currency',
  terminal_number: 'example_terminal_number',
  transaction_date_time: 'example_transaction_date_time',
  transaction_id: 'example_transaction_id',
})
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.EcrApi().load()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `EcrApiEntity` instance with the same client and
options.

#### `client()`

Return the parent `BluefinTecsEcrSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ts
const client = new BluefinTecsEcrSDK({
  feature: {
    test: { active: true },
  }
})
```

