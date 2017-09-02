import XCTest
@testable import LinearAlgebraTests

XCTMain([
    testCase(LinearAlgebraTests.allTests),
    testCase(Vector3Tests.allTests),
    testCase(Vector4Tests.allTests),
    testCase(Matrix4Tests.allTests),
])
