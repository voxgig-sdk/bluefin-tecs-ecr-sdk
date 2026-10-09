// ecr_api entity test (generated from the API model).

import XCTest

@testable import BluefinTecsEcrSdk

final class EcrApiEntityTest: XCTestCase {
  func testInstance() {
    let sdk = BluefinTecsEcrSDK.testSDK(nil, nil)
    let ent = sdk.EcrApi()
    XCTAssertEqual(ent.getName(), "ecr_api")
  }

  // An invalid request fails with validate's own error, before it is sent.
  func testValidate() throws {
    try XCTSkipUnless(EcrApiEntityTest.hasFeature("validate"), "feature not present in this SDK: validate")
    let client = BluefinTecsEcrSDK.testSDK(nil, vm(("feature", .map(vm(("validate", .map(vm(("active", .bool(true))))))))))
    var err: Error? = nil
    do { _ = try client.EcrApi().load(vm(("amount", .int(1))), nil) } catch { err = error }
    XCTAssertEqual((err as? BluefinTecsEcrError)?.code, "validate_failed",
      "expected validate_failed, got \(String(describing: err))")
  }

  // True when this SDK was generated with the named feature.
  static func hasFeature(_ name: String) -> Bool {
    gp(SdkConfig.makeConfig(), "feature").asMap?.entries[name] != nil
  }
}
