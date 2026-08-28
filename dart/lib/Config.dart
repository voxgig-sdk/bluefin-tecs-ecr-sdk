import 'feature/base/BaseFeature.dart';
import 'feature/audit/AuditFeature.dart';
import 'feature/clienttrack/ClienttrackFeature.dart';
import 'feature/idempotency/IdempotencyFeature.dart';
import 'feature/log/LogFeature.dart';
import 'feature/metrics/MetricsFeature.dart';
import 'feature/paging/PagingFeature.dart';
import 'feature/ratelimit/RatelimitFeature.dart';
import 'feature/retry/RetryFeature.dart';
import 'feature/telemetry/TelemetryFeature.dart';
import 'feature/test/TestFeature.dart';
import 'feature/timeout/TimeoutFeature.dart';


// ignore: non_constant_identifier_names
final Map<String, BaseFeature Function()> FEATURE_CLASS = {
    'audit': () => AuditFeature(),
  'clienttrack': () => ClienttrackFeature(),
  'idempotency': () => IdempotencyFeature(),
  'log': () => LogFeature(),
  'metrics': () => MetricsFeature(),
  'paging': () => PagingFeature(),
  'ratelimit': () => RatelimitFeature(),
  'retry': () => RetryFeature(),
  'telemetry': () => TelemetryFeature(),
  'test': () => TestFeature(),
  'timeout': () => TimeoutFeature(),

};

class Config {
  BaseFeature makeFeature(String fn) {
    final fc = FEATURE_CLASS[fn];
    if (null == fc) {
      // TODO: errors etc
      throw StateError('Unknown feature: ' + fn);
    }
    return fc();
  }

  // False for a feature added at runtime via options.extend (station's
  // adopt path) - the constructor uses this to skip makeFeature for names
  // no generated class backs.
  bool hasFeature(String fn) => null != FEATURE_CLASS[fn];

  final Map<String, dynamic> main = <String, dynamic>{
    'name': 'BluefinTecsEcr',
        'slug': 'bluefin-tecs-ecr',
    'version': '0.1.1',
    'target': 'dart',

  };

  final Map<String, dynamic> feature = <String, dynamic>{
        'audit': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'actor': 'anonymous',
        'max': 1000,
      },
      'transport': 'none',
    },
    'clienttrack': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'clientVersion': '0.0.1',
      },
      'transport': 'none',
    },
    'idempotency': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'header': 'Idempotency-Key',
        'methods': <dynamic>[
          'POST',
          'PUT',
          'PATCH',
          'DELETE',
        ],
        'ops': <dynamic>[
          'create',
          'update',
          'remove',
        ],
      },
      'transport': 'none',
    },
    'log': <String, dynamic>{
      'options': <String, dynamic>{
        'active': true,
      },
      'transport': 'none',
    },
    'metrics': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
      'transport': 'none',
    },
    'paging': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'afterVar': 'after',
        'cursorParam': 'cursor',
        'firstVar': 'first',
        'limitParam': 'limit',
        'pageParam': 'page',
        'startPage': 1,
      },
      'transport': 'none',
    },
    'ratelimit': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'burst': 5,
        'rate': 5,
      },
      'transport': 'wrap',
    },
    'retry': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'factor': 2,
        'maxDelay': 2000,
        'minDelay': 50,
        'retries': 2,
        'statuses': <dynamic>[
          408,
          425,
          429,
          500,
          502,
          503,
          504,
        ],
      },
      'transport': 'wrap',
    },
    'telemetry': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
      'transport': 'none',
    },
    'test': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
      'transport': 'base',
    },
    'timeout': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'ms': 30000,
      },
      'transport': 'wrap',
    },

  };

  // Rendered whole from the canonical config definition rather than assembled
  // slot by slot. Assembling it here meant `options.server` - the OpenAPI
  // server-variable defaults - was simply absent from this branch, so a
  // templated server URL produced a different config either side of the
  // threshold.
  final Map<String, dynamic> options = <String, dynamic>{
    'base': 'https://test.tecs.at/tecsclientrest-auth',
    'auth': <String, dynamic>{
      'prefix': 'Bearer',
    },
    'headers': <String, dynamic>{
      'content-type': 'application/json',
    },
    'entity': <String, dynamic>{
      'ecr_api': <String, dynamic>{},
    },
  };

  final Map<String, dynamic> entity = <String, dynamic>{
    'ecr_api': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'amount',
          'req': true,
          'short': 'Numeric Transaction Amount.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'authorization_number',
          'short': 'For Gratuity (msg type 0009): the authorization number of the original transaction.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'card_number',
          'req': true,
          'short': 'Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'currency',
          'req': true,
          'short': 'ISO 4217 Alpha Currency Code (e.g., "EUR", "USD").',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'cvc2',
          'short': 'Card Verification Code.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'desired_currency',
          'short': 'ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., "EUR", "USD").',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'ecr_data',
          'short': 'ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'language',
          'short': 'ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., "en", "de", "es").',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'message_type',
          'short': 'Message type code.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'password',
          'short': 'Password - currently not used (filled with spaces).',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'payment_reason',
          'short': 'Payment reason (e.g., "Taxi journey").',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'payment_reasonAsByte',
          'short': 'Payment reason represented as a byte array.',
          'type': '`\$ARRAY`',
        },
        <String, dynamic>{
          'name': 'personal_id',
          'short': 'Identification of the current user of the ECR or Terminal.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'receipt_layout',
          'short': 'Receipt layout identifier.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'receipt_number',
          'short': 'Receipt number.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'terminal_number',
          'req': true,
          'short': 'Terminal number provided by TECS.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_date_time',
          'req': true,
          'short': 'Transaction date and time (format: yyyymmddhhmmss).',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_id',
          'req': true,
          'short': 'Unique transaction identifier.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_origin_identifier',
          'short': 'Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_origin_indicator',
          'short': 'Transaction origin indicator: - 0 = Request for card data on PIN PAD.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_place',
          'short': 'The transaction place; the first 5 characters should contain a formatted zip code.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_source_id',
          'short': 'Identification number of the authorization source.',
          'type': '`\$STRING`',
        },
      ],
      'name': 'ecr_api',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/makeTransaction',
              'parts': <dynamic>[
                'makeTransaction',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
          ],
        },
        'load': <String, dynamic>{
          'input': 'data',
          'name': 'load',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'GET',
              'orig': '/version',
              'parts': <dynamic>[
                'version',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
  };

  // The pipeline context carries the config as a plain map.
  Map<String, dynamic> toMap() => <String, dynamic>{
        'main': main,
        'feature': feature,
        'options': options,
        'entity': entity,
      };
}

final config = Config();
