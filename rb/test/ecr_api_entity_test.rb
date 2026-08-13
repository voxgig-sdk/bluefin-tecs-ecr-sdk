# EcrApi entity test

require "minitest/autorun"
require "json"
require_relative "../BluefinTecsEcr_sdk"
require_relative "runner"

class EcrApiEntityTest < Minitest::Test
  def test_create_instance
    testsdk = BluefinTecsEcrSDK.test(nil, nil)
    ent = testsdk.EcrApi(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = ecr_api_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["create", "load"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "ecr_api." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # CREATE
    ecr_api_ref01_ent = client.EcrApi(nil)
    ecr_api_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.ecr_api"), "ecr_api_ref01"))

    ecr_api_ref01_data_result = ecr_api_ref01_ent.create(ecr_api_ref01_data, nil)
    ecr_api_ref01_data = Helpers.to_map(ecr_api_ref01_data_result.respond_to?(:data_get) ? ecr_api_ref01_data_result.data_get : ecr_api_ref01_data_result)
    assert !ecr_api_ref01_data.nil?

    # LOAD
    ecr_api_ref01_match_dt0 = {}
    ecr_api_ref01_data_dt0_loaded = ecr_api_ref01_ent.load(ecr_api_ref01_match_dt0, nil)
    assert !ecr_api_ref01_data_dt0_loaded.nil?

  end
end

def ecr_api_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "ecr_api", "EcrApiTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = BluefinTecsEcrSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["ecr_api01", "ecr_api02", "ecr_api03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID" => idmap,
    "BLUEFIN_TECS_ECR_TEST_LIVE" => "FALSE",
    "BLUEFIN_TECS_ECR_TEST_EXPLAIN" => "FALSE",
    "BLUEFIN_TECS_ECR_APIKEY" => "NONE",
  })

  idmap_resolved = Helpers.to_map(
    env["BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["BLUEFIN_TECS_ECR_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
        "apikey" => env["BLUEFIN_TECS_ECR_APIKEY"],
      },
      extra || {},
    ])
    client = BluefinTecsEcrSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["BLUEFIN_TECS_ECR_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["BLUEFIN_TECS_ECR_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
