// Generated API configuration (mirrors core/config.go).

#include "api.h"

#include <string.h>

voxgig_value* make_config(void) {
  return cmap(4,
    "main", cmap(4,
      "name", v_str("BluefinTecsEcr"),
      "slug", v_str("bluefin-tecs-ecr"),
      "version", v_str("0.1.1"),
      "target", v_str("c")),
    "feature", cmap(11,
      "audit", cmap(2,
        "options", cmap(3,
          "active", v_bool(false),
          "actor", v_str("anonymous"),
          "max", v_num(1000)),
        "transport", v_str("none")),
      "clienttrack", cmap(2,
        "options", cmap(2,
          "active", v_bool(false),
          "clientVersion", v_str("0.0.1")),
        "transport", v_str("none")),
      "idempotency", cmap(2,
        "options", cmap(4,
          "active", v_bool(false),
          "header", v_str("Idempotency-Key"),
          "methods", clist(4,
            v_str("POST"),
            v_str("PUT"),
            v_str("PATCH"),
            v_str("DELETE")),
          "ops", clist(3,
            v_str("create"),
            v_str("update"),
            v_str("remove"))),
        "transport", v_str("none")),
      "log", cmap(2,
        "options", cmap(1,
          "active", v_bool(true)),
        "transport", v_str("none")),
      "metrics", cmap(2,
        "options", cmap(1,
          "active", v_bool(false)),
        "transport", v_str("none")),
      "paging", cmap(2,
        "options", cmap(7,
          "active", v_bool(false),
          "afterVar", v_str("after"),
          "cursorParam", v_str("cursor"),
          "firstVar", v_str("first"),
          "limitParam", v_str("limit"),
          "pageParam", v_str("page"),
          "startPage", v_num(1)),
        "transport", v_str("none")),
      "ratelimit", cmap(2,
        "options", cmap(3,
          "active", v_bool(false),
          "burst", v_num(5),
          "rate", v_num(5)),
        "transport", v_str("wrap")),
      "retry", cmap(2,
        "options", cmap(6,
          "active", v_bool(false),
          "factor", v_num(2),
          "maxDelay", v_num(2000),
          "minDelay", v_num(50),
          "retries", v_num(2),
          "statuses", clist(7,
            v_num(408),
            v_num(425),
            v_num(429),
            v_num(500),
            v_num(502),
            v_num(503),
            v_num(504))),
        "transport", v_str("wrap")),
      "telemetry", cmap(2,
        "options", cmap(1,
          "active", v_bool(false)),
        "transport", v_str("none")),
      "test", cmap(2,
        "options", cmap(1,
          "active", v_bool(false)),
        "transport", v_str("base")),
      "timeout", cmap(2,
        "options", cmap(2,
          "active", v_bool(false),
          "ms", v_num(30000)),
        "transport", v_str("wrap"))),
    "options", cmap(4,
      "base", v_str("https://test.tecs.at/tecsclientrest-auth"),
      "headers", cmap(1,
        "content-type", v_str("application/json")),
      "entity", cmap(1,
        "ecr_api", v_map()),
      "auth", cmap(1,
        "prefix", v_str("Bearer"))),
    "entity", cmap(1,
      "ecr_api", cmap(4,
        "fields", clist(22,
          cmap(4,
            "name", v_str("amount"),
            "req", v_bool(true),
            "short", v_str("Numeric Transaction Amount."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("authorization_number"),
            "short", v_str("For Gratuity (msg type 0009): the authorization number of the original transaction."),
            "type", v_str("`$STRING`")),
          cmap(4,
            "name", v_str("card_number"),
            "req", v_bool(true),
            "short", v_str("Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty."),
            "type", v_str("`$STRING`")),
          cmap(4,
            "name", v_str("currency"),
            "req", v_bool(true),
            "short", v_str("ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\")."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("cvc2"),
            "short", v_str("Card Verification Code."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("desired_currency"),
            "short", v_str("ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\")."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("ecr_data"),
            "short", v_str("ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex)."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("language"),
            "short", v_str("ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\")."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("message_type"),
            "short", v_str("Message type code."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("password"),
            "short", v_str("Password - currently not used (filled with spaces)."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("payment_reason"),
            "short", v_str("Payment reason (e.g., \"Taxi journey\")."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("payment_reasonAsByte"),
            "short", v_str("Payment reason represented as a byte array."),
            "type", v_str("`$ARRAY`")),
          cmap(3,
            "name", v_str("personal_id"),
            "short", v_str("Identification of the current user of the ECR or Terminal."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("receipt_layout"),
            "short", v_str("Receipt layout identifier."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("receipt_number"),
            "short", v_str("Receipt number."),
            "type", v_str("`$STRING`")),
          cmap(4,
            "name", v_str("terminal_number"),
            "req", v_bool(true),
            "short", v_str("Terminal number provided by TECS."),
            "type", v_str("`$STRING`")),
          cmap(4,
            "name", v_str("transaction_date_time"),
            "req", v_bool(true),
            "short", v_str("Transaction date and time (format: yyyymmddhhmmss)."),
            "type", v_str("`$STRING`")),
          cmap(4,
            "name", v_str("transaction_id"),
            "req", v_bool(true),
            "short", v_str("Unique transaction identifier."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("transaction_origin_identifier"),
            "short", v_str("Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance"),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("transaction_origin_indicator"),
            "short", v_str("Transaction origin indicator: - 0 = Request for card data on PIN PAD."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("transaction_place"),
            "short", v_str("The transaction place; the first 5 characters should contain a formatted zip code."),
            "type", v_str("`$STRING`")),
          cmap(3,
            "name", v_str("transaction_source_id"),
            "short", v_str("Identification number of the authorization source."),
            "type", v_str("`$STRING`"))),
        "name", v_str("ecr_api"),
        "op", cmap(2,
          "create", cmap(3,
            "input", v_str("data"),
            "name", v_str("create"),
            "points", clist(1,
              cmap(7,
                "args", v_map(),
                "kind", v_str("http"),
                "method", v_str("POST"),
                "orig", v_str("/makeTransaction"),
                "parts", clist(1,
                  v_str("makeTransaction")),
                "select", v_map(),
                "transform", cmap(2,
                  "req", v_str("`reqdata`"),
                  "res", v_str("`body`"))))),
          "load", cmap(3,
            "input", v_str("data"),
            "name", v_str("load"),
            "points", clist(1,
              cmap(7,
                "args", v_map(),
                "kind", v_str("http"),
                "method", v_str("GET"),
                "orig", v_str("/version"),
                "parts", clist(1,
                  v_str("version")),
                "select", v_map(),
                "transform", cmap(2,
                  "req", v_str("`reqdata`"),
                  "res", v_str("`body`")))))),
        "relations", cmap(1,
          "ancestors", v_list()))));
}

// SHARED CONFIG (sdkgen rung L2).
//
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client. Above the
// size threshold make_config re-parses the whole embedded JSON, so this is the
// difference between parsing the model once and once per client.
//
// Deliberately never freed: it lives for the life of the process, like any
// other program-lifetime singleton.
static voxgig_value* shared_config_val = NULL;

// The process-wide config, built once on first use.
//
// The returned value is SHARED: treat it as read-only. Callers that need to
// mutate should use make_config, which always returns a fresh copy.
voxgig_value* shared_config(void) {
  if (NULL == shared_config_val) {
    shared_config_val = make_config();
  }
  return shared_config_val;
}

Feature* feature_audit_new(void);
Feature* feature_clienttrack_new(void);
Feature* feature_idempotency_new(void);
Feature* feature_log_new(void);
Feature* feature_metrics_new(void);
Feature* feature_paging_new(void);
Feature* feature_ratelimit_new(void);
Feature* feature_retry_new(void);
Feature* feature_telemetry_new(void);
Feature* feature_test_new(void);
Feature* feature_timeout_new(void);

Feature* make_feature(const char* name) {
  if (strcmp(name, "audit") == 0) return feature_audit_new();
  if (strcmp(name, "clienttrack") == 0) return feature_clienttrack_new();
  if (strcmp(name, "idempotency") == 0) return feature_idempotency_new();
  if (strcmp(name, "log") == 0) return feature_log_new();
  if (strcmp(name, "metrics") == 0) return feature_metrics_new();
  if (strcmp(name, "paging") == 0) return feature_paging_new();
  if (strcmp(name, "ratelimit") == 0) return feature_ratelimit_new();
  if (strcmp(name, "retry") == 0) return feature_retry_new();
  if (strcmp(name, "telemetry") == 0) return feature_telemetry_new();
  if (strcmp(name, "test") == 0) return feature_test_new();
  if (strcmp(name, "timeout") == 0) return feature_timeout_new();
  return feature_base_new();
}
