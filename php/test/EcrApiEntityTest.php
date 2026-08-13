<?php
declare(strict_types=1);

// EcrApi entity test

require_once __DIR__ . '/../bluefintecsecr_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class EcrApiEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = BluefinTecsEcrSDK::test(null, null);
        $ent = $testsdk->EcrApi(null);
        $this->assertNotNull($ent);
    }

    public function test_basic_flow(): void
    {
        $setup = ecr_api_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["create", "load"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "ecr_api." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // CREATE
        $ecr_api_ref01_ent = $client->EcrApi(null);
        $ecr_api_ref01_data = Helpers::to_map(Vs::getprop(
            Vs::getpath($setup["data"], "new.ecr_api"), "ecr_api_ref01"));

        $ecr_api_ref01_data_result = $ecr_api_ref01_ent->create($ecr_api_ref01_data, null);
        $ecr_api_ref01_data = Helpers::to_map(is_object($ecr_api_ref01_data_result) && method_exists($ecr_api_ref01_data_result, 'data_get') ? $ecr_api_ref01_data_result->data_get() : $ecr_api_ref01_data_result);
        $this->assertNotNull($ecr_api_ref01_data);

        // LOAD
        $ecr_api_ref01_match_dt0 = [];
        $ecr_api_ref01_data_dt0_loaded = $ecr_api_ref01_ent->load($ecr_api_ref01_match_dt0, null);
        $this->assertNotNull($ecr_api_ref01_data_dt0_loaded);

    }
}

function ecr_api_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/ecr_api/EcrApiTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = BluefinTecsEcrSDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["ecr_api01", "ecr_api02", "ecr_api03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID" => $idmap,
        "BLUEFIN_TECS_ECR_TEST_LIVE" => "FALSE",
        "BLUEFIN_TECS_ECR_TEST_EXPLAIN" => "FALSE",
        "BLUEFIN_TECS_ECR_APIKEY" => "NONE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["BLUEFIN_TECS_ECR_TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
                "apikey" => $env["BLUEFIN_TECS_ECR_APIKEY"],
            ],
            $extra ?? [],
        ]);
        $client = new BluefinTecsEcrSDK(Helpers::to_map($merged_opts));
    }

    $live = $env["BLUEFIN_TECS_ECR_TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["BLUEFIN_TECS_ECR_TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}
