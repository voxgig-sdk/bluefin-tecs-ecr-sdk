-- EcrApi entity test

local json = require("dkjson")
local vs = require("utility.struct.struct")
local sdk = require("bluefin-tecs-ecr_sdk")
local helpers = require("core.helpers")
local runner = require("test.runner")

local _test_dir = debug.getinfo(1, "S").source:match("^@(.+/)")  or "./"

describe("EcrApiEntity", function()
  it("should create instance", function()
    local testsdk = sdk.test(nil, nil)
    local ent = testsdk:EcrApi(nil)
    assert.is_not_nil(ent)
  end)

  it("should run basic flow", function()
    local setup = ecr_api_basic_setup(nil)
    -- Per-op sdk-test-control.json skip.
    local _live = setup.live or false
    for _, _op in ipairs({"create", "load"}) do
      local _should_skip, _reason = runner.is_control_skipped("entityOp", "ecr_api." .. _op, _live and "live" or "unit")
      if _should_skip then
        pending(_reason or "skipped via sdk-test-control.json")
        return
      end
    end
    -- The basic flow consumes synthetic IDs from the fixture. In live mode
    -- without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup.synthetic_only then
      pending("live entity test uses synthetic IDs from fixture — set BLUEFINTECSECR_TEST_ECR_API_ENTID JSON to run live")
      return
    end
    local client = setup.client

    -- CREATE
    local ecr_api_ref01_ent = client:EcrApi(nil)
    local ecr_api_ref01_data = helpers.to_map(vs.getprop(
      vs.getpath(setup.data, "new.ecr_api"), "ecr_api_ref01"))

    local ecr_api_ref01_data_result, err = ecr_api_ref01_ent:create(ecr_api_ref01_data, nil)
    assert.is_nil(err)
    ecr_api_ref01_data = helpers.to_map(ecr_api_ref01_data_result)
    assert.is_not_nil(ecr_api_ref01_data)

    -- LOAD
    local ecr_api_ref01_match_dt0 = {}
    local ecr_api_ref01_data_dt0_loaded, err = ecr_api_ref01_ent:load(ecr_api_ref01_match_dt0, nil)
    assert.is_nil(err)
    assert.is_not_nil(ecr_api_ref01_data_dt0_loaded)

  end)
end)

function ecr_api_basic_setup(extra)
  runner.load_env_local()

  local entity_data_file = _test_dir .. "../../.sdk/test/entity/ecr_api/EcrApiTestData.json"
  local f = io.open(entity_data_file, "r")
  if f == nil then
    error("failed to read ecr_api test data: " .. entity_data_file)
  end
  local entity_data_source = f:read("*a")
  f:close()

  local entity_data = json.decode(entity_data_source)

  local options = {}
  options["entity"] = entity_data["existing"]

  local client = sdk.test(options, extra)

  -- Generate idmap via transform.
  local idmap = vs.transform(
    { "ecr_api01", "ecr_api02", "ecr_api03" },
    {
      ["`$PACK`"] = { "", {
        ["`$KEY`"] = "`$COPY`",
        ["`$VAL`"] = { "`$FORMAT`", "upper", "`$COPY`" },
      }},
    }
  )

  -- Detect ENTID env override before envOverride consumes it. When live
  -- mode is on without a real override, the basic test runs against synthetic
  -- IDs from the fixture and 4xx's. Surface this so the test can skip.
  local entid_env_raw = os.getenv("BLUEFINTECSECR_TEST_ECR_API_ENTID")
  local idmap_overridden = entid_env_raw ~= nil and entid_env_raw:match("^%s*{") ~= nil

  local env = runner.env_override({
    ["BLUEFINTECSECR_TEST_ECR_API_ENTID"] = idmap,
    ["BLUEFINTECSECR_TEST_LIVE"] = "FALSE",
    ["BLUEFINTECSECR_TEST_EXPLAIN"] = "FALSE",
    ["BLUEFINTECSECR_APIKEY"] = "NONE",
  })

  local idmap_resolved = helpers.to_map(
    env["BLUEFINTECSECR_TEST_ECR_API_ENTID"])
  if idmap_resolved == nil then
    idmap_resolved = helpers.to_map(idmap)
  end

  if env["BLUEFINTECSECR_TEST_LIVE"] == "TRUE" then
    local merged_opts = vs.merge({
      {
        apikey = env["BLUEFINTECSECR_APIKEY"],
      },
      extra or {},
    })
    client = sdk.new(helpers.to_map(merged_opts))
  end

  local live = env["BLUEFINTECSECR_TEST_LIVE"] == "TRUE"
  return {
    client = client,
    data = entity_data,
    idmap = idmap_resolved,
    env = env,
    explain = env["BLUEFINTECSECR_TEST_EXPLAIN"] == "TRUE",
    live = live,
    synthetic_only = live and not idmap_overridden,
    now = os.time() * 1000,
  }
end
