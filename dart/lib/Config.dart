import 'feature/base/BaseFeature.dart';
import 'feature/test/TestFeature.dart';


// ignore: non_constant_identifier_names
final Map<String, BaseFeature Function()> FEATURE_CLASS = {
    'test': () => TestFeature(),

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

  final Map<String, dynamic> main = <String, dynamic>{
    'name': 'BluefinTecsEcr',
  };

  final Map<String, dynamic> feature = <String, dynamic>{
        'test': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
    },

  };

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

    }
  };

  final Map<String, dynamic> entity = <String, dynamic>{
    'ecr_api': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'amount',
          'req': true,
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'authorization_number',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'card_number',
          'req': true,
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'currency',
          'req': true,
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'cvc2',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'desired_currency',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'ecr_data',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'language',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'message_type',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'password',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'payment_reason',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'payment_reasonAsByte',
          'type': '`\$ARRAY`',
        },
        <String, dynamic>{
          'name': 'personal_id',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'receipt_layout',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'receipt_number',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'terminal_number',
          'req': true,
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_date_time',
          'req': true,
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_id',
          'req': true,
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_origin_identifier',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_origin_indicator',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_place',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'transaction_source_id',
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
