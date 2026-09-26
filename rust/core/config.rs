// Generated API configuration (mirrors go core/config.go).

use std::cell::RefCell;
use std::rc::Rc;

use crate::core::types::FeatureRef;
use crate::utility::voxgigstruct::Value;

pub fn make_config() -> Value {
    Value::map_of([
        ("main".to_string(), Value::map_of([
            ("name".to_string(), Value::str("BluefinTecsEcr")),
            ("slug".to_string(), Value::str("bluefin-tecs-ecr")),
            ("version".to_string(), Value::str("0.1.1")),
            ("target".to_string(), Value::str("rust")),
        ])),
        ("feature".to_string(), Value::map_of([
            ("audit".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("actor".to_string(), Value::str("anonymous")),
                    ("max".to_string(), Value::Num(1000f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                    ("sink".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("clienttrack".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("clientVersion".to_string(), Value::str("0.0.1")),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("clientName".to_string(), Value::str("`$STRING`")),
                    ("clientVersion".to_string(), Value::str("`$STRING`")),
                    ("headers".to_string(), Value::str("`$MAP`")),
                    ("idgen".to_string(), Value::str("`$FUNCTION`")),
                    ("sessionId".to_string(), Value::str("`$STRING`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("debug".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("max".to_string(), Value::Num(100f64)),
                    ("redact".to_string(), Value::list(vec![
                        Value::str("authorization"),
                        Value::str("cookie"),
                        Value::str("set-cookie"),
                        Value::str("api-key"),
                        Value::str("apikey"),
                        Value::str("x-api-key"),
                        Value::str("idempotency-key"),
                    ])),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                    ("onEntry".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("idempotency".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("header".to_string(), Value::str("Idempotency-Key")),
                    ("methods".to_string(), Value::list(vec![
                        Value::str("POST"),
                        Value::str("PUT"),
                        Value::str("PATCH"),
                        Value::str("DELETE"),
                    ])),
                    ("ops".to_string(), Value::list(vec![
                        Value::str("create"),
                        Value::str("update"),
                        Value::str("remove"),
                    ])),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("keygen".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("log".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(true)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("level".to_string(), Value::str("`$STRING`")),
                    ("logger".to_string(), Value::str("`$ANY`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("metrics".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("paging".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("afterVar".to_string(), Value::str("after")),
                    ("cursorParam".to_string(), Value::str("cursor")),
                    ("firstVar".to_string(), Value::str("first")),
                    ("limitParam".to_string(), Value::str("limit")),
                    ("pageParam".to_string(), Value::str("page")),
                    ("startPage".to_string(), Value::Num(1f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("limit".to_string(), Value::str("`$NUMBER`")),
                    ("ops".to_string(), Value::str("`$LIST`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("ratelimit".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("burst".to_string(), Value::Num(5f64)),
                    ("rate".to_string(), Value::Num(5f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                    ("sleep".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("retry".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("factor".to_string(), Value::Num(2f64)),
                    ("maxDelay".to_string(), Value::Num(2000f64)),
                    ("minDelay".to_string(), Value::Num(50f64)),
                    ("retries".to_string(), Value::Num(2f64)),
                    ("statuses".to_string(), Value::list(vec![
                        Value::Num(408f64),
                        Value::Num(425f64),
                        Value::Num(429f64),
                        Value::Num(500f64),
                        Value::Num(502f64),
                        Value::Num(503f64),
                        Value::Num(504f64),
                    ])),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("jitter".to_string(), Value::str("`$BOOLEAN`")),
                    ("sleep".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
            ("telemetry".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("exporter".to_string(), Value::str("`$FUNCTION`")),
                    ("headers".to_string(), Value::str("`$MAP`")),
                    ("idgen".to_string(), Value::str("`$FUNCTION`")),
                    ("now".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("none")),
            ])),
            ("test".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("entity".to_string(), Value::str("`$MAP`")),
                    ("net".to_string(), Value::str("`$MAP`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("base")),
            ])),
            ("timeout".to_string(), Value::map_of([
                ("options".to_string(), Value::map_of([
                    ("active".to_string(), Value::Bool(false)),
                    ("ms".to_string(), Value::Num(30000f64)),
                ])),
                ("optspec".to_string(), Value::map_of([
                    ("clearTimer".to_string(), Value::str("`$FUNCTION`")),
                    ("setTimer".to_string(), Value::str("`$FUNCTION`")),
                ])),
                ("strict".to_string(), Value::Bool(false)),
                ("transport".to_string(), Value::str("wrap")),
            ])),
        ])),
        ("options".to_string(), Value::map_of([
            ("base".to_string(), Value::str("https://test.tecs.at/tecsclientrest-auth")),
            ("auth".to_string(), Value::map_of([
                ("prefix".to_string(), Value::str("Bearer")),
            ])),
            ("headers".to_string(), Value::map_of([
                ("content-type".to_string(), Value::str("application/json")),
            ])),
            ("entity".to_string(), Value::map_of([
                ("ecr_api".to_string(), Value::empty_map()),
            ])),
        ])),
        ("entity".to_string(), Value::map_of([
            ("ecr_api".to_string(), Value::map_of([
                ("fields".to_string(), Value::list(vec![
                    Value::map_of([
                        ("name".to_string(), Value::str("amount")),
                        ("title".to_string(), Value::str("Amount")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Numeric Transaction Amount.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("authorization_number")),
                        ("title".to_string(), Value::str("Authorization Number")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("For Gratuity (msg type 0009): the authorization number of the original transaction.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("card_number")),
                        ("title".to_string(), Value::str("Card Number")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("currency")),
                        ("title".to_string(), Value::str("Currency")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\").")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("cvc2")),
                        ("title".to_string(), Value::str("Cvc2")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Card Verification Code.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("desired_currency")),
                        ("title".to_string(), Value::str("Desired Currency")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\").")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("ecr_data")),
                        ("title".to_string(), Value::str("Ecr Data")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("language")),
                        ("title".to_string(), Value::str("Language")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\").")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("message_type")),
                        ("title".to_string(), Value::str("Message Type")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Message type code.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("password")),
                        ("title".to_string(), Value::str("Password")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Password - currently not used (filled with spaces).")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("payment_reason")),
                        ("title".to_string(), Value::str("Payment Reason")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Payment reason (e.g., \"Taxi journey\").")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("payment_reasonAsByte")),
                        ("title".to_string(), Value::str("Payment Reason As Byte")),
                        ("type".to_string(), Value::str("`$ARRAY`")),
                        ("short".to_string(), Value::str("Payment reason represented as a byte array.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("personal_id")),
                        ("title".to_string(), Value::str("Personal Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Identification of the current user of the ECR or Terminal.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("receipt_layout")),
                        ("title".to_string(), Value::str("Receipt Layout")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Receipt layout identifier.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("receipt_number")),
                        ("title".to_string(), Value::str("Receipt Number")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Receipt number.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("terminal_number")),
                        ("title".to_string(), Value::str("Terminal Number")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Terminal number provided by TECS.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("transaction_date_time")),
                        ("title".to_string(), Value::str("Transaction Date Time")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Transaction date and time (format: yyyymmddhhmmss).")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("transaction_id")),
                        ("title".to_string(), Value::str("Transaction Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("req".to_string(), Value::Bool(true)),
                        ("short".to_string(), Value::str("Unique transaction identifier.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("transaction_origin_identifier")),
                        ("title".to_string(), Value::str("Transaction Origin Identifier")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("transaction_origin_indicator")),
                        ("title".to_string(), Value::str("Transaction Origin Indicator")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Transaction origin indicator: - 0 = Request for card data on PIN PAD.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("transaction_place")),
                        ("title".to_string(), Value::str("Transaction Place")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("The transaction place; the first 5 characters should contain a formatted zip code.")),
                    ]),
                    Value::map_of([
                        ("name".to_string(), Value::str("transaction_source_id")),
                        ("title".to_string(), Value::str("Transaction Source Id")),
                        ("type".to_string(), Value::str("`$STRING`")),
                        ("short".to_string(), Value::str("Identification number of the authorization source.")),
                    ]),
                ])),
                ("name".to_string(), Value::str("ecr_api")),
                ("op".to_string(), Value::map_of([
                    ("create".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("create")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("POST")),
                                ("orig".to_string(), Value::str("/makeTransaction")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("makeTransaction")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("makeTransaction"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                    ("load".to_string(), Value::map_of([
                        ("input".to_string(), Value::str("data")),
                        ("name".to_string(), Value::str("load")),
                        ("points".to_string(), Value::list(vec![
                            Value::map_of([
                                ("kind".to_string(), Value::str("http")),
                                ("method".to_string(), Value::str("GET")),
                                ("orig".to_string(), Value::str("/version")),
                                ("segments".to_string(), Value::list(vec![
                                    Value::map_of([
                                        ("lit".to_string(), Value::str("version")),
                                    ]),
                                ])),
                                ("parts".to_string(), Value::list(vec![
                                    Value::str("version"),
                                ])),
                                ("rename".to_string(), Value::empty_map()),
                                ("transform".to_string(), Value::map_of([
                                    ("req".to_string(), Value::str("`reqdata`")),
                                    ("res".to_string(), Value::str("`body`")),
                                ])),
                                ("args".to_string(), Value::empty_map()),
                                ("select".to_string(), Value::empty_map()),
                            ]),
                        ])),
                    ])),
                ])),
                ("relations".to_string(), Value::map_of([
                    ("ancestors".to_string(), Value::empty_list()),
                ])),
            ])),
        ])),
    ])
}

// SHARED CONFIG (sdkgen rung L2).
//
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client. Above the
// size threshold make_config re-parses the whole embedded JSON, so this is the
// difference between parsing the model once and once per client.
//
// THREAD-LOCAL, not a global: Value is Rc/RefCell-backed and so is neither
// Send nor Sync. One config per thread is the widest scope that is sound here,
// and the clone is an Rc bump, not a deep copy.
thread_local! {
    static SHARED_CONFIG: Value = make_config();
}

/// The per-thread config, built once on first use.
///
/// The returned Value SHARES its nodes: treat it as read-only. Callers that
/// need to mutate should use make_config, which always returns a fresh copy.
pub fn shared_config() -> Value {
    SHARED_CONFIG.with(|c| c.clone())
}

pub fn make_feature(name: &str) -> FeatureRef {
    match name {
        "audit" => Rc::new(RefCell::new(crate::feature::audit::AuditFeature::new())),
        "clienttrack" => Rc::new(RefCell::new(crate::feature::clienttrack::ClienttrackFeature::new())),
        "debug" => Rc::new(RefCell::new(crate::feature::debug::DebugFeature::new())),
        "idempotency" => Rc::new(RefCell::new(crate::feature::idempotency::IdempotencyFeature::new())),
        "log" => Rc::new(RefCell::new(crate::feature::log::LogFeature::new())),
        "metrics" => Rc::new(RefCell::new(crate::feature::metrics::MetricsFeature::new())),
        "paging" => Rc::new(RefCell::new(crate::feature::paging::PagingFeature::new())),
        "ratelimit" => Rc::new(RefCell::new(crate::feature::ratelimit::RatelimitFeature::new())),
        "retry" => Rc::new(RefCell::new(crate::feature::retry::RetryFeature::new())),
        "telemetry" => Rc::new(RefCell::new(crate::feature::telemetry::TelemetryFeature::new())),
        "test" => Rc::new(RefCell::new(crate::feature::test::TestFeature::new())),
        "timeout" => Rc::new(RefCell::new(crate::feature::timeout::TimeoutFeature::new())),
        _ => Rc::new(RefCell::new(crate::feature::base::BaseFeature::new())),
    }
}
