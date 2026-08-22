# BluefinTecsEcr JavaScript SDK



The JavaScript SDK for the BluefinTecsEcr API — an entity-oriented client with full async/await support.

The API is exposed as capitalised, semantic **Entities** — e.g.
`client.EcrApi()` — each with a small set of operations (`load`, `create`)
instead of raw URL paths and query parameters. This keeps the surface
predictable and low-friction for both humans and AI agents.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
```js
npm install bluefin-tecs-ecr
```
## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.


### Create a Client

```js
const { BluefinTecsEcrSDK } = require('@voxgig-sdk/bluefin-tecs-ecr-js')

const client = new BluefinTecsEcrSDK({
  apikey: process.env.BLUEFIN_TECS_ECR_APIKEY,
})
```

### Load an EcrApi

```js
const ecr_api = await client.EcrApi().load()
console.log(ecr_api)
```

### Create a EcrApi

```js
const created = await client.EcrApi().create({
  amount: 'example_amount',
  card_number: 'example_card_number',
  currency: 'example_currency',
  terminal_number: 'example_terminal_number',
  transaction_date_time: 'example_transaction_date_time',
  transaction_id: 'example_transaction_id',
})
console.log(created)
```

### Direct API Access

Use `client.direct()` to call any API endpoint directly:

```js
const result = await client.direct({
  path: '/custom/endpoint/{id}',
  method: 'GET',
  params: { id: 'abc123' },
})

if (result.ok) {
  console.log(result.data)
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const ecrapi = await client.EcrApi().load()
  console.log(ecrapi)
} catch (err) {
  console.error('load failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```js
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})

if (result instanceof Error) {
  throw result
}
if (result.ok) {
  console.log(result.status)  // 200
  console.log(result.data)    // response body
}
```

### Prepare a request without sending it

```js
const fetchdef = await client.prepare({
  path: '/api/resource/{id}',
  method: 'DELETE',
  params: { id: 'example' },
})

// Inspect before sending
console.log(fetchdef.url)
console.log(fetchdef.method)
console.log(fetchdef.headers)
```

### Use test mode

Create a mock client for unit testing — no server required:

```js
const client = BluefinTecsEcrSDK.test()

const ecrapi = await client.EcrApi().load()
// ecrapi is the entity, populated with mock response data
// — call ecrapi.data() for the record itself
console.log(ecrapi)
```

You can also use the instance method:

```js
const client = new BluefinTecsEcrSDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```js
const entity = client.EcrApi()

// First call runs the operation and stores its result
await entity.load()

// Subsequent calls reuse the stored state
const data = entity.data()
console.log(data)
```

### Add custom middleware

Pass features via the `extend` option:

```js
const logger = {
  hooks: {
    PreRequest: (ctx) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx) => {
      console.log('Status:', ctx.out.request?.status)
    },
  },
}

const client = new BluefinTecsEcrSDK({
  apikey: '...',
  extend: [logger],
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_TECS_ECR_TEST_LIVE=TRUE
BLUEFIN_TECS_ECR_APIKEY=<your-key>
```

Then run:

```bash
cd js && npm test
```


## Reference

### BluefinTecsEcrSDK

#### Constructor

```js
new BluefinTecsEcrSDK(options?)
```

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `object` | Feature activation flags (e.g. `{ test: { active: true } }`). |
| `extend` | `Feature[]` | Additional feature instances to load. |

#### Methods

| Method | Returns | Description |
| --- | --- | --- |
| `options()` | `object` | Deep copy of current SDK options. |
| `utility()` | `Utility` | Deep copy of the SDK utility object. |
| `prepare(fetchargs?)` | `Promise<FetchDef>` | Build an HTTP request definition without sending it. |
| `direct(fetchargs?)` | `Promise<DirectResult>` | Build and send an HTTP request. |
| `EcrApi(data?)` | `EcrApiEntity` | Create an EcrApi entity instance. |
| `tester(testopts?, sdkopts?)` | `BluefinTecsEcrSDK` | Create a test-mode client instance. |

#### Static methods

| Method | Returns | Description |
| --- | --- | --- |
| `BluefinTecsEcrSDK.test(testopts?, sdkopts?)` | `BluefinTecsEcrSDK` | Create a test-mode client. |

### Entity interface

All entities share the same interface.

#### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `load(reqmatch?, ctrl?): Promise<Entity>` | Load a single entity by match criteria. |
| `create` | `create(reqdata?, ctrl?): Promise<Entity>` | Create a new entity. |
| `data` | `data(data?: Partial<Entity>): Entity` | Get or set entity data. |
| `match` | `match(match?: Partial<Entity>): Partial<Entity>` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): BluefinTecsEcrSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Return values

Entity operations resolve to the entity data directly — there is no
result envelope:

- `load` and `create` resolve to a single entity object.

On a failed request these methods **throw**, so wrap calls in
`try`/`catch` to handle errors. Only `direct()` returns the result
envelope described below.

### DirectResult shape

The `direct()` method returns:

```js
{
  ok: true,
  status: 200,
  headers: {},
  data: {}
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```js
{
  url: 'string',
  method: 'string',
  headers: {},
  body: undefined
}
```

### Entities

#### EcrApi

| Field | Description |
| --- | --- |
| `amount` | Numeric Transaction Amount. |
| `authorization_number` | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | Card Verification Code. |
| `desired_currency` | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | Message type code. |
| `password` | Password - currently not used (filled with spaces). |
| `payment_reason` | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | Payment reason represented as a byte array. |
| `personal_id` | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | Receipt layout identifier. |
| `receipt_number` | Receipt number. |
| `terminal_number` | Terminal number provided by TECS. |
| `transaction_date_time` | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | Unique transaction identifier. |
| `transaction_origin_identifier` | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | Identification number of the authorization source. |

Operations: create, load.

API path: `/makeTransaction`



## Entities


### EcrApi

Create an instance: `const ecr_api = client.EcrApi()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `amount` | `string` | Numeric Transaction Amount. |
| `authorization_number` | `string` | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `string` | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `string` | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `string` | Card Verification Code. |
| `desired_currency` | `string` | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `string` | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `string` | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `string` | Message type code. |
| `password` | `string` | Password - currently not used (filled with spaces). |
| `payment_reason` | `string` | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `Array` | Payment reason represented as a byte array. |
| `personal_id` | `string` | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `string` | Receipt layout identifier. |
| `receipt_number` | `string` | Receipt number. |
| `terminal_number` | `string` | Terminal number provided by TECS. |
| `transaction_date_time` | `string` | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `string` | Unique transaction identifier. |
| `transaction_origin_identifier` | `string` | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `string` | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `string` | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `string` | Identification number of the authorization source. |

#### Example: Load

```ts
const ecr_api = await client.EcrApi().load()
```

#### Example: Create

```ts
const ecr_api = await client.EcrApi().create({
  amount: 'example_amount',
  card_number: 'example_card_number',
  currency: 'example_currency',
  terminal_number: 'example_terminal_number',
  transaction_date_time: 'example_transaction_date_time',
  transaction_id: 'example_transaction_id',
})
```


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Module structure

```
bluefin-tecs-ecr/
├── src/
│   ├── BluefinTecsEcrSDK.js        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
└── test/                   # Test suites
```

Import the SDK from the package root:

```js
const { BluefinTecsEcrSDK } = require('@voxgig-sdk/bluefin-tecs-ecr-js')
```

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const ecrapi = client.EcrApi()
await ecrapi.load()

// ecrapi.data() now returns the ecrapi data from the last `load`
// ecrapi.match() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
