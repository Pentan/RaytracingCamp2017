import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SweetAppleCoreTests.allTests),
        testCase(RandomTests.allTests),
        testCase(AABBTests.allTests),
    ]
}
#endif
