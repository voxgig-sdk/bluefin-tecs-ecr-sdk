# BluefinTecsEcr PHP SDK Reference

Complete API reference for the BluefinTecsEcr PHP SDK.


## BluefinTecsEcrSDK

### Constructor

```php
require_once __DIR__ . '/bluefintecsecr_sdk.php';

$client = new BluefinTecsEcrSDK($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `array` | SDK configuration options. |
| `$options["apikey"]` | `string` | API key for authentication. |
| `$options["base"]` | `string` | Base URL for API requests. |
| `$options["prefix"]` | `string` | URL prefix appended after base. |
| `$options["suffix"]` | `string` | URL suffix appended after path. |
| `$options["headers"]` | `array` | Custom headers for all requests. |
| `$options["feature"]` | `array` | Feature configuration. |
| `$options["system"]` | `array` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinTecsEcrSDK::test($testopts = null, $sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```php
$client = BluefinTecsEcrSDK::test();
```


### Instance Methods

#### `EcrApi($data = null)`

Create a new `EcrApiEntity` instance. Pass `null` for no initial data.

#### `options_map(): array`

Return a deep copy of the current SDK options.

#### `get_utility(): BluefinTecsEcrUtility`

Return a copy of the SDK utility object.

#### `direct(array $fetchargs = []): array`

Make a direct HTTP request to any API endpoint. This is the raw-HTTP escape
hatch: it does **not** throw. It returns a result array
`["ok" => bool, "status" => int, "headers" => array, "data" => mixed]`, or
`["ok" => false, "err" => \Exception]` on failure. Branch on `$result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `$fetchargs["params"]` | `array` | Path parameter values for `{param}` substitution. |
| `$fetchargs["query"]` | `array` | Query string parameters. |
| `$fetchargs["headers"]` | `array` | Request headers (merged with defaults). |
| `$fetchargs["body"]` | `mixed` | Request body (arrays are JSON-serialized). |
| `$fetchargs["ctrl"]` | `array` | Control options. |

**Returns:** `array` — the result dict (see above); never throws.

#### `prepare(array $fetchargs = []): mixed`

Prepare a fetch definition without sending the request. Returns the
`$fetchdef` array. Throws on error.


---

## EcrApiEntity

```php
$ecr_api = $client->EcrApi();
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
| `payment_reasonAsByte` | `array` | No |  |
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

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->EcrApi()->create([
  "amount" => null, // string
  "card_number" => null, // string
  "currency" => null, // string
  "terminal_number" => null, // string
  "transaction_date_time" => null, // string
  "transaction_id" => null, // string
]);
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->EcrApi()->load();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): EcrApiEntity`

Create a new `EcrApiEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```php
$client = new BluefinTecsEcrSDK([
  "feature" => [
    "test" => ["active" => true],
  ],
]);
```

