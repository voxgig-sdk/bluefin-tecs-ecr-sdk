// Generated API configuration (mirrors Config_java / core/config.go).

#ifndef SDK_CORE_CONFIG_HPP
#define SDK_CORE_CONFIG_HPP

#include <memory>
#include <string>

#include "../core/struct.hpp"
#include "../core/types.hpp"
#include "../feature/base.hpp"
#include "../feature/audit.hpp"
#include "../feature/clienttrack.hpp"
#include "../feature/idempotency.hpp"
#include "../feature/log.hpp"
#include "../feature/metrics.hpp"
#include "../feature/paging.hpp"
#include "../feature/ratelimit.hpp"
#include "../feature/retry.hpp"
#include "../feature/telemetry.hpp"
#include "../feature/test.hpp"
#include "../feature/timeout.hpp"

namespace sdk {

inline const char* config_json() {
  return
    "{\"main\":{\"name\":\"BluefinTecsEcr\",\"slug\":\"bluefin-tecs-ecr\",\"version\":\"0.1.1\",\"target\":\"cpp\"},\"feature\":{\"audit\":{\"options\":{\"active\":false,\"actor\":\"anonymous\",\"max\":1000},\"transport\":\"none\"},\"clienttrack\":{\"options\":{\"active\":false,\"clientVersion\":\"0.0.1\"},\"transport\":\"none\"},\"idempotency\":{\"options\":{\"active\":false,\"header\":\"Idempotency-Key\",\"methods\":[\"POST\",\"PUT\",\"PATCH\",\"DELETE\"],\"ops\":[\"create\",\"update\",\"remove\"]},\"transport\":\"none\"},\"log\":{\"options\":{\"active\":true},\"transport\":\"none\"},\"metrics\":{\"options\":{\"active\":false},\"transport\":\"none\"},\"paging\":{\"options\":{\"active\":false,\"afterVar\":\"after\",\"cursorParam\":\"cursor\",\"firstVar\":\"first\",\"limitParam\":\"limit\",\"pageParam\":\"page\",\"startPage\":1},\"transport\":\"none\"},\"ratelimit\":{\"options\":{\"active\":false,\"burst\":5,\"rate\":5},\"transport\":\"wrap\"},\"retry\":{\"options\":{\"active\":false,\"factor\":2,\"maxDelay\":2000,\"minDelay\":50,\"retries\":2,\"statuses\":[408,425,429,500,502,503,504]},\"transport\":\"wrap\"},\"telemetry\":{\"options\":{\"active\":false},\"transport\":\"none\"},\"test\":{\"options\":{\"active\":false},\"transport\":\"base\"},\"timeout\":{\"options\":{\"active\":false,\"ms\":30000},\"transport\":\"wrap\"}},\"options\":{\"base\":\"https://test.tecs.at/tecsclientrest-auth\",\"auth\":{\"prefix\":\"Bearer\"},\"headers\":{\"content-type\":\"application/json\"},\"entity\":{\"ecr_api\":{}}},\"entity\":{\"ecr_api\":{\"fields\":[{\"name\":\"amount\",\"req\":true,\"short\":\"Numeric Transaction Amount.\",\"type\":\"`$STRING`\"},{\"name\":\"authorization_number\",\"short\":\"For Gratuity (msg type 0009): the authorization number of the original transaction.\",\"type\":\"`$STRING`\"},{\"name\":\"card_number\",\"req\":true,\"short\":\"Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty.\",\"type\":\"`$STRING`\"},{\"name\":\"currency\""
    ",\"req\":true,\"short\":\"ISO 4217 Alpha Currency Code (e.g., \\\"EUR\\\", \\\"USD\\\").\",\"type\":\"`$STRING`\"},{\"name\":\"cvc2\",\"short\":\"Card Verification Code.\",\"type\":\"`$STRING`\"},{\"name\":\"desired_currency\",\"short\":\"ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \\\"EUR\\\", \\\"USD\\\").\",\"type\":\"`$STRING`\"},{\"name\":\"ecr_data\",\"short\":\"ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).\",\"type\":\"`$STRING`\"},{\"name\":\"language\",\"short\":\"ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \\\"en\\\", \\\"de\\\", \\\"es\\\").\",\"type\":\"`$STRING`\"},{\"name\":\"message_type\",\"short\":\"Message type code.\",\"type\":\"`$STRING`\"},{\"name\":\"password\",\"short\":\"Password - currently not used (filled with spaces).\",\"type\":\"`$STRING`\"},{\"name\":\"payment_reason\",\"short\":\"Payment reason (e.g., \\\"Taxi journey\\\").\",\"type\":\"`$STRING`\"},{\"name\":\"payment_reasonAsByte\",\"short\":\"Payment reason represented as a byte array.\",\"type\":\"`$ARRAY`\"},{\"name\":\"personal_id\",\"short\":\"Identification of the current user of the ECR or Terminal.\",\"type\":\"`$STRING`\"},{\"name\":\"receipt_layout\",\"short\":\"Receipt layout identifier.\",\"type\":\"`$STRING`\"},{\"name\":\"receipt_number\",\"short\":\"Receipt number.\",\"type\":\"`$STRING`\"},{\"name\":\"terminal_number\",\"req\":true,\"short\":\"Terminal number provided by TECS.\",\"type\":\"`$STRING`\"},{\"name\":\"transaction_date_time\",\"req\":true,\"short\":\"Transaction date and time (format: yyyymmddhhmmss).\",\"type\":\"`$STRING`\"},{\"name\":\"transaction_id\",\"req\":true,\"short\":\"Unique transaction identifier.\",\"type\":\"`$STRING`\"},{\"name\":\"transaction_origin_identifier\",\"short\":\"Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capt"
    "ure/Completion - 5 = Pre Authorization - 7 = Balance\",\"type\":\"`$STRING`\"},{\"name\":\"transaction_origin_indicator\",\"short\":\"Transaction origin indicator: - 0 = Request for card data on PIN PAD.\",\"type\":\"`$STRING`\"},{\"name\":\"transaction_place\",\"short\":\"The transaction place; the first 5 characters should contain a formatted zip code.\",\"type\":\"`$STRING`\"},{\"name\":\"transaction_source_id\",\"short\":\"Identification number of the authorization source.\",\"type\":\"`$STRING`\"}],\"name\":\"ecr_api\",\"op\":{\"create\":{\"input\":\"data\",\"name\":\"create\",\"points\":[{\"args\":{},\"kind\":\"http\",\"method\":\"POST\",\"orig\":\"/makeTransaction\",\"parts\":[\"makeTransaction\"],\"select\":{},\"transform\":{\"req\":\"`reqdata`\",\"res\":\"`body`\"}}]},\"load\":{\"input\":\"data\",\"name\":\"load\",\"points\":[{\"args\":{},\"kind\":\"http\",\"method\":\"GET\",\"orig\":\"/version\",\"parts\":[\"version\"],\"select\":{},\"transform\":{\"req\":\"`reqdata`\",\"res\":\"`body`\"}}]}},\"relations\":{\"ancestors\":[]}}}}";
}

inline Value makeConfig() { return vs::parse_json(config_json()); }

// SHARED CONFIG (sdkgen rung L2).
//
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client - this is
// the difference between parsing the embedded JSON once and once per client.
//
// A function-local static in an inline function is one object across every
// translation unit, and its initialisation is thread-safe by the standard.
// Value holds shared_ptr nodes, so copying the returned Value shares the
// structure rather than duplicating it.
//
// The result is SHARED: treat it as read-only. Callers that need to mutate
// should use makeConfig, which always parses a fresh copy.
inline const Value& sharedConfig() {
  static const Value shared = makeConfig();
  return shared;
}

inline FeaturePtr makeFeature(const std::string& name) {
  if (name == "audit") return std::make_shared<AuditFeature>();
  if (name == "clienttrack") return std::make_shared<ClienttrackFeature>();
  if (name == "idempotency") return std::make_shared<IdempotencyFeature>();
  if (name == "log") return std::make_shared<LogFeature>();
  if (name == "metrics") return std::make_shared<MetricsFeature>();
  if (name == "paging") return std::make_shared<PagingFeature>();
  if (name == "ratelimit") return std::make_shared<RatelimitFeature>();
  if (name == "retry") return std::make_shared<RetryFeature>();
  if (name == "telemetry") return std::make_shared<TelemetryFeature>();
  if (name == "test") return std::make_shared<TestFeature>();
  if (name == "timeout") return std::make_shared<TimeoutFeature>();
  return std::make_shared<BaseFeature>();
}

} // namespace sdk

#endif // SDK_CORE_CONFIG_HPP
