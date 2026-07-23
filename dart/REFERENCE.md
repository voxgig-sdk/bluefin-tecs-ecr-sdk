# BluefinTecsEcr Dart SDK Reference

Complete API reference for the BluefinTecsEcr Dart SDK.

## BluefinTecsEcrSDK

### Constructor

```dart
import 'package:bluefin_tecs_ecr_sdk/BluefinTecsEcrSDK.dart';

final client = BluefinTecsEcrSDK(options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Map` | SDK configuration options. |
| `options['apikey']` | `String` | API key for authentication. |
| `options['base']` | `String` | Base URL for API requests. |
| `options['prefix']` | `String` | URL prefix appended after base. |
| `options['suffix']` | `String` | URL suffix appended after path. |
| `options['headers']` | `Map` | Custom headers for all requests. |
| `options['feature']` | `Map` | Feature configuration. |
| `options['system']` | `Map` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinTecsEcrSDK.test([testopts, sdkopts])`

Create a test client with mock features active. Both arguments may be `null`.

```dart
final client = BluefinTecsEcrSDK.test();
```


### Instance Methods

#### `EcrApi([entopts])`

Create a new `EcrApiEntity` instance. Pass no argument for no initial data.

#### `options() -> Map`

Return a deep copy of the current SDK options.

#### `utility() -> Utility`

Return the SDK utility object.

#### `direct([fetchargs]) -> Future<Map>`

Make a direct HTTP request to any API endpoint. Returns a result `Map` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never throws — branch on `result['ok']`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs['path']` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs['method']` | `String` | HTTP method (default: `'GET'`). |
| `fetchargs['params']` | `Map` | Path parameter values. |
| `fetchargs['query']` | `Map` | Query string parameters. |
| `fetchargs['headers']` | `Map` | Request headers (merged with defaults). |
| `fetchargs['body']` | `dynamic` | Request body (maps are JSON-serialized). |

**Returns:** `Future<Map>`

#### `prepare([fetchargs]) -> Future`

Prepare a fetch definition without sending. Returns the `fetchdef` (or an error value on failure).


---

## EcrApiEntity

```dart
final ecr_api = client.EcrApi();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `amount` | `String` | Yes |  |
| `authorization_number` | `String` | No |  |
| `card_number` | `String` | Yes |  |
| `currency` | `String` | Yes |  |
| `cvc2` | `String` | No |  |
| `desired_currency` | `String` | No |  |
| `ecr_data` | `String` | No |  |
| `language` | `String` | No |  |
| `message_type` | `String` | No |  |
| `password` | `String` | No |  |
| `payment_reason` | `String` | No |  |
| `payment_reason_as_byte` | `List<dynamic>` | No |  |
| `personal_id` | `String` | No |  |
| `receipt_layout` | `String` | No |  |
| `receipt_number` | `String` | No |  |
| `terminal_number` | `String` | Yes |  |
| `transaction_date_time` | `String` | Yes |  |
| `transaction_id` | `String` | Yes |  |
| `transaction_origin_identifier` | `String` | No |  |
| `transaction_origin_indicator` | `String` | No |  |
| `transaction_place` | `String` | No |  |
| `transaction_source_id` | `String` | No |  |

### Operations

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.EcrApi().create({
  'amount': 'example_amount',  // String
  'card_number': 'example_card_number',  // String
  'currency': 'example_currency',  // String
  'terminal_number': 'example_terminal_number',  // String
  'transaction_date_time': 'example_transaction_date_time',  // String
  'transaction_id': 'example_transaction_id',  // String
});
```

#### `load(reqmatch, [ctrl]) -> Future<dynamic>`

Load a single entity matching the given criteria. Returns the entity data and throws on error.

```dart
final result = await client.EcrApi().load();
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `EcrApiEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```dart
final client = BluefinTecsEcrSDK({
  'feature': {
    'test': {'active': true},
  },
});
```

