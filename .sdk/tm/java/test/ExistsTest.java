package JAVAPACKAGE.sdktest;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import JAVAPACKAGE.core.BluefinTecsEcrSDK;

public class ExistsTest {

  @Test
  public void testMode() {
    BluefinTecsEcrSDK testsdk = BluefinTecsEcrSDK.testSDK();
    assertNotNull(testsdk, "expected non-nil SDK");
  }
}
