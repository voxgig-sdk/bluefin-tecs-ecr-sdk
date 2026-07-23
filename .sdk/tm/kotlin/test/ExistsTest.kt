package KOTLINPACKAGE.sdktest

import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Test

import KOTLINPACKAGE.core.BluefinTecsEcrSDK

class ExistsTest {

  @Test
  fun testMode() {
    val testsdk = BluefinTecsEcrSDK.testSDK()
    assertNotNull(testsdk, "expected non-nil SDK")
  }
}
