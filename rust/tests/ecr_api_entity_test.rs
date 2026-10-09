// Generated basic-flow test for the ecr_api entity (model-driven;
// mirrors the go TestEntity generator).

#![allow(unused_variables, unused_mut, unused_imports)]

mod common;

use std::rc::Rc;

use common::*;

use bluefin_tecs_ecr_sdk::core::helpers::{getp, getpath, ja, jo, now_ms, setp, to_map};
use bluefin_tecs_ecr_sdk::utility::voxgigstruct as vs;
use bluefin_tecs_ecr_sdk::{test_sdk, Entity, BluefinTecsEcrEntity, BluefinTecsEcrSDK, Value};

// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const LIVE_STRICT: bool = true;

#[test]
fn ecr_api_entity_instance() {
    let testsdk = test_sdk(Value::Noval, Value::Noval);
    let ent = testsdk.ecr_api(Value::Noval);
    assert_eq!(ent.get_name(), "ecr_api");
}

#[test]
fn ecr_api_entity_validate() {
    if getp(&getp(&bluefin_tecs_ecr_sdk::make_config(), "feature"), "validate").is_noval() {
        return;
    }
    let client = test_sdk(Value::Noval, jo(vec![(
        "feature",
        jo(vec![("validate", jo(vec![("active", Value::Bool(true))]))]),
    )]));
    let err = client
        .ecr_api(Value::Noval)
        .load(jo(vec![("amount", Value::Num(1.0))]), Value::Noval)
        .err()
        .expect("an invalid request should fail");
    assert_eq!(err.code, "validate_failed");
}

#[test]
fn ecr_api_entity_basic() {
    let setup = ecr_api_basic_setup(Value::Noval);
    // Per-op sdk-test-control.json skip — the basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    let mode = if setup.live { "live" } else { "unit" };
    for op in ["create", "load"] {
        let (skip, reason) = is_control_skipped("entityOp", &format!("ecr_api.{}", op), mode);
        if skip {
            let reason = if reason.is_empty() {
                "skipped via sdk-test-control.json".to_string()
            } else {
                reason
            };
            eprintln!("skip: {}", reason);
            return;
        }
    }
    let client = setup.client.clone();
    // CREATE
    let ecr_api_ref01_ent = client.ecr_api(Value::Noval);
    let ecr_api_ref01_data = to_map(&getp(
        &getpath(&["new", "ecr_api"], &setup.data),
        "ecr_api_ref01",
    ));

    let ecr_api_ref01_data_result = ecr_api_ref01_ent
        .create(ecr_api_ref01_data.clone(), Value::Noval)
        .expect("create failed");
    let ecr_api_ref01_data = to_map(&ecr_api_ref01_data_result.data(None));
    assert!(
        matches!(ecr_api_ref01_data, Value::Map(_)),
        "expected create result to be a map"
    );

    // LOAD
    let ecr_api_ref01_match_dt0 = Value::empty_map();
    let ecr_api_ref01_data_dt0_loaded = ecr_api_ref01_ent
        .load(ecr_api_ref01_match_dt0.clone(), Value::Noval)
        .expect("load failed");
    // load resolves to the ENTITY; the record is reached through data().
    assert!(
        !ecr_api_ref01_data_dt0_loaded.data(None).is_noval(),
        "expected load result to carry data"
    );

}

fn ecr_api_basic_setup(extra: Value) -> EntityTestSetup {
    load_env_local();

    let mut entity_data_file = manifest_dir();
    entity_data_file.push("..");
    entity_data_file.push(".sdk");
    entity_data_file.push("test");
    entity_data_file.push("entity");
    entity_data_file.push("ecr_api");
    entity_data_file.push("EcrApiTestData.json");

    let entity_data = read_json(&entity_data_file);

    let options = jo(vec![("entity", getp(&entity_data, "existing"))]);

    let client = test_sdk(options, extra.clone());

    // Generate idmap via transform, matching the TS pattern.
    let idmap = vs::transform(
        &ja(vec![Value::str("ecr_api01"), Value::str("ecr_api02"), Value::str("ecr_api03")]),
        &jo(vec![(
            "`$PACK`",
            ja(vec![
                Value::str(""),
                jo(vec![
                    ("`$KEY`", Value::str("`$COPY`")),
                    (
                        "`$VAL`",
                        ja(vec![
                            Value::str("`$FORMAT`"),
                            Value::str("upper"),
                            Value::str("`$COPY`"),
                        ]),
                    ),
                ]),
            ]),
        )]),
        None,
    )
    .unwrap_or_else(|_| Value::empty_map());

    // Whether *_ENTID supplied the idmap, read before env_override consumes
    // it: without it, the ids a live flow binds are the fixture's synthetic ones.
    let entid_env_raw = std::env::var("BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID").unwrap_or_default();
    let idmap_overridden =
        !entid_env_raw.trim().is_empty() && entid_env_raw.trim().starts_with('{');

    let env = env_override(jo(vec![
        ("BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID", idmap.clone()),
        ("BLUEFIN_TECS_ECR_TEST_LIVE", Value::str("FALSE")),
        ("BLUEFIN_TECS_ECR_TEST_EXPLAIN", Value::str("FALSE")),
        ("BLUEFIN_TECS_ECR_APIKEY", Value::str("")),
    ]));

    let idmap_resolved = match to_map(&getp(&env, "BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID")) {
        Value::Map(m) => Value::Map(m),
        _ => to_map(&idmap),
    };

    let live = getp(&env, "BLUEFIN_TECS_ECR_TEST_LIVE") == Value::str("TRUE");

    let client = if live {
        let merged = vs::merge(
            // live_client_options() FIRST, so the generated entries below win:
            // sdk-test-control.json's test.client.options adds to the live
            // client, it does not redirect it.
            &ja(vec![
                live_client_options(),
                jo(vec![("apikey", getp(&env, "BLUEFIN_TECS_ECR_APIKEY"))]),
                // A NON-NODE later entry REPLACES the accumulated map in
                // vs::merge, and the normal call passes Value::Noval - so a
                // a bare extra discarded live_client_options() and the
                // apikey/server map above it, and the live client was
                // constructed with nothing.
                match extra {
                    Value::Map(m) => Value::Map(m),
                    _ => Value::empty_map(),
                },
            ]),
            None,
        );
        BluefinTecsEcrSDK::new(to_map(&merged))
    } else {
        client
    };

    EntityTestSetup {
        client,
        data: entity_data,
        idmap: idmap_resolved,
        env: env.clone(),
        explain: getp(&env, "BLUEFIN_TECS_ECR_TEST_EXPLAIN") == Value::str("TRUE"),
        live,
        synthetic_only: live && !idmap_overridden,
        now: now_ms(),
    }
}
