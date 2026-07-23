# BluefinTecsEcr Dart SDK



The Dart SDK for the BluefinTecsEcr API — an entity-oriented client following idiomatic Dart conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.EcrApi()` — each
carrying a small, uniform set of operations (`load`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to pub.dev. Add it as a git
dependency (pinned to a release tag `dart/vX.Y.Z`, see
[Releases](https://github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/releases)) in your `pubspec.yaml`:

```yaml
dependencies:
  bluefin_tecs_ecr_sdk:
    git:
      url: https://github.com/voxgig-sdk/bluefin-tecs-ecr-sdk
      path: dart
      ref: dart/v0.0.1
```

Or depend on a local source checkout:

```yaml
dependencies:
  bluefin_tecs_ecr_sdk:
    path: ../dart
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```dart
import 'dart:io';
import 'package:bluefin_tecs_ecr_sdk/BluefinTecsEcrSDK.dart';

final client = BluefinTecsEcrSDK({
  'apikey': Platform.environment['BLUEFIN_TECS_ECR_APIKEY'],
});
```

### 3. Load an ecrapi

`load()` returns the bare record (a `Map`) and throws on error.

```dart
try {
  final ecrapi = await client.EcrApi().load();
  print(ecrapi);
} catch (err) {
  print('load failed: $err');
}
```

### 4. Create, update, and remove

```dart
// Create — returns the bare created record (a Map)
final created = await client.EcrApi().create({'amount': 'example_amount', 'card_number': 'example_card_number', 'currency': 'example_currency', 'terminal_number': 'example_terminal_number', 'transaction_date_time': 'example_transaction_date_time', 'transaction_id': 'example_transaction_id'});

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

```dart
final result = await client.direct({
  'path': '/api/resource/{id}',
  'method': 'GET',
  'params': {'id': 'example'},
});

if (true == result['ok']) {
  print(result['status']);  // 200
  print(result['data']);    // response body
} else {
  // A non-2xx response carries status + data (the error body); a
  // transport-level failure carries err instead. direct() never throws —
  // branch on result['ok'].
  print(result['status']);
  print(result['err']);
}
```

### Prepare a request without sending it

```dart
// prepare() returns the fetch definition (or an error value on failure).
final fetchdef = await client.prepare({
  'path': '/api/resource/{id}',
  'method': 'DELETE',
  'params': {'id': 'example'},
});

print(fetchdef['url']);
print(fetchdef['method']);
print(fetchdef['headers']);
```

### Use test mode

Create a mock client for unit testing — no server required:

```dart
final client = BluefinTecsEcrSDK.test();

// Entity ops return the bare record and throw on error.
final ecrapi = await client.EcrApi().load();
// ecrapi contains the mock response record
print(ecrapi);
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```dart
Future<dynamic> mockFetch(dynamic url, dynamic init) async {
  return {
    'status': 200,
    'statusText': 'OK',
    'headers': <String, dynamic>{},
    'json': () => {'id': 'mock01'},
  };
}

final client = BluefinTecsEcrSDK({
  'base': 'http://localhost:8080',
  'system': {
    'fetch': mockFetch,
  },
});
```

### Run live tests

Set the live-mode environment variables:

```bash
export BLUEFIN_TECS_ECR_TEST_LIVE=TRUE
export BLUEFIN_TECS_ECR_APIKEY=<your-key>
```

Then run:

```bash
cd dart && dart run test/main.dart
```


## Reference

### BluefinTecsEcrSDK

```dart
import 'package:bluefin_tecs_ecr_sdk/BluefinTecsEcrSDK.dart';

final client = BluefinTecsEcrSDK(options);
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Map` | Feature activation flags. |
| `extend` | `List` | Additional Feature instances to load. |
| `system` | `Map` | System overrides (e.g. custom `fetch` function). |

### test

