// Generated basic-flow test for the ecr_api entity (model-driven;
// mirrors the go TestEntity generator).

#![allow(unused_variables, unused_mut, unused_imports)]

mod common;

use std::rc::Rc;

use common::*;

use bluefin_tecs_ecr_sdk::core::helpers::{getp, getpath, ja, jo, now_ms, setp, to_map};
use bluefin_tecs_ecr_sdk::utility::voxgigstruct as vs;
use bluefin_tecs_ecr_sdk::{test_sdk, Entity, BluefinTecsEcrEntity, BluefinTecsEcrSDK, Value};

#[test]
fn ecr_api_entity_instance() {
    let testsdk = test_sdk(Value::Noval, Value::Noval);
    let ent = testsdk.ecr_api(Value::Noval);
    assert_eq!(ent.get_name(), "ecr_api");
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
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup.synthetic_only {
        eprintln!("skip: live entity test uses synthetic IDs from fixture — set BLUEFINTECSECR_TEST_ECR_API_ENTID JSON to run live");
        return;
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
    let ecr_api_ref01_data = to_map(&ecr_api_ref01_data_result);
    assert!(
        matches!(ecr_api_ref01_data, Value::Map(_)),
        "expected create result to be a map"
    );

    // LOAD
    let ecr_api_ref01_match_dt0 = Value::empty_map();
    let ecr_api_ref01_data_dt0_loaded = ecr_api_ref01_ent
        .load(ecr_api_ref01_match_dt0.clone(), Value::Noval)
        .expect("load failed");
    assert!(
        !ecr_api_ref01_data_dt0_loaded.is_noval(),
        "expected load result to be non-nil"
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

    // Detect ENTID env override before env_override consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's.
    let entid_env_raw = std::env::var("BLUEFINTECSECR_TEST_ECR_API_ENTID").unwrap_or_default();
    let idmap_overridden =
        !entid_env_raw.trim().is_empty() && entid_env_raw.trim().starts_with('{');

    let env = env_override(jo(vec![
        ("BLUEFINTECSECR_TEST_ECR_API_ENTID", idmap.clone()),
        ("BLUEFINTECSECR_TEST_LIVE", Value::str("FALSE")),
        ("BLUEFINTECSECR_TEST_EXPLAIN", Value::str("FALSE")),
        ("BLUEFINTECSECR_APIKEY", Value::str("NONE")),
    ]));

    let idmap_resolved = match to_map(&getp(&env, "BLUEFINTECSECR_TEST_ECR_API_ENTID")) {
        Value::Map(m) => Value::Map(m),
        _ => to_map(&idmap),
    };

    let live = getp(&env, "BLUEFINTECSECR_TEST_LIVE") == Value::str("TRUE");

    let client = if live {
        let merged = vs::merge(
            &ja(vec![jo(vec![("apikey", getp(&env, "BLUEFINTECSECR_APIKEY"))]), extra]),
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
        explain: getp(&env, "BLUEFINTECSECR_TEST_EXPLAIN") == Value::str("TRUE"),
        live,
        synthetic_only: live && !idmap_overridden,
        now: now_ms(),
    }
}
