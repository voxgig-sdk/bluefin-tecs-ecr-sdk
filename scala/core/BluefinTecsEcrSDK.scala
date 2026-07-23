package voxgig.bluefintecsecrsdk.core

import java.util.{Map => JMap}

// BluefinTecsEcr SDK client. All transport and pipeline behaviour lives in the
// SdkClient base (core/SdkClient.scala); this class binds the API-specific
// entity accessors and the test-mode constructor.
class BluefinTecsEcrSDK(options: JMap[String, Object]) extends SdkClient(options) {

  def this() = this(null)


  /**
   * Returns a ecr_api entity bound to this client.
   * Idiomatic usage: client.ecrApi(null).list(null, null) or
   * client.ecrApi(null).load(java.util.Map.of("id", ...), null).
   */
  def ecrApi(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.bluefintecsecrsdk.entity.EcrApiEntity(this, entopts)


}

object BluefinTecsEcrSDK {

  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  def testSDK(): BluefinTecsEcrSDK = testSDK(null, null)

  def testSDK(testopts: JMap[String, Object], sdkopts: JMap[String, Object]): BluefinTecsEcrSDK = {
    val sdk = new BluefinTecsEcrSDK(SdkClient.testOptions(testopts, sdkopts))
    sdk.mode = "test"
    sdk
  }
}
