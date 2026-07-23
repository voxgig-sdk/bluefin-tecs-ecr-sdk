import 'harness.dart';

import '../lib/BluefinTecsEcrSDK.dart';

void tests() {
  describe('exists', () {
    test('test-mode', (t) async {
      final testsdk = BluefinTecsEcrSDK.test();
      equal(true, null != testsdk);
    });
  });
}
