# BluefinTecsEcr TypeScript SDK



The TypeScript SDK for the BluefinTecsEcr API — a type-safe, entity-oriented client with full async/await support.

The API is exposed as capitalised, semantic **Entities** — e.g.
`client.EcrApi()` — each with a small set of operations (`load`, `create`)
instead of raw URL paths and query parameters. This keeps the surface
predictable and low-friction for both humans and AI agents.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to npm. Install it from the GitHub
release tag (`ts/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/releases](https://github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ts
import { BluefinTecsEcrSDK } from '@voxgig-sdk/bluefin-tecs-ecr'

const client = new BluefinTecsEcrSDK({
  apikey: process.env.BLUEFIN_TECS_ECR_APIKEY,
})
```

### 3. Load an ecrapi

`load()` returns the entity directly and throws on failure:

```ts
try {
  const ecrapi = await client.EcrApi().load()
  console.log(ecrapi)
} catch (err) {
  console.error('load failed:', err)
}
```

### 4. Create, update, and remove

```ts
// Create — returns the created EcrApi ENTITY (.data() for the record)
const created = await client.EcrApi().create({
  amount: 'example_amount',
  card_number: 'example_card_number',
  currency: 'example_currency',
  terminal_number: 'example_terminal_number',
  transaction_date_time: 'example_transaction_date_time',
  transaction_id: 'example_transaction_id',
})

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

```ts
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

```ts
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

```ts
const client = BluefinTecsEcrSDK.test()

const ecrapi = await client.EcrApi().load()
// ecrapi is the entity, populated with mock response data
// — call ecrapi.data() for the record itself
console.log(ecrapi)
```

You can also use the instance method:

```ts
const client = new BluefinTecsEcrSDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.EcrApi()

// First call runs the operation and stores its result
await entity.load()

// Subsequent calls reuse the stored state
const data = entity.data()
console.log(data)
```

### Add custom middleware

Pass features via the `extend` option:

```ts
const logger = {
  hooks: {
    PreRequest: (ctx: any) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx: any) => {
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
cd ts && npm test
```


## Reference

### BluefinTecsEcrSDK

#### Constructor

```ts
new BluefinTecsEcrSDK(options?: {
  apikey?: string
  base?: string
  prefix?: string
  suffix?: string
  feature?: Record<string, { active: boolean }>
  extend?: Feature[]
})
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

```ts
{
  ok: boolean
  status: number
  headers: object
  data: any
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```ts
{
  url: string
  method: string
  headers: Record<string, string>
  body?: any
}
```

### Entities

#### EcrApi

| Field | Description |
| --- | --- |
| `amount` |  |
| `authorization_number` |  |
| `card_number` |  |
| `currency` |  |
| `cvc2` |  |
| `desired_currency` |  |
| `ecr_data` |  |
| `language` |  |
| `message_type` |  |
| `password` |  |
| `payment_reason` |  |
| `payment_reasonAsByte` |  |
| `personal_id` |  |
| `receipt_layout` |  |
| `receipt_number` |  |
| `terminal_number` |  |
| `transaction_date_time` |  |
| `transaction_id` |  |
| `transaction_origin_identifier` |  |
| `transaction_origin_indicator` |  |
| `transaction_place` |  |
| `transaction_source_id` |  |

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
| `amount` | `string` |  |
| `authorization_number` | `string` |  |
| `card_number` | `string` |  |
| `currency` | `string` |  |
| `cvc2` | `string` |  |
| `desired_currency` | `string` |  |
| `ecr_data` | `string` |  |
| `language` | `string` |  |
| `message_type` | `string` |  |
| `password` | `string` |  |
| `payment_reason` | `string` |  |
| `payment_reasonAsByte` | `any[]` |  |
| `personal_id` | `string` |  |
| `receipt_layout` | `string` |  |
| `receipt_number` | `string` |  |
| `terminal_number` | `string` |  |
| `transaction_date_time` | `string` |  |
| `transaction_id` | `string` |  |
| `transaction_origin_identifier` | `string` |  |
| `transaction_origin_indicator` | `string` |  |
| `transaction_place` | `string` |  |
| `transaction_source_id` | `string` |  |

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
│   ├── BluefinTecsEcrSDK.ts        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
├── test/                   # Test suites
└── dist/                   # Compiled output
```

Import the SDK from the package root:

```ts
import { BluefinTecsEcrSDK } from '@voxgig-sdk/bluefin-tecs-ecr'
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
