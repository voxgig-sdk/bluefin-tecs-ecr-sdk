package voxgig.bluefintecsecrsdk.core;

import java.util.Map;

/**
 * BluefinTecsEcr SDK client. All transport and pipeline behaviour lives in
 * the SdkClient base (core/SdkClient.java); this class binds the
 * API-specific entity accessors and the test-mode constructor.
 */
public class BluefinTecsEcrSDK extends SdkClient {

  public BluefinTecsEcrSDK() {
    this(null);
  }

  public BluefinTecsEcrSDK(Map<String, Object> options) {
    super(options);
  }


  /**
   * Returns a ecr_api entity bound to this client.
   * Idiomatic usage: client.ecrApi(null).list(null, null) or
   * client.ecrApi(null).load(Map.of("id", ...), null).
   */
  public SdkEntity ecrApi(Map<String, Object> entopts) {
    return new voxgig.bluefintecsecrsdk.entity.EcrApiEntity(this, entopts);
  }


  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  public static BluefinTecsEcrSDK testSDK() {
    return testSDK(null, null);
  }

  public static BluefinTecsEcrSDK testSDK(
      Map<String, Object> testopts, Map<String, Object> sdkopts) {
    BluefinTecsEcrSDK sdk = new BluefinTecsEcrSDK(SdkClient.testOptions(testopts, sdkopts));
    sdk.mode = "test";
    return sdk;
  }
}
