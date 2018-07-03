import XCTest

import LinearAlgebraTests
import SweetAppleTests

var tests = [XCTestCaseEntry]()

tests += LinearAlgebraTests.allTests()
tests += SweetAppleCoreTests.allTests()

XCTMain(tests)
