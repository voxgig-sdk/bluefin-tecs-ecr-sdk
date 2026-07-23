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
    'name': 'ProjectName',
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
          'active': true,
          'name': 'amount',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'authorization_number',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'card_number',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 2,
        },
        <String, dynamic>{
          'active': true,
          'name': 'currency',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 3,
        },
        <String, dynamic>{
          'active': true,
          'name': 'cvc2',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 4,
        },
        <String, dynamic>{
          'active': true,
          'name': 'desired_currency',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 5,
        },
        <String, dynamic>{
          'active': true,
          'name': 'ecr_data',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 6,
        },
        <String, dynamic>{
          'active': true,
          'name': 'language',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 7,
        },
        <String, dynamic>{
          'active': true,
          'name': 'message_type',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 8,
        },
        <String, dynamic>{
          'active': true,
          'name': 'password',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 9,
        },
        <String, dynamic>{
          'active': true,
          'name': 'payment_reason',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 10,
        },
        <String, dynamic>{
          'active': true,
          'name': 'payment_reason_as_byte',
          'req': false,
          'type': '`\$ARRAY`',
          'index\$': 11,
        },
        <String, dynamic>{
          'active': true,
          'name': 'personal_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 12,
        },
        <String, dynamic>{
          'active': true,
          'name': 'receipt_layout',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 13,
        },
        <String, dynamic>{
          'active': true,
          'name': 'receipt_number',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 14,
        },
        <String, dynamic>{
          'active': true,
          'name': 'terminal_number',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 15,
        },
        <String, dynamic>{
          'active': true,
          'name': 'transaction_date_time',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 16,
        },
        <String, dynamic>{
          'active': true,
          'name': 'transaction_id',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 17,
        },
        <String, dynamic>{
          'active': true,
          'name': 'transaction_origin_identifier',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 18,
        },
        <String, dynamic>{
          'active': true,
          'name': 'transaction_origin_indicator',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 19,
        },
        <String, dynamic>{
          'active': true,
          'name': 'transaction_place',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 20,
        },
        <String, dynamic>{
          'active': true,
          'name': 'transaction_source_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 21,
        },
      ],
      'name': 'ecr_api',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 0,
            },
          ],
          'key\$': 'create',
        },
        'load': <String, dynamic>{
          'input': 'data',
          'name': 'load',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 0,
            },
          ],
          'key\$': 'load',
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
