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
    "feature", cmap(1,
      "test", cmap(1,
        "options", cmap(1,
          "active", v_bool(false)))),
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

Feature* feature_test_new(void);

Feature* make_feature(const char* name) {
  if (strcmp(name, "test") == 0) return feature_test_new();
  return feature_base_new();
}
