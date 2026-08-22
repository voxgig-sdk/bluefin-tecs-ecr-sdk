# BluefinTecsEcr Zig SDK



The Zig SDK for the BluefinTecsEcr API — an entity-oriented client following idiomatic Zig conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.ecr_api(h.vnull())` — each
carrying a small, uniform set of operations (`load`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
Zig has no central package registry, so this package is distributed as a
git tag (`zig/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/releases)). Add it to
your `build.zig.zon` dependencies, or build from a source checkout:

```bash
cd zig && zig build
```

To depend on it from another project, add the tagged archive to
`build.zig.zon`:

```zig
.dependencies = .{
    .sdk = .{
        .url = "<repo-url>/archive/refs/tags/zig/vX.Y.Z.tar.gz",
        // .hash = "...", // filled in by `zig fetch`
    },
},
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```zig
const std = @import("std");
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.BluefinTecsEcrSDK.new(h.jo(&.{
    .{ "apikey", h.vstr(std.posix.getenv("BLUEFIN_TECS_ECR_APIKEY") orelse "") },
}));
```

### 3. Load an ecrapi

`load()`'s `.ok` carries the bare record.

```zig
switch (client.ecr_api(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |ecr_api| std.debug.print("{s}\n", .{h.stringify(ecr_api)}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

### 4. Create, update, and remove

```zig
// Create — .ok carries the created record
switch (client.ecr_api(h.vnull()).create(h.jo(&.{.{ "amount", h.vstr("example_amount") }, .{ "card_number", h.vstr("example_card_number") }, .{ "currency", h.vstr("example_currency") }, .{ "terminal_number", h.vstr("example_terminal_number") }, .{ "transaction_date_time", h.vstr("example_transaction_date_time") }, .{ "transaction_id", h.vstr("example_transaction_id") }}), h.vnull())) {
    .ok => |created| std.debug.print("{s}\n", .{h.stringify(created)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
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

```zig
const result = client.direct(h.jo(&.{
    .{ "path", h.vstr("/api/resource/{id}") },
    .{ "method", h.vstr("GET") },
    .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
}));

if (h.get_bool(result, "ok") orelse false) {
    std.debug.print("{d}\n", .{h.to_int(h.getp(result, "status"))}); // 200
    std.debug.print("{s}\n", .{h.stringify(h.getp(result, "data"))}); // response body
} else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present.
    std.debug.print("{s}\n", .{h.get_str(result, "err") orelse ""});
}
```

### Prepare a request without sending it

```zig
// prepare() returns the fetch definition (an error union — use `catch`/`try`).
const fetchdef = client.prepare(h.jo(&.{
    .{ "path", h.vstr("/api/resource/{id}") },
    .{ "method", h.vstr("DELETE") },
    .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
})) catch unreachable;

std.debug.print("{s}\n", .{h.get_str(fetchdef, "url") orelse ""});
std.debug.print("{s}\n", .{h.get_str(fetchdef, "method") orelse ""});
std.debug.print("{s}\n", .{h.stringify(h.getp(fetchdef, "headers"))});
```

### Use test mode

Create a mock client for unit testing — no server required:

```zig
const client = sdk.test_sdk(h.vnull(), h.vnull());

// Entity ops return an OpResult — .ok carries the record, .err the error.
switch (client.ecr_api(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |ecr_api| std.debug.print("{s}\n", .{h.stringify(ecr_api)}), // the mock record
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

### Point at a different server

Override the base URL to reach a local or staging server:

```zig
const client = sdk.BluefinTecsEcrSDK.new(h.jo(&.{
    .{ "base", h.vstr("http://localhost:8080") },
}));
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_TECS_ECR_TEST_LIVE=TRUE
BLUEFIN_TECS_ECR_APIKEY=<your-key>
```

Then run:

```bash
cd zig && zig build test
```


## Reference

### BluefinTecsEcrSDK

```zig
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.BluefinTecsEcrSDK.new(options);
```

Creates a new SDK client. `options` is a `Value` map (`h.vnull()` for
none) carrying any of the following keys:

| Option | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `map` | Feature activation flags. |
| `system` | `map` | System overrides (e.g. a custom fetcher). |

### test_sdk

```zig
const client = sdk.test_sdk(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`h.vnull()`.

### BluefinTecsEcrSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() Value` | Deep copy of the current SDK options. |
| `get_utility` | `() *Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs: Value) E!Value` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs: Value) Value` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `ecr_api` | `(entopts: Value) *EcrApiEntity` | Create an EcrApi entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch: Value, ctrl: Value) OpResult` | Load a single entity by match criteria. |
| `create` | `(reqdata: Value, ctrl: Value) OpResult` | Create a new entity. |
| `stream` | `(action: []const u8, args: Value, callopts: Value) []Value` | Run an op through the pipeline and materialise its result items. |
| `data` | `(args: ?Value) Value` | Get entity data (pass a map to set). |
| `matchv` | `(args: ?Value) Value` | Get entity match criteria (pass a map to set). |
| `get_name` | `() []const u8` | Return the entity name. |

### Result shape

Entity operations return an `OpResult` union — `switch` on it: `.ok`
carries the bare result data (a `Value` object for single-entity ops, a
`Value` array for `list`), `.err` carries the branded error pointer.

The `direct()` escape hatch returns a result `Value` map directly (no
error union) — even on a non-2xx response — that you branch on via
`h.get_bool(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `number` | HTTP status code. |
| `headers` | `map` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `false` and `err` carries the error message.

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

Operations: Create, Load.

API path: `/makeTransaction`



## Entities


### EcrApi

Create an instance: `const ecr_api = client.ecr_api(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `load(reqmatch, ctrl)` | Load a single entity by match criteria. |

Each operation returns an `OpResult` — `switch` on it: `.ok => |data|`
carries the result `Value`, `.err => |e|` carries the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `amount` | `[]const u8` | Numeric Transaction Amount. |
| `authorization_number` | `[]const u8` | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `[]const u8` | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `[]const u8` | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `[]const u8` | Card Verification Code. |
| `desired_currency` | `[]const u8` | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `[]const u8` | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `[]const u8` | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `[]const u8` | Message type code. |
| `password` | `[]const u8` | Password - currently not used (filled with spaces). |
| `payment_reason` | `[]const u8` | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `Value (array)` | Payment reason represented as a byte array. |
| `personal_id` | `[]const u8` | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `[]const u8` | Receipt layout identifier. |
| `receipt_number` | `[]const u8` | Receipt number. |
| `terminal_number` | `[]const u8` | Terminal number provided by TECS. |
| `transaction_date_time` | `[]const u8` | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `[]const u8` | Unique transaction identifier. |
| `transaction_origin_identifier` | `[]const u8` | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `[]const u8` | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `[]const u8` | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `[]const u8` | Identification number of the authorization source. |

#### Example: Load

```zig
switch (client.ecr_api(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |ecr_api| std.debug.print("{s}\n", .{h.stringify(ecr_api)}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.ecr_api(h.vnull()).create(h.jo(&.{
    .{ "amount", h.vstr("example_amount") }, // []const u8
    .{ "card_number", h.vstr("example_card_number") }, // []const u8
    .{ "currency", h.vstr("example_currency") }, // []const u8
    .{ "terminal_number", h.vstr("example_terminal_number") }, // []const u8
    .{ "transaction_date_time", h.vstr("example_transaction_date_time") }, // []const u8
    .{ "transaction_id", h.vstr("example_transaction_id") }, // []const u8
}), h.vnull())) {
    .ok => |ecr_api| std.debug.print("{s}\n", .{h.stringify(ecr_api)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
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

The Zig SDK uses a single dynamic `Value` type throughout rather than a
typed struct per entity. `Value` is the vendored voxgig struct port's
`JsonValue` (a JSON-shaped tagged union: `.string`, `.integer`,
`.float`, `.bool`, `.array`, `.object`, `.null`). This mirrors the
dynamic nature of the API and keeps the SDK flexible — no code generation is
needed when the API schema changes.

Build request maps with the `h.jo` / `h.ja` helpers and read fields back
with `h.getp` (or the typed `h.get_str` / `h.get_bool` / `h.to_int`
accessors); use `h.to_map` to safely coerce a value to a map.

### Module structure

```
zig/
├── root.zig                     -- Module root (re-exports the public surface)
├── build.zig                    -- Build + test wiring
├── core/                        -- Pipeline types, config, client (sdk.zig)
├── entity/                      -- Per-entity clients (one file each)
├── feature/                     -- Built-in features (base, test, log)
├── utility/                     -- Utilities + the vendored voxgig struct port
└── test/                        -- Test suites
```

The public API is re-exported from `root.zig`, so `@import("sdk")` reaches
the SDK client, `Value`, and the `h` (helpers) namespace directly. Import
entity or utility modules only when needed.

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
