# BluefinTecsEcr Golang SDK



The Golang SDK for the BluefinTecsEcr API — an entity-oriented client using standard Go conventions. No generics required; data flows as `map[string]any`.

It exposes the API as capitalised, semantic **Entities** — e.g. `client.EcrApi(nil)` — each with the same small set of operations (`Load`, `Create`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Also generated from this model: `c`, `clojure`, `cpp`, `csharp`, `dart`, `elixir`, `go-cli`, `go-mcp`, `java`, `js`, `kotlin`, `lua`, `ocaml`, `perl`, `php`, `py`, `rb`, `rust`, `scala`, `swift`, `ts`, `zig` — see
> the [top-level README](../README.md).


## Install
```bash
go get github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go@latest
```

The Go module proxy resolves the version from the `go/vX.Y.Z` GitHub
release tag — see [Releases](https://github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/releases) for the available versions.

To vendor from a local checkout instead, clone this repo alongside your
project and add a `replace` directive pointing at the checked-out
`go/` directory:

```bash
go mod edit -replace github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go=../bluefin-tecs-ecr-sdk/go
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### Quickstart

A complete program: create a client, then call the entity operations.
Each operation returns `(value, error)` — the value is the data itself
(there is no `{ok, data}` wrapper), so check `err` and use the value
directly.

```go
package main

import (
    "fmt"
    "os"
    sdk "github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go"
)

func main() {
    client := sdk.NewBluefinTecsEcrSDK(map[string]any{
        "apikey": os.Getenv("BLUEFIN_TECS_ECR_APIKEY"),
    })

    // Load a single ecrApi — the value is the loaded record.
    ecrApi, err := client.EcrApi(nil).Load(nil, nil)
    if err != nil {
        panic(err)
    }
    fmt.Println(ecrApi)

    // Create a ecrApi.
    created, err := client.EcrApi(nil).Create(map[string]any{"amount": "example_amount", "card_number": "example_card_number", "currency": "example_currency", "terminal_number": "example_terminal_number", "transaction_date_time": "example_transaction_date_time", "transaction_id": "example_transaction_id"}, nil)
    if err != nil {
        panic(err)
    }
    fmt.Println(created)
}
```


## Error handling

Every entity operation returns `(value, error)`. Check `err` before
using the value — there is no exception to catch:

```go
ecrapi, err := client.EcrApi(nil).Load(nil, nil)
if err != nil {
    // handle err
    return
}
_ = ecrapi
```

`Direct` follows the same `(value, error)` convention:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example_id"},
})
if err != nil {
    // handle err
}
_ = result
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

if result["ok"] == true {
    fmt.Println(result["status"]) // 200
    fmt.Println(result["data"])   // response body
}
```

### Prepare a request without sending it

```go
fetchdef, err := client.Prepare(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "DELETE",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

fmt.Println(fetchdef["url"])
fmt.Println(fetchdef["method"])
fmt.Println(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```go
client := sdk.Test()

ecrApi, err := client.EcrApi(nil).Load(
    nil, nil,
)
if err != nil {
    panic(err)
}
fmt.Println(ecrApi) // the returned mock data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```go
mockFetch := func(url string, init map[string]any) (map[string]any, error) {
    return map[string]any{
        "status":     200,
        "statusText": "OK",
        "headers":    map[string]any{},
        "json": (func() any)(func() any {
            return map[string]any{"id": "mock01"}
        }),
    }, nil
}

client := sdk.NewBluefinTecsEcrSDK(map[string]any{
    "base": "http://localhost:8080",
    "system": map[string]any{
        "fetch": (func(string, map[string]any) (map[string]any, error))(mockFetch),
    },
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
cd go && go test ./test/...
```


## Reference

### NewBluefinTecsEcrSDK

```go
func NewBluefinTecsEcrSDK(options map[string]any) *BluefinTecsEcrSDK
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `"apikey"` | `string` | API key for authentication. |
| `"base"` | `string` | Base URL of the API server. |
| `"prefix"` | `string` | URL path prefix prepended to all requests. |
| `"suffix"` | `string` | URL path suffix appended to all requests. |
| `"feature"` | `map[string]any` | Feature activation flags. |
| `"extend"` | `[]any` | Additional Feature instances to load. |
| `"system"` | `map[string]any` | System overrides (e.g. custom `"fetch"` function). |

### TestSDK

```go
func TestSDK(testopts map[string]any, sdkopts map[string]any) *BluefinTecsEcrSDK
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### BluefinTecsEcrSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() map[string]any` | Deep copy of current SDK options. |
| `GetUtility` | `() *Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs map[string]any) (map[string]any, error)` | Build an HTTP request definition without sending. |
| `Direct` | `(fetchargs map[string]any) (map[string]any, error)` | Build and send an HTTP request. |
| `EcrApi` | `(data map[string]any) BluefinTecsEcrEntity` | Create an EcrApi entity instance. |

### Entity interface (BluefinTecsEcrEntity)

All entities implement the `BluefinTecsEcrEntity` interface.

| Method | Signature | Description |
| --- | --- | --- |
| `Load` | `(reqmatch, ctrl map[string]any) (any, error)` | Load a single entity by match criteria. |
| `Create` | `(reqdata, ctrl map[string]any) (any, error)` | Create a new entity. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(value, error)`. The `value` is the
operation's data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `Load` / `Create` | the entity record (`map[string]any`) |

Check `err` first, then use the value directly (or the typed
`...Typed` variants, which return the entity's model struct and a typed
slice):

    ecrApi, err := client.EcrApi(nil).Load(nil, nil)
    if err != nil { /* handle */ }
    // ecrApi is the returned record

Only `Direct()` returns a response envelope — a `map[string]any` with
`"ok"`, `"status"`, `"headers"`, and `"data"` keys.

### Entities

#### EcrApi

| Field | Description |
| --- | --- |
| `"amount"` | Numeric Transaction Amount. |
| `"authorization_number"` | For Gratuity (msg type 0009): the authorization number of the original transaction. |
| `"card_number"` | Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty. |
| `"currency"` | ISO 4217 Alpha Currency Code (e.g., "EUR", "USD"). |
| `"cvc2"` | Card Verification Code. |
| `"desired_currency"` | ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD"). |
| `"ecr_data"` | ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex). |
| `"language"` | ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es"). |
| `"message_type"` | Message type code. |
| `"password"` | Password - currently not used (filled with spaces). |
| `"payment_reason"` | Payment reason (e.g., "Taxi journey"). |
| `"payment_reasonAsByte"` | Payment reason represented as a byte array. |
| `"personal_id"` | Identification of the current user of the ECR or Terminal. |
| `"receipt_layout"` | Receipt layout identifier. |
| `"receipt_number"` | Receipt number. |
| `"terminal_number"` | Terminal number provided by TECS. |
| `"transaction_date_time"` | Transaction date and time (format: yyyymmddhhmmss). |
| `"transaction_id"` | Unique transaction identifier. |
| `"transaction_origin_identifier"` | Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance |
| `"transaction_origin_indicator"` | Transaction origin indicator: - 0 = Request for card data on PIN PAD. |
| `"transaction_place"` | The transaction place; the first 5 characters should contain a formatted zip code. |
| `"transaction_source_id"` | Identification number of the authorization source. |

Operations: Create, Load.

API path: `/makeTransaction`



## Entities


### EcrApi

Create an instance: `ecrApi := client.EcrApi(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |

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
| `payment_reasonAsByte` | `[]any` | Payment reason represented as a byte array. |
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

```go
ecrApi, err := client.EcrApi(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(ecrApi) // the loaded record
```

#### Example: Create

```go
result, err := client.EcrApi(nil).Create(map[string]any{
    "amount": "example_amount",
    "card_number": "example_card_number",
    "currency": "example_currency",
    "terminal_number": "example_terminal_number",
    "transaction_date_time": "example_transaction_date_time",
    "transaction_id": "example_transaction_id",
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

## Features

This SDK ships 11 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`audit`](#audit) | Structured audit trail of operations |
| [`clienttrack`](#clienttrack) | Client identity and per-request correlation headers |
| [`idempotency`](#idempotency) | Idempotency keys for safe retries of mutating operations |
| [`log`](#log) | Structured request and response logging |
| [`metrics`](#metrics) | Statistics capture: per-operation counters and latency |
| [`paging`](#paging) | Pagination signals for list operations |
| [`ratelimit`](#ratelimit) | Client-side rate limiting via a token bucket |
| [`retry`](#retry) | Automatic retry of transient failures with exponential backoff |
| [`telemetry`](#telemetry) | Distributed tracing spans with W3C trace-context propagation |
| [`test`](#test) | In-memory mock transport for testing without a live server |
| [`timeout`](#timeout) | Per-request timeout with transport abort |

> **Order matters for `ratelimit`, `retry`, `timeout`.** These wrap the
> transport, so each one wraps whatever is already installed: the order you
> activate them in IS the nesting order. Activating them as an ordered list
> rather than a map is what fixes that order.

### audit

Structured audit trail of operations.

| Option | Default |
|---|---|
| `active` | `false` |
| `actor` | `'anonymous'` |
| `max` | `1000` |

Set `feature.audit.active` to enable it, then override any of the options above.

### clienttrack

Client identity and per-request correlation headers.

| Option | Default |
|---|---|
| `active` | `false` |
| `clientVersion` | `'0.0.1'` |

Set `feature.clienttrack.active` to enable it, then override any of the options above.

### idempotency

Idempotency keys for safe retries of mutating operations.

| Option | Default |
|---|---|
| `active` | `false` |
| `header` | `'Idempotency-Key'` |
| `methods` | `['POST', 'PUT', 'PATCH', 'DELETE']` |
| `ops` | `['create', 'update', 'remove']` |

Set `feature.idempotency.active` to enable it, then override any of the options above.

### log

Structured request and response logging.

| Option | Default |
|---|---|
| `active` | `true` |

Set `feature.log.active` to enable it, then override any of the options above.

### metrics

Statistics capture: per-operation counters and latency.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.metrics.active` to enable it, then override any of the options above.

### paging

Pagination signals for list operations.

| Option | Default |
|---|---|
| `active` | `false` |
| `afterVar` | `'after'` |
| `cursorParam` | `'cursor'` |
| `firstVar` | `'first'` |
| `limitParam` | `'limit'` |
| `pageParam` | `'page'` |
| `startPage` | `1` |

Set `feature.paging.active` to enable it, then override any of the options above.

### ratelimit

Client-side rate limiting via a token bucket.

| Option | Default |
|---|---|
| `active` | `false` |
| `burst` | `5` |
| `rate` | `5` |

Set `feature.ratelimit.active` to enable it, then override any of the options above.

`ratelimit` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### retry

Automatic retry of transient failures with exponential backoff.

| Option | Default |
|---|---|
| `active` | `false` |
| `factor` | `2` |
| `maxDelay` | `2000` |
| `minDelay` | `50` |
| `retries` | `2` |
| `statuses` | `[408, 425, 429, 500, 502, 503, 504]` |

Set `feature.retry.active` to enable it, then override any of the options above.

`retry` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.

### telemetry

Distributed tracing spans with W3C trace-context propagation.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.telemetry.active` to enable it, then override any of the options above.

### test

In-memory mock transport for testing without a live server.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.

### timeout

Per-request timeout with transport abort.

| Option | Default |
|---|---|
| `active` | `false` |
| `ms` | `30000` |

Set `feature.timeout.active` to enable it, then override any of the options above.

`timeout` wraps the transport, so its position among the other
transport features decides what it sees. A feature activated later wraps one
activated earlier.


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

Features are the extension mechanism. A feature implements the
`Feature` interface and provides hooks — functions keyed by pipeline
stage names.

The SDK ships with built-in features:

- **AuditFeature**: Structured audit trail of operations
- **ClienttrackFeature**: Client identity and per-request correlation headers
- **IdempotencyFeature**: Idempotency keys for safe retries of mutating operations
- **LogFeature**: Structured request and response logging
- **MetricsFeature**: Statistics capture: per-operation counters and latency
- **PagingFeature**: Pagination signals for list operations
- **RatelimitFeature**: Client-side rate limiting via a token bucket
- **RetryFeature**: Automatic retry of transient failures with exponential backoff
- **TelemetryFeature**: Distributed tracing spans with W3C trace-context propagation
- **TestFeature**: In-memory mock transport for testing without a live server
- **TimeoutFeature**: Per-request timeout with transport abort

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as maps

The Go SDK uses `map[string]any` throughout rather than typed structs.
This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Use `core.ToMapAny()` to safely cast results and nested data.

### Package structure

```
github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go/
├── bluefin-tecs-ecr.go        # Root package — type aliases and constructors
├── core/               # SDK core — client, types, pipeline
├── entity/             # Entity implementations
├── feature/            # Built-in features (Base, Test, Log)
├── utility/            # Utility functions and struct library
└── test/               # Test suites
```

The root package (`github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go`) re-exports everything needed
for normal use. Import sub-packages only when you need specific types
like `core.ToMapAny`.

### Entity state

Entity instances are stateful. After a successful `Load`, the entity
stores the returned data and match criteria internally.

```go
ecrapi := client.EcrApi(nil)
ecrapi.Load(nil, nil)

// ecrapi.Data() now returns the ecrapi data from the last load
// ecrapi.Match() returns the last match criteria
```

Call `Make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`Direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `Prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
