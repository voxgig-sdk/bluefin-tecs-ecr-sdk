package voxgig.bluefintecsecrsdk.core

/**
 * BluefinTecsEcr SDK client. All transport and pipeline behaviour lives in the
 * SdkClient base (core/SdkClient.kt); this class binds the API-specific
 * entity accessors and the test-mode constructor.
 */
class BluefinTecsEcrSDK(options: MutableMap<String, Any?>?) : SdkClient(options) {

  constructor() : this(null)


  /**
   * Returns a ecr_api entity bound to this client.
   * Idiomatic usage: client.ecrApi(null).list(null, null) or
   * client.ecrApi(null).load(mutableMapOf("id" to ...), null).
   */
  fun ecrApi(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.bluefintecsecrsdk.entity.EcrApiEntity(this, entopts)
  }


  companion object {
    // testSDK builds a client in test mode: the test feature is activated,
    // installing the in-memory mock transport (no network activity).
    fun testSDK(): BluefinTecsEcrSDK = testSDK(null, null)

    fun testSDK(
      testopts: MutableMap<String, Any?>?,
      sdkopts: MutableMap<String, Any?>?,
    ): BluefinTecsEcrSDK {
      val sdk = BluefinTecsEcrSDK(testOptions(testopts, sdkopts))
      sdk.mode = "test"
      return sdk
    }
  }
}
