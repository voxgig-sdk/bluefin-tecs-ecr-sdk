// Generated API configuration (mirrors Config_java / core/config.go).

#ifndef SDK_CORE_CONFIG_HPP
#define SDK_CORE_CONFIG_HPP

#include <memory>
#include <string>

#include "../core/struct.hpp"
#include "../core/types.hpp"
#include "../feature/base.hpp"
#include "../feature/test.hpp"

namespace sdk {

inline const char* config_json() {
  return
    "{\"main\":{\"name\":\"BluefinTecsEcr\"},\"feature\":{\"test\":{\"options\":{\"active\":false}}},\"options\":{\"base\":\"https://test.tecs.at/tecsclientrest-auth\",\"auth\":{\"prefix\":\"Bearer\"},\"headers\":{\"content-type\":\"application/json\"},\"entity\":{\"ecr_api\":{}}},\"entity\":{\"ecr_api\":{\"fields\":[{\"name\":\"amount\",\"req\":true,\"type\":\"`$STRING`\"},{\"name\":\"authorization_number\",\"type\":\"`$STRING`\"},{\"name\":\"card_number\",\"req\":true,\"type\":\"`$STRING`\"},{\"name\":\"currency\",\"req\":true,\"type\":\"`$STRING`\"},{\"name\":\"cvc2\",\"type\":\"`$STRING`\"},{\"name\":\"desired_currency\",\"type\":\"`$STRING`\"},{\"name\":\"ecr_data\",\"type\":\"`$STRING`\"},{\"name\":\"language\",\"type\":\"`$STRING`\"},{\"name\":\"message_type\",\"type\":\"`$STRING`\"},{\"name\":\"password\",\"type\":\"`$STRING`\"},{\"name\":\"payment_reason\",\"type\":\"`$STRING`\"},{\"name\":\"payment_reasonAsByte\",\"type\":\"`$ARRAY`\"},{\"name\":\"personal_id\",\"type\":\"`$STRING`\"},{\"name\":\"receipt_layout\",\"type\":\"`$STRING`\"},{\"name\":\"receipt_number\",\"type\":\"`$STRING`\"},{\"name\":\"terminal_number\",\"req\":true,\"type\":\"`$STRING`\"},{\"name\":\"transaction_date_time\",\"req\":true,\"type\":\"`$STRING`\"},{\"name\":\"transaction_id\",\"req\":true,\"type\":\"`$STRING`\"},{\"name\":\"transaction_origin_identifier\",\"type\":\"`$STRING`\"},{\"name\":\"transaction_origin_indicator\",\"type\":\"`$STRING`\"},{\"name\":\"transaction_place\",\"type\":\"`$STRING`\"},{\"name\":\"transaction_source_id\",\"type\":\"`$STRING`\"}],\"name\":\"ecr_api\",\"op\":{\"create\":{\"input\":\"data\",\"name\":\"create\",\"points\":[{\"args\":{},\"kind\":\"http\",\"method\":\"POST\",\"orig\":\"/makeTransaction\",\"parts\":[\"makeTransaction\"],\"select\":{},\"transform\":{\"req\":\"`reqdata`\",\"res\":\"`body`\"}}]},\"load\":{\"input\":\"data\",\"name\":\"load\",\"points\":[{\"args\":{},\"kind\":\"http\",\"method\":\"GET\",\"orig\":\"/version\",\"parts\":[\"version"
    "\"],\"select\":{},\"transform\":{\"req\":\"`reqdata`\",\"res\":\"`body`\"}}]}},\"relations\":{\"ancestors\":[]}}}}";
}

inline Value makeConfig() { return vs::parse_json(config_json()); }

inline FeaturePtr makeFeature(const std::string& name) {
  if (name == "test") return std::make_shared<TestFeature>();
  return std::make_shared<BaseFeature>();
}

} // namespace sdk

#endif // SDK_CORE_CONFIG_HPP
