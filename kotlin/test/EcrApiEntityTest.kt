package voxgig.bluefintecsecrsdk.sdktest

import java.nio.file.Files
import java.nio.file.Paths

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Assertions.assertThrows
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Assumptions
import org.junit.jupiter.api.Test

import voxgig.bluefintecsecrsdk.core.Config
import voxgig.bluefintecsecrsdk.core.Context
import voxgig.bluefintecsecrsdk.core.Helpers
import voxgig.bluefintecsecrsdk.core.SdkEntity
import voxgig.bluefintecsecrsdk.core.SdkError
import voxgig.bluefintecsecrsdk.core.BluefinTecsEcrSDK
import voxgig.bluefintecsecrsdk.feature.BaseFeature
import voxgig.bluefintecsecrsdk.utility.Json
import voxgig.bluefintecsecrsdk.utility.struct.Struct

@Suppress("UNCHECKED_CAST", "UNUSED_VARIABLE", "UNUSED_VALUE")
class EcrApiEntityTest {

  // main.kit.test.live.strict is true (the default is true): a live
  // request that fails, or a live test missing an input it needs,
  // fails the test.
  // An account with no record for a test to read skips it either way.
  private val LIVE_STRICT = true

  @Test
  fun instance() {
    val testsdk = BluefinTecsEcrSDK.testSDK()
    val ent = testsdk.ecrApi(null)
    assertNotNull(ent, "expected non-null ecr_api entity")
  }

  @Test
  fun basic() {
    val setup = ecrApiBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf<String>("create", "load")) {
      val reason = RunnerSupport.skipReason("entityOp", "ecr_api.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    val client = setup.client

    // CREATE
    val ecrApiRef01Ent = client.ecrApi(null)
    var ecrApiRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.ecr_api"), "ecr_api_ref01")) ?: linkedMapOf())

    val ecrApiRef01DataResult = ecrApiRef01Ent.create(ecrApiRef01Data, null)
    ecrApiRef01Data = Helpers.toMapAny(if (ecrApiRef01DataResult is SdkEntity) ecrApiRef01DataResult.data() else ecrApiRef01DataResult) ?: linkedMapOf()
    assertNotNull(ecrApiRef01Data, "expected create result to be a map")

    // LOAD
    val ecrApiRef01MatchDt0 = linkedMapOf<String, Any?>()
    val ecrApiRef01DataDt0Loaded = ecrApiRef01Ent.load(ecrApiRef01MatchDt0, null)
    assertNotNull(ecrApiRef01DataDt0Loaded, "expected load result to be non-null")

  }

  private fun hasFeature(name: String): Boolean {
    val fm = Helpers.toMapAny(Config.sharedConfig()["feature"])
    return fm != null && fm[name] != null
  }

  @Test
  fun validate() {
    Assumptions.assumeTrue(hasFeature("validate"), "feature not present in this SDK: validate")
    val client = BluefinTecsEcrSDK.testSDK(null, linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "validate" to linkedMapOf<String, Any?>("active" to true))))
    val err = assertThrows(SdkError::class.java) {
      client.ecrApi(null).load(linkedMapOf<String, Any?>("amount" to 1), null)
    }
    assertEquals("validate_failed", err.code)
  }

  companion object {
    fun ecrApiBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "ecr_api", "EcrApiTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read ecr_api test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = BluefinTecsEcrSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("ecr_api01")
      idnames.add("ecr_api02")
      idnames.add("ecr_api03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Whether *_ENTID supplied the idmap, read before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID"] = idmap
      envm["BLUEFIN_TECS_ECR_TEST_LIVE"] = "FALSE"
      envm["BLUEFIN_TECS_ECR_TEST_EXPLAIN"] = "FALSE"
      envm["BLUEFIN_TECS_ECR_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID"])
      if (idmapResolved == null) {
        idmapResolved = Helpers.toMapAny(idmap) ?: linkedMapOf()
      }

      val live = "TRUE" == env["BLUEFIN_TECS_ECR_TEST_LIVE"]
      if (live) {
        val liveOpts = linkedMapOf<String, Any?>()
        liveOpts["apikey"] = env["BLUEFIN_TECS_ECR_APIKEY"]
        val mergedOpts = Struct.merge(Struct.jt(liveOpts, extra))
        client = BluefinTecsEcrSDK(Helpers.toMapAny(mergedOpts))
      }

      val setup = RunnerSupport.EntityTestSetup()
      setup.client = client
      setup.data = entityData
      setup.idmap = idmapResolved
      setup.env = env
      setup.explain = "TRUE" == env["BLUEFIN_TECS_ECR_TEST_EXPLAIN"]
      setup.live = live
      setup.syntheticOnly = live && !idmapOverridden
      setup.now = System.currentTimeMillis()
      return setup
    }
  }
}
