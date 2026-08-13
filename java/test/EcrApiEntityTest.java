package voxgig.bluefintecsecrsdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.Test;

import voxgig.bluefintecsecrsdk.core.Helpers;
import voxgig.bluefintecsecrsdk.core.SdkEntity;
import voxgig.bluefintecsecrsdk.core.BluefinTecsEcrSDK;
import voxgig.bluefintecsecrsdk.utility.Json;
import voxgig.bluefintecsecrsdk.utility.struct.Struct;

@SuppressWarnings({"unchecked", "unused"})
public class EcrApiEntityTest {

  @Test
  public void instance() {
    BluefinTecsEcrSDK testsdk = BluefinTecsEcrSDK.testSDK();
    SdkEntity ent = testsdk.ecrApi(null);
    assertNotNull(ent, "expected non-null ecr_api entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = ecrApiBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "create", "load" }) {
      String reason = RunnerSupport.skipReason("entityOp", "ecr_api." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    Assumptions.assumeFalse(setup.syntheticOnly,
        "live entity test uses synthetic IDs from fixture — set BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID JSON to run live");
    BluefinTecsEcrSDK client = setup.client;

    // CREATE
    SdkEntity ecrApiRef01Ent = client.ecrApi(null);
    Map<String, Object> ecrApiRef01Data = Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.ecr_api"), "ecr_api_ref01"));

    Object ecrApiRef01DataResult = ecrApiRef01Ent.create(ecrApiRef01Data, null);
    ecrApiRef01Data = Helpers.toMapAny(ecrApiRef01DataResult instanceof SdkEntity ? ((SdkEntity) ecrApiRef01DataResult).data() : ecrApiRef01DataResult);
    assertNotNull(ecrApiRef01Data, "expected create result to be a map");

    // LOAD
    Map<String, Object> ecrApiRef01MatchDt0 = new LinkedHashMap<>();
    Object ecrApiRef01DataDt0Loaded = ecrApiRef01Ent.load(ecrApiRef01MatchDt0, null);
    assertNotNull(ecrApiRef01DataDt0Loaded, "expected load result to be non-null");

  }

  static RunnerSupport.EntityTestSetup ecrApiBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "ecr_api", "EcrApiTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read ecr_api test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    BluefinTecsEcrSDK client = BluefinTecsEcrSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("ecr_api01");
    idnames.add("ecr_api02");
    idnames.add("ecr_api03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's. Surface this so the test
    // can skip.
    String entidEnvRaw = RunnerSupport.getenv("BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID", idmap);
    envm.put("BLUEFIN_TECS_ECR_TEST_LIVE", "FALSE");
    envm.put("BLUEFIN_TECS_ECR_TEST_EXPLAIN", "FALSE");
    envm.put("BLUEFIN_TECS_ECR_APIKEY", "NONE");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID"));
    if (idmapResolved == null) {
      idmapResolved = Helpers.toMapAny(idmap);
    }

    boolean live = "TRUE".equals(env.get("BLUEFIN_TECS_ECR_TEST_LIVE"));
    if (live) {
      Map<String, Object> liveOpts = new LinkedHashMap<>();
      liveOpts.put("apikey", env.get("BLUEFIN_TECS_ECR_APIKEY"));
      Object mergedOpts = Struct.merge(Struct.jt(liveOpts, extra));
      client = new BluefinTecsEcrSDK(Helpers.toMapAny(mergedOpts));
    }

    RunnerSupport.EntityTestSetup setup = new RunnerSupport.EntityTestSetup();
    setup.client = client;
    setup.data = entityData;
    setup.idmap = idmapResolved;
    setup.env = env;
    setup.explain = "TRUE".equals(env.get("BLUEFIN_TECS_ECR_TEST_EXPLAIN"));
    setup.live = live;
    setup.syntheticOnly = live && !idmapOverridden;
    setup.now = System.currentTimeMillis();
    return setup;
  }
}
