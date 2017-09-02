import XCTest
@testable import LinearAlgebra

// extensions for test
let kTestEPS = 1e-14

extension Vector3 {
    public func isEqual(_ x:Double, _ y:Double, _ z:Double, _ accuracy:Double = kTestEPS) -> Bool {
        return (abs(self.x - x) < accuracy) && (abs(self.y - y) < accuracy) && (abs(self.z - z) < accuracy)
    }
    public func isEqual(_ v:Vector3, _ accuracy:Double = kTestEPS) -> Bool {
        return (abs(self.x - v.x) < accuracy) && (abs(self.y - v.y) < accuracy) && (abs(self.z - v.z) < accuracy)
    }
}

extension Vector4 {
    public func isEqual(_ x:Double, _ y:Double, _ z:Double, _ w:Double, _ accuracy:Double = kTestEPS) -> Bool {
        return (abs(self.x - x) < accuracy) && (abs(self.y - y) < accuracy) && (abs(self.z - z) < accuracy) && (abs(self.w - w) < accuracy)
    }
    public func isEqual(_ v:Vector4, _ accuracy:Double = kTestEPS) -> Bool {
        return (abs(self.x - v.x) < accuracy) && (abs(self.y - v.y) < accuracy) && (abs(self.z - v.z) < accuracy) && (abs(self.w - v.w) < accuracy)
    }
}

extension Matrix4 {
    public func maxDifference(_ m:[Double]) -> Double {
        var ret:Double = 0.0
        for i in 0..<16 {
            ret = Double.minimumMagnitude(ret, self.m[i] - m[i])
        }
        return ret
    }
    
    public func maxDifference(_ m:Matrix4) -> Double {
        return maxDifference(m.m)
    }
    
    public func isEqual(_ m:[Double], _ accuracy:Double = kTestEPS) -> Bool {
        return self.maxDifference(m) < accuracy
    }
    
    public func isEqual(_ m4:Matrix4, _ accuracy:Double = kTestEPS) -> Bool {
        return self.maxDifference(m4.m) < accuracy
    }
    
    public func isIdentity(_ accuracy:Double = kTestEPS) -> Bool {
        let im = [
            1.0, 0.0, 0.0, 0.0,
            0.0, 1.0, 0.0, 0.0,
            0.0, 0.0, 1.0, 0.0,
            0.0, 0.0, 0.0, 1.0
        ]
        return self.maxDifference(im) < accuracy
    }
}

class LinearAlgebraTests: XCTestCase {
    func testParameter() {
        XCTAssertGreaterThanOrEqual(kTestEPS, kLamEPS)
    }

    static var allTests = [
        ("testParameter", testParameter),
    ]
}
