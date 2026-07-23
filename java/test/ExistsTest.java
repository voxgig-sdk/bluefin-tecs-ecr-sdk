package voxgig.bluefintecsecrsdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import voxgig.bluefintecsecrsdk.core.BluefinTecsEcrSDK;

public class ExistsTest {

  @Test
  public void testMode() {
    BluefinTecsEcrSDK testsdk = BluefinTecsEcrSDK.testSDK();
    assertNotNull(testsdk, "expected non-nil SDK");
  }
}
