// BluefinTecsEcr SDK exists test.

import XCTest

@testable import BluefinTecsEcrSdk

final class ExistsTest: XCTestCase {
  func testMode() {
    let testsdk = BluefinTecsEcrSDK.testSDK(nil, nil)
    XCTAssertEqual(testsdk.mode, "test")
  }
}