```dart
final client = BluefinTecsEcrSDK.test(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### BluefinTecsEcrSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options` | `() -> Map` | Deep copy of current SDK options. |
| `utility` | `() -> Utility` | The SDK utility object. |
| `prepare` | `([fetchargs]) -> Future` | Build an HTTP request definition without sending. Returns an error value on failure. |
| `direct` | `([fetchargs]) -> Future<Map>` | Build and send an HTTP request. Returns a result map (branch on `ok`); never throws. |
| `EcrApi` | `([entopts]) -> EcrApiEntity` | Create an EcrApi entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, [ctrl]) -> Future<dynamic>` | Load a single entity by match criteria. Throws on error. |
| `create` | `(reqdata, [ctrl]) -> Future<dynamic>` | Create a new entity. Throws on error. |
| `data` | `([d]) -> Map` | Get (or, with an argument, set) entity data. |
| `match` | `([m]) -> Map` | Get (or, with an argument, set) entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `entopts` | `() -> Map` | Return the entity options. |
| `Name` | `String` | The entity name (a public field). |

### Result shape

Entity operations return the bare result data (a `Map` for single-entity
ops, a `List` of entity instances for `list`) and throw on error. Wrap calls
in `try`/`catch` to handle failures.

The `direct()` escape hatch never throws — it returns a result `Map` you
branch on via `result['ok']`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Map` | Response headers. |
| `data` | `dynamic` | Parsed JSON response body. |

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
| `payment_reason_as_byte` |  |
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

Create an instance: `final ecr_api = client.EcrApi();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `amount` | `String` |  |
| `authorization_number` | `String` |  |
| `card_number` | `String` |  |
| `currency` | `String` |  |
| `cvc2` | `String` |  |
| `desired_currency` | `String` |  |
| `ecr_data` | `String` |  |
| `language` | `String` |  |
| `message_type` | `String` |  |
| `password` | `String` |  |
| `payment_reason` | `String` |  |
| `payment_reason_as_byte` | `List<dynamic>` |  |
| `personal_id` | `String` |  |
| `receipt_layout` | `String` |  |
| `receipt_number` | `String` |  |
| `terminal_number` | `String` |  |
| `transaction_date_time` | `String` |  |
| `transaction_id` | `String` |  |
| `transaction_origin_identifier` | `String` |  |
| `transaction_origin_indicator` | `String` |  |
| `transaction_place` | `String` |  |
| `transaction_source_id` | `String` |  |

#### Example: Load

```dart
final ecr_api = await client.EcrApi().load();
```

#### Example: Create

```dart
final ecr_api = await client.EcrApi().create({
  'amount': 'example_amount',  // String
  'card_number': 'example_card_number',  // String
  'currency': 'example_currency',  // String
  'terminal_number': 'example_terminal_number',  // String
  'transaction_date_time': 'example_transaction_date_time',  // String
  'transaction_id': 'example_transaction_id',  // String
});
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

### Maps in, typed models alongside

The Dart SDK passes plain `Map<String, dynamic>` values through the
operation pipeline rather than requiring typed objects at every call. This
mirrors the dynamic nature of the API and keeps calls terse — a create is
just `create({'name': 'example'})`.

For a typed, documented view of each entity and operation, the generated
`BluefinTecsEcrTypes.dart` provides a class per entity plus per-op request/match
classes (e.g. `BluefinTecsEcr.fromMap(entity.data())` and `model.toMap()`), so you
can convert to and from those maps wherever you want compile-time structure.

### Package structure

```
dart/
├── lib/
│   ├── BluefinTecsEcrSDK.dart          -- Main SDK library (exported entry point)
│   ├── BluefinTecsEcrTypes.dart        -- Typed entity + request/match models
│   ├── BluefinTecsEcrEntityBase.dart   -- Base class for entities
│   ├── BluefinTecsEcrError.dart        -- SDK error type
│   ├── Config.dart              -- Configuration
│   ├── entity/                  -- Entity implementations
│   ├── feature/                 -- Built-in features (base, test, log, ...)
│   └── utility/                 -- Utility functions and vendored struct library
└── test/                        -- Test suites (dart run test/main.dart)
```

The main library (`BluefinTecsEcrSDK.dart`) re-exports the SDK class, the typed
models, and every entity class, so a single
`import 'package:bluefin_tecs_ecr_sdk/BluefinTecsEcrSDK.dart';`
brings in everything you need.

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
