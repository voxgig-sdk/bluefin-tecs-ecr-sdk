// BluefinTecsEcr SDK client. All transport and pipeline behaviour lives in the
// SdkClient base (core/types.hpp); this class binds the API-specific entity
// accessors and the test-mode constructor.

#ifndef SDK_CORE_CLIENT_HPP
#define SDK_CORE_CLIENT_HPP

#include <memory>

#include "../core/types.hpp"
#include "../entity/entities.hpp"

namespace sdk {

class BluefinTecsEcrSDK : public SdkClient {
public:
  explicit BluefinTecsEcrSDK(Value options = Value::undef()) : SdkClient(options) {}


  // EcrApi entity bound to this client.
  std::shared_ptr<EcrApiEntity> ecr_api(Value entopts = Value::undef()) {
    return std::make_shared<EcrApiEntity>(this, entopts);
  }


  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  static std::shared_ptr<BluefinTecsEcrSDK> testSDK() {
    return testSDK(Value::undef(), Value::undef());
  }

  static std::shared_ptr<BluefinTecsEcrSDK> testSDK(Value testopts, Value sdkopts) {
    auto sdk = std::make_shared<BluefinTecsEcrSDK>(SdkClient::testOptions(testopts, sdkopts));
    sdk->mode = "test";
    return sdk;
  }

  // Convenience no-arg constructor.
  static std::shared_ptr<BluefinTecsEcrSDK> create() {
    return std::make_shared<BluefinTecsEcrSDK>(Value::undef());
  }
};

using BluefinTecsEcrSDKPtr = std::shared_ptr<BluefinTecsEcrSDK>;

} // namespace sdk

#endif // SDK_CORE_CLIENT_HPP
