import XCTest
@testable import FormValidation

final class FormValidationTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FormValidation().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
