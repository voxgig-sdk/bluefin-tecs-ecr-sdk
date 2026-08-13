# BluefinTecsEcr C++ SDK



The C++ SDK for the BluefinTecsEcr API — a header-only,
entity-oriented client following idiomatic modern C++ (C++17) conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client->ecr_api()` — each
carrying a small, uniform set of operations (`load`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low. Every value flows through a single dynamic
`sdk::Value` type (a JSON-like variant), so there is no schema-driven code to
regenerate when the API changes.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
The C++ SDK is **header-only** — there is no package to install
from a registry. Vendor the `cpp/` directory into your project (or add the
repository as a git submodule) and put it on your compiler's include path.
Releases are cut as the git tag `cpp/vX.Y.Z` (see
[Releases](https://github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/releases)).

```bash
# Add the SDK as a submodule (or copy the cpp/ directory into your tree).
git submodule add <repo-url> third_party/bluefintecsecr-sdk
```

Then include the umbrella header and compile with C++17:

```cpp
#include "core/sdk.hpp"
```

```bash
g++ -std=c++17 -Ithird_party/bluefintecsecr-sdk/cpp your_app.cpp -o your_app
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```cpp
#include <cstdlib>
#include "core/sdk.hpp"

using namespace sdk;

const char* apikey = std::getenv("BLUEFIN_TECS_ECR_APIKEY");
auto client = std::make_shared<BluefinTecsEcrSDK>(vmap({
    {"apikey", Value(apikey ? apikey : "")},
}));
```

### 3. Load an ecrapi

`load()` returns the bare record and throws on error.

```cpp
try {
  Value ecr_api = client->ecr_api()->load(Value::undef(), Value::undef());
  std::cout << Struct::jsonify(ecr_api) << std::endl;
} catch (const SdkErrorPtr& err) {
  std::cerr << "load failed: " << err->msg << std::endl;
}
```

### 4. Create, update, and remove

```cpp
// Create — returns the bare created record.
Value created = client->ecr_api()->create(vmap({{"amount", Value("example_amount")}, {"card_number", Value("example_card_number")}, {"currency", Value("example_currency")}, {"terminal_number", Value("example_terminal_number")}, {"transaction_date_time", Value("example_transaction_date_time")}, {"transaction_id", Value("example_transaction_id")}}), Value::undef());

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

```cpp
Value result = client->direct(vmap({
    {"path", Value("/api/resource/{id}")},
    {"method", Value("GET")},
    {"params", vmap({{"id", Value("example")}})},
}));

if (getp(result, "ok") == Value(true)) {
  std::cout << Helpers::toInt(getp(result, "status")) << std::endl;  // 200
  std::cout << Struct::jsonify(getp(result, "data")) << std::endl;   // response body
} else {
  // A non-2xx response carries status + data (the error body); a
  // transport-level failure carries err instead. Only one is present.
  std::cerr << Helpers::toInt(getp(result, "status")) << " "
            << Struct::jsonify(getp(result, "err")) << std::endl;
}
```

`direct()` is the escape hatch: it never throws — branch on
`getp(result, "ok")`.

### Prepare a request without sending it

```cpp
// prepare() returns the fetch definition and throws on error.
Value fetchdef = client->prepare(vmap({
    {"path", Value("/api/resource/{id}")},
    {"method", Value("DELETE")},
    {"params", vmap({{"id", Value("example")}})},
}));

std::cout << Struct::stringify(getp(fetchdef, "url")) << std::endl;
std::cout << Struct::stringify(getp(fetchdef, "method")) << std::endl;
std::cout << Struct::jsonify(getp(fetchdef, "headers")) << std::endl;
```

### Use test mode

Create a mock client for unit testing — no server required. The test
feature installs an in-memory mock transport:

```cpp
auto client = BluefinTecsEcrSDK::testSDK();

// Entity ops return the bare record and throw on error.
Value ecr_api = client->ecr_api()->load(Value::undef(), Value::undef());
// ecr_api contains the mock response record
std::cout << Struct::jsonify(ecr_api) << std::endl;
```

You can seed the mock store by passing test options — see the generated
`test/` suite for worked examples.

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_TECS_ECR_TEST_LIVE=TRUE
BLUEFIN_TECS_ECR_APIKEY=<your-key>
```

Then build and run the test suite:

```bash
cd cpp && make test
```


## Reference

### BluefinTecsEcrSDK

```cpp
#include "core/sdk.hpp"

using namespace sdk;

auto client = std::make_shared<BluefinTecsEcrSDK>(options);
```

