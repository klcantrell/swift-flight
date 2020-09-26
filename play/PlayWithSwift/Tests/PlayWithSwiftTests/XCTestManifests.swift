import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PlayWithSwiftTests.allTests),
    ]
}
#endif
