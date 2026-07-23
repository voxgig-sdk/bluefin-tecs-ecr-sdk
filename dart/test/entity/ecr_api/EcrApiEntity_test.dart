// ignore_for_file: unused_import, unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import '../../harness.dart';
import '../../utility.dart';

import '../../../lib/BluefinTecsEcrSDK.dart';
import '../../../lib/utility/voxgig_struct.dart' as vs;

void tests() {
  describe('EcrApiEntity', () {
    test('instance', (t) async {
      final testsdk = BluefinTecsEcrSDK.test();
      final ent = testsdk.EcrApi();
      ok(null != ent);
    });



    test('basic', (t) async {

      final live = 'TRUE' == Platform.environment['BLUEFIN_TECS_ECR_TEST_LIVE'];
      for (final op in ['create', 'load']) {
        if (maybeSkipControl(t, 'entityOp', 'ecr_api.' + op, live)) {
          return;
        }
      }

      final setup = basicSetup();
      // The basic flow consumes synthetic IDs and field values from the
      // fixture (entity TestData.json). Those don't exist on the live API.
      // Skip live runs unless the user provided a real ENTID env override.
      if (true == setup['syntheticOnly']) {
        t.skip('live entity test uses synthetic IDs from fixture — set BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID JSON to run live');
        return;
      }
      final client = setup['client'];
      final struct = setup['struct'];

      final isempty = struct.isempty;
      final select = struct.select;


      // CREATE
      final ecr_api_ref01_ent = client.EcrApi();
      dynamic ecr_api_ref01_data = setup['data']['new']['ecr_api']['ecr_api_ref01'];

      ecr_api_ref01_data = await ecr_api_ref01_ent.create(ecr_api_ref01_data);
      ok(null != ecr_api_ref01_data);


      // LOAD
      final ecr_api_ref01_match_dt0 = <String, dynamic>{};
      final ecr_api_ref01_data_dt0 = await ecr_api_ref01_ent.load(ecr_api_ref01_match_dt0);
      ok(null != ecr_api_ref01_data_dt0);


    });
  });
}


Map<String, dynamic> basicSetup([dynamic extra]) {
  final options = <String, dynamic>{};

  final entityDataFile = resolveTestPath(
      '../.sdk/test/entity/ecr_api/EcrApiTestData.json');

  final entityDataSource = File(entityDataFile).readAsStringSync();

  final entityData = jsonDecode(entityDataSource);

  options['entity'] = entityData['existing'];

  var client = BluefinTecsEcrSDK.test(options, extra);
  final struct = client.utility().struct;
  final merge = struct.merge;
  final transform = struct.transform;

  dynamic idmap = transform(
      <dynamic>['ecr_api01', 'ecr_api02', 'ecr_api03'],
      <String, dynamic>{
        '`\$PACK`': <dynamic>[
          '',
          <String, dynamic>{
            '`\$KEY`': '`\$COPY`',
            '`\$VAL`': <dynamic>['`\$FORMAT`', 'upper', '`\$COPY`'],
          }
        ]
      });

  // Detect whether the user provided a real ENTID JSON via env var. The
  // basic flow consumes synthetic IDs from the fixture file; without an
  // override those synthetic IDs reach the live API and 4xx. Surface this
  // to the test so it can skip rather than fail.
  final idmapEnvVal =
      Platform.environment['BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID'];
  final idmapOverridden =
      null != idmapEnvVal && idmapEnvVal.trim().startsWith('{');

  final env = envOverride({
    'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID': idmap,
    'BLUEFIN_TECS_ECR_TEST_LIVE': 'FALSE',
    'BLUEFIN_TECS_ECR_TEST_EXPLAIN': 'FALSE',
    'BLUEFIN_TECS_ECR_APIKEY': 'NONE',
  });

  idmap = env['BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID'];

  final live = 'TRUE' == env['BLUEFIN_TECS_ECR_TEST_LIVE'];

  if (live) {
    client = BluefinTecsEcrSDK(merge([
      <String, dynamic>{
        'apikey': env['BLUEFIN_TECS_ECR_APIKEY'],
      },
      extra
    ]));
  }

  final setup = <String, dynamic>{
    'idmap': idmap,
    'env': env,
    'options': options,
    'client': client,
    'struct': struct,
    'data': entityData,
    'explain': 'TRUE' == env['BLUEFIN_TECS_ECR_TEST_EXPLAIN'],
    'live': live,
    'syntheticOnly': live && !idmapOverridden,
    'now': DateTime.now().millisecondsSinceEpoch,
  };

  return setup;
}

