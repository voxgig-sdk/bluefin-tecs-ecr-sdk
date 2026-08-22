# BluefinTecsEcr Zig SDK Reference

Complete API reference for the BluefinTecsEcr Zig SDK.


## BluefinTecsEcrSDK

### Constructor

```zig
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.BluefinTecsEcrSDK.new(options);
```

Create a new SDK client instance. `options` is a `Value` map
(`h.vnull()` for none).

**Parameters:**

| Key | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides. |


### Static Functions

#### `test_sdk(testopts: Value, sdkopts: Value) *BluefinTecsEcrSDK`

Create a test client with mock features active. Both arguments may be
`h.vnull()`.

```zig
const client = sdk.test_sdk(h.vnull(), h.vnull());
```


### Instance Methods

#### `ecr_api(entopts: Value) *EcrApiEntity`

Create a new `EcrApiEntity` instance. Pass `h.vnull()` for no
initial options.

#### `options_map() Value`

Return a deep copy of the current SDK options.

#### `get_utility() *Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs: Value) Value`

Make a direct HTTP request to any API endpoint. Returns a result `Value`
map with `ok`, `status`, `headers`, and `data` (or `err` on failure).
This escape hatch returns a map even on a non-2xx response — branch on
`h.get_bool(result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `prepare(fetchargs: Value) E!Value`

Prepare a fetch definition without sending. Returns the fetchdef (use
`catch`/`try` to handle the error union).


---

## EcrApiEntity

```zig
const ecr_api = client.ecr_api(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `amount` | `[]const u8` | Yes | Numeric Transaction Amount. |
| `authorization_number` | `[]const u8` | No | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `card_number` | `[]const u8` | Yes | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `currency` | `[]const u8` | Yes | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `cvc2` | `[]const u8` | No | Card Verification Code. |
| `desired_currency` | `[]const u8` | No | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `ecr_data` | `[]const u8` | No | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `language` | `[]const u8` | No | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `message_type` | `[]const u8` | No | Message type code. |
| `password` | `[]const u8` | No | Password - currently not used (filled with spaces). |
| `payment_reason` | `[]const u8` | No | Payment reason (e.g., "Taxi journey"). |
| `payment_reasonAsByte` | `Value (array)` | No | Payment reason represented as a byte array. |
| `personal_id` | `[]const u8` | No | Identification of the current user of the ECR or Terminal. |
| `receipt_layout` | `[]const u8` | No | Receipt layout identifier. |
| `receipt_number` | `[]const u8` | No | Receipt number. |
| `terminal_number` | `[]const u8` | Yes | Terminal number provided by TECS. |
| `transaction_date_time` | `[]const u8` | Yes | Transaction date and time (format: yyyymmddhhmmss). |
| `transaction_id` | `[]const u8` | Yes | Unique transaction identifier. |
| `transaction_origin_identifier` | `[]const u8` | No | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `transaction_origin_indicator` | `[]const u8` | No | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `transaction_place` | `[]const u8` | No | The transaction place; the first 5 characters should contain a formatted zip code. |
| `transaction_source_id` | `[]const u8` | No | Identification number of the authorization source. |

### Operations

#### `create(reqdata: Value, ctrl: Value) OpResult`

Create a new entity with the given data. `.ok` carries the created entity data.

```zig
switch (client.ecr_api(h.vnull()).create(h.jo(&.{
    .{ "amount", h.vstr("example_amount") }, // []const u8
    .{ "card_number", h.vstr("example_card_number") }, // []const u8
    .{ "currency", h.vstr("example_currency") }, // []const u8
    .{ "terminal_number", h.vstr("example_terminal_number") }, // []const u8
    .{ "transaction_date_time", h.vstr("example_transaction_date_time") }, // []const u8
    .{ "transaction_id", h.vstr("example_transaction_id") }, // []const u8
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

#### `load(reqmatch: Value, ctrl: Value) OpResult`

Load a single entity matching the given criteria. `.ok` carries the entity data, `.err` the branded error.

```zig
switch (client.ecr_api(h.vnull()).load(h.vnull(), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("load failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```zig
const client = sdk.BluefinTecsEcrSDK.new(h.jo(&.{
    .{ "feature", h.jo(&.{
        .{ "test", h.jo(&.{.{ "active", h.vbool(true) }}) },
    }) },
}));
```

