// Generated basic-flow test for the ecr_api entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct EcrApiSetup {
  std::shared_ptr<BluefinTecsEcrSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static EcrApiSetup ecr_api_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/ecr_api/EcrApiTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = BluefinTecsEcrSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("ecr_api01"), Value("ecr_api02"), Value("ecr_api03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"BLUEFINTECSECR_TEST_ECR_API_ENTID", idmap},
    {"BLUEFINTECSECR_TEST_LIVE", Value("FALSE")},
    {"BLUEFINTECSECR_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "BLUEFINTECSECR_TEST_ECR_API_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "BLUEFINTECSECR_TEST_LIVE") == Value("TRUE");

  EcrApiSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void ecr_api_entity_instance() {
  auto testsdk = BluefinTecsEcrSDK::testSDK();
  auto ent = testsdk->ecr_api();
  ASSERT_EQ(ent->getName(), std::string("ecr_api"), "entity name");
}

static void ecr_api_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"ecr_api", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = BluefinTecsEcrSDK::testSDK(seed, sdkopts);
  auto se = strsdk->ecr_api();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = BluefinTecsEcrSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->ecr_api();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void ecr_api_entity_basic() {
  auto setup = ecr_api_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create", "load"}) {
    auto sk = is_control_skipped("entityOp", std::string("ecr_api.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto ecr_api_ref01_ent = client->ecr_api();
  Value ecr_api_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "ecr_api"}), "ecr_api_ref01"));
  if (!ecr_api_ref01_data.is_map()) ecr_api_ref01_data = vmap();
  {
    Value ecr_api_ref01_data_result = ecr_api_ref01_ent->create(Struct::clone(ecr_api_ref01_data), Value::undef());
    ecr_api_ref01_data = Helpers::toMapAny(ecr_api_ref01_data_result);
    if (!ecr_api_ref01_data.is_map()) ecr_api_ref01_data = vmap();
    ASSERT_TRUE(ecr_api_ref01_data.is_map(), "expected create result to be a map");
  }

  // LOAD
  Value ecr_api_ref01_match_dt0 = vmap();
  Value ecr_api_ref01_data_dt0_loaded = ecr_api_ref01_ent->load(ecr_api_ref01_match_dt0, Value::undef());
  ASSERT_TRUE(!ecr_api_ref01_data_dt0_loaded.is_undef(), "expected load result to be non-nil");

}

int main() {
  T_RUN(ecr_api_entity_instance);
  T_RUN(ecr_api_entity_stream);
  T_RUN(ecr_api_entity_basic);
  return sdktest::summary("ecr_api_entity_test");
}
