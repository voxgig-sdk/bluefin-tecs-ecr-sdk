// Generated basic-flow test for the ecr_api entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped EcrApiTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefintecsecrsdk.core.{Helpers, SdkEntity, BluefinTecsEcrSDK}
import voxgig.bluefintecsecrsdk.utility.struct.Struct

object EcrApiEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("ecr_api.instance") {
      val testsdk = BluefinTecsEcrSDK.testSDK()
      val ent = testsdk.ecrApi(null)
      rep.check("ecr_api.instance", ent != null, "expected non-null ecr_api entity")
    }

    rep.scope("ecr_api.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/ecr_api/EcrApiTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = BluefinTecsEcrSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("ecr_api01", "ECR_API01")
      idmap.put("ecr_api02", "ECR_API02")
      idmap.put("ecr_api03", "ECR_API03")
      val now = System.currentTimeMillis()

      // CREATE
      val ecrApiRef01Ent = client.ecrApi(null)
      var ecrApiRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.ecr_api"), "ecr_api_ref01"))
      val ecrApiRef01DataResult = ecrApiRef01Ent.create(ecrApiRef01Data, null)
      ecrApiRef01Data = Helpers.toMapAny(ecrApiRef01DataResult match { case e: SdkEntity => e.data(); case o => o })
      rep.check("ecr_api.create.map", ecrApiRef01Data != null, "expected create result to be a map")

      // LOAD
      val ecrApiRef01MatchDt0 = new LinkedHashMap[String, Object]()
      val ecrApiRef01DataDt0Loaded = ecrApiRef01Ent.load(ecrApiRef01MatchDt0, null)
      rep.check("ecr_api.load.nonnull", ecrApiRef01DataDt0Loaded != null, "expected load result to be non-null")
    }
  }
}
