// ecr_api entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace BluefinTecsEcrSdk.Test;

public class EcrApiEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = BluefinTecsEcrSDK.TestSDK(null, null);
        var ent = testsdk.EcrApi();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = EcrApiBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "load" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "ecr_api." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // CREATE
        var ecrApiRef01Ent = client.EcrApi();
        var ecrApiRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "ecr_api")),
            "ecr_api_ref01"));

        var ecrApiRef01DataResult = ecrApiRef01Ent.Create(ecrApiRef01Data, null);
        ecrApiRef01Data = Helpers.ToMapAny(ecrApiRef01DataResult is IEntity ce ? ce.Data() : ecrApiRef01DataResult);
        Assert.True(ecrApiRef01Data != null, "expected create result to be a map");

        // LOAD
        var ecrApiRef01MatchDt0 = new Dictionary<string, object?>();
        var ecrApiRef01DataDt0Loaded = ecrApiRef01Ent.Load(ecrApiRef01MatchDt0, null);
        Assert.True(ecrApiRef01DataDt0Loaded != null, "expected load result to be non-null");

    }

    private static EntityTestSetup EcrApiBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "ecr_api",
            "EcrApiTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse ecr_api test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = BluefinTecsEcrSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "ecr_api01", "ecr_api02", "ecr_api03" },
            new Dictionary<string, object?>
            {
                ["`$PACK`"] = new List<object?>
                {
                    "",
                    new Dictionary<string, object?>
                    {
                        ["`$KEY`"] = "`$COPY`",
                        ["`$VAL`"] = new List<object?> { "`$FORMAT`", "upper", "`$COPY`" },
                    },
                },
            });

        // Detect ENTID env override before EnvOverride consumes it. When
        // live mode is on without a real override, the basic test runs
        // against synthetic IDs from the fixture and 4xx's.
        var entidEnvRaw = Environment.GetEnvironmentVariable(
            "BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID"] = idmap,
            ["BLUEFIN_TECS_ECR_TEST_LIVE"] = "FALSE",
            ["BLUEFIN_TECS_ECR_TEST_EXPLAIN"] = "FALSE",
            ["BLUEFIN_TECS_ECR_APIKEY"] = "NONE",
        });

        var idmapResolved = Helpers.ToMapAny(env["BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID"])
            ?? Helpers.ToMapAny(idmap)
            ?? new Dictionary<string, object?>();

        if (Equals(env["BLUEFIN_TECS_ECR_TEST_LIVE"], "TRUE"))
        {
            var mergedOpts = StructUtils.Merge(new List<object?>
            {
                new Dictionary<string, object?>
                {
                    ["apikey"] = env["BLUEFIN_TECS_ECR_APIKEY"],
                },
                extra,
            });
            client = new BluefinTecsEcrSDK(Helpers.ToMapAny(mergedOpts));
        }

        var live = Equals(env["BLUEFIN_TECS_ECR_TEST_LIVE"], "TRUE");
        return new EntityTestSetup
        {
            Client = client,
            Data = entityData,
            Idmap = idmapResolved,
            Env = env,
            Explain = Equals(env["BLUEFIN_TECS_ECR_TEST_EXPLAIN"], "TRUE"),
            Live = live,
            SyntheticOnly = live && !idmapOverridden,
            Now = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds(),
        };
    }
}