Creates a new SDK client. `options` is an `sdk::Value` map.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `std::string` | API key for authentication. |
| `base` | `std::string` | Base URL of the API server. |
| `prefix` | `std::string` | URL path prefix prepended to all requests. |
| `suffix` | `std::string` | URL path suffix appended to all requests. |
| `feature` | `Value` | Feature activation flags. |
| `system` | `Value` | System overrides. |

### testSDK

```cpp
auto client = BluefinTecsEcrSDK::testSDK(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`Value::undef()`; a no-arg `BluefinTecsEcrSDK::testSDK()` overload is
also provided.

### BluefinTecsEcrSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> Value` | Deep copy of current SDK options. |
| `getUtility` | `() -> UtilityPtr` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Value` | Build an HTTP request definition without sending. Throws on error. |
| `direct` | `(fetchargs) -> Value` | Build and send an HTTP request. Returns a result Value (branch on `ok`). |
| `ecr_api` | `(entopts) -> std::shared_ptr<EcrApiEntity>` | Create an EcrApi entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> Value` | Load a single entity by match criteria. Throws on error. |
| `create` | `(reqdata, ctrl) -> Value` | Create a new entity. Throws on error. |
| `data` | `(arg) -> Value` | Get (no arg) or set (with arg) entity data. |
| `match` | `(arg) -> Value` | Get (no arg) or set (with arg) entity match criteria. |
| `make` | `() -> EntityPtr` | Create a new instance with the same options. |
| `getName` | `() -> std::string` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a map `Value` for
single-entity ops, a list `Value` for `list`) and throw
`sdk::SdkErrorPtr` on error. Wrap calls in `try`/`catch` to handle
failures.

The `direct()` escape hatch never throws — it returns a result `Value`
you branch on via `getp(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Value` | Response headers. |
| `data` | `Value` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

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

Operations: Create, Load.

API path: `/makeTransaction`



## Entities


### EcrApi

Create an instance: `auto ecr_api = client->ecr_api();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `amount` | `std::string` |  |
| `authorization_number` | `std::string` |  |
| `card_number` | `std::string` |  |
| `currency` | `std::string` |  |
| `cvc2` | `std::string` |  |
| `desired_currency` | `std::string` |  |
| `ecr_data` | `std::string` |  |
| `language` | `std::string` |  |
| `message_type` | `std::string` |  |
| `password` | `std::string` |  |
| `payment_reason` | `std::string` |  |
| `payment_reasonAsByte` | `std::vector<Value>` |  |
| `personal_id` | `std::string` |  |
| `receipt_layout` | `std::string` |  |
| `receipt_number` | `std::string` |  |
| `terminal_number` | `std::string` |  |
| `transaction_date_time` | `std::string` |  |
| `transaction_id` | `std::string` |  |
| `transaction_origin_identifier` | `std::string` |  |
| `transaction_origin_indicator` | `std::string` |  |
| `transaction_place` | `std::string` |  |
| `transaction_source_id` | `std::string` |  |

#### Example: Load

```cpp
Value ecr_api = client->ecr_api()->load(Value::undef(), Value::undef());
```

#### Example: Create

```cpp
Value ecr_api = client->ecr_api()->create(vmap({
    {"amount", Value("example_amount")},  // std::string
    {"card_number", Value("example_card_number")},  // std::string
    {"currency", Value("example_currency")},  // std::string
    {"terminal_number", Value("example_terminal_number")},  // std::string
    {"transaction_date_time", Value("example_transaction_date_time")},  // std::string
    {"transaction_id", Value("example_transaction_id")},  // std::string
}), Value::undef());
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

### Data as `Value`

The C++ SDK uses a single dynamic `sdk::Value` type (a JSON-like variant
over string / number / bool / list / map) throughout rather than generated
typed structs. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema changes.

Build maps with `sdk::vmap({{"key", sdk::Value("v")}})` and lists with
`sdk::vlist({...})`; read fields back with `sdk::getp(value, "key")`. Use
`sdk::to_map()` to safely coerce a value that should be a map, and
`sdk::Struct::jsonify(value)` to render it as JSON.

### Directory structure

```
cpp/
├── core/                        -- Runtime type graph, config, generated client
├── entity/                      -- Per-entity client headers
├── feature/                     -- Built-in features (Base, Test, Log, ...)
├── utility/                     -- Operation pipeline + vendored struct library
├── test/                        -- Test suites
├── Makefile                     -- Build & run the tests (C++17)
└── VERSION                      -- SDK version
```

Include the umbrella header `core/sdk.hpp` to pull in the whole SDK: the
runtime types, the pipeline utilities, the vendored struct, the generated
config, the per-entity clients and the generated `BluefinTecsEcrSDK`
client class. Everything lives in the `sdk` namespace.

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
