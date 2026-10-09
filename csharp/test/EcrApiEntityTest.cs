// ecr_api entity test - basic flow (generated from the API model).

using System.Text.Json;

using BluefinTecsEcrSdk.Feature;
using Voxgig.Struct;
using Xunit;

namespace BluefinTecsEcrSdk.Test;

public class EcrApiEntityTest
{
    // main.kit.test.live.strict is true (the default is true): a live
    // request that fails, or a live test missing an input it needs,
    // fails the test.
    // An account with no record for a test to read skips it either way.
    private const bool LIVE_STRICT = true;

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

    [Fact]
    public void Validate()
    {
        if (!Fh.HasFeature("validate"))
        {
            Console.WriteLine("skip: feature not present in this SDK: validate");
            return;
        }
        var client = BluefinTecsEcrSDK.TestSDK(null,
            new Dictionary<string, object?> { ["feature"] = new Dictionary<string, object?> { ["validate"] = new Dictionary<string, object?> { ["active"] = true } } });
        var err = Assert.ThrowsAny<BluefinTecsEcrError>(() => client.EcrApi().Load(
            new Dictionary<string, object?> { ["amount"] = 1 }, null));
        Assert.Equal("validate_failed", err.Code);
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

        // Whether *_ENTID supplied the idmap, read before EnvOverride consumes
        // it: without it, the ids a live flow binds are the fixture's synthetic ones.
        var entidEnvRaw = Environment.GetEnvironmentVariable(
            "BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID"] = idmap,
            ["BLUEFIN_TECS_ECR_TEST_LIVE"] = "FALSE",
            ["BLUEFIN_TECS_ECR_TEST_EXPLAIN"] = "FALSE",
            ["BLUEFIN_TECS_ECR_APIKEY"] = "",
        });

        var idmapResolved = Helpers.ToMapAny(env["BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID"])
            ?? Helpers.ToMapAny(idmap)
            ?? new Dictionary<string, object?>();

        if (Equals(env["BLUEFIN_TECS_ECR_TEST_LIVE"], "TRUE"))
        {
            // 'extra ?? new ...', not a bare 'extra': Merge returns null when
            // the last entry is null, and BasicSetup is normally called with no
            // argument at all - so a bare 'extra' silently discarded the apikey
            // and server values above and handed the SDK null.
            var extraOpts = extra ?? new Dictionary<string, object?>();
            var mergedOpts = StructUtils.Merge(new List<object?>
            {
                // FIRST, so the generated fields below win: sdk-test-control.json's
                // test.client.options adds to the live client, it does not redirect it.
                TestRunner.LiveClientOptions(),
                new Dictionary<string, object?>
                {
                    ["apikey"] = env["BLUEFIN_TECS_ECR_APIKEY"],
                },
                extraOpts,
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
