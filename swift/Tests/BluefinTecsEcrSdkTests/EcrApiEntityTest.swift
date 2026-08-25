// ecr_api entity test (generated from the API model).

import XCTest

@testable import BluefinTecsEcrSdk

final class EcrApiEntityTest: XCTestCase {
  func testInstance() {
    let sdk = BluefinTecsEcrSDK.testSDK(nil, nil)
    let ent = sdk.EcrApi()
    XCTAssertEqual(ent.getName(), "ecr_api")
  }
}
