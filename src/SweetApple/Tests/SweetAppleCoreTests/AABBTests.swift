//
//  AABBTests.swift
//  SweetAppleCore
//
//  Created by SatoruNAKAJIMA on 2017/09/04.
//
//

import XCTest
@testable import SweetAppleCore
import LinearAlgebra

class AABBTests: XCTestCase {
    
    func testExpand() {
        let aabb = AABB()
        aabb.expand(Vector3(1.0, 1.0, 1.0))
        aabb.expand(Vector3(-1.0, -1.0, -1.0))
        aabb.expand(Vector3(0.0, 2.0, -3.0))
        aabb.expand(Vector3(0.0, -2.0, 3.0))
        
        XCTAssertEqualWithAccuracy(aabb.min.x, -1.0, accuracy: kTestEPS, "min.x")
        XCTAssertEqualWithAccuracy(aabb.min.y, -2.0, accuracy: kTestEPS, "min.y")
        XCTAssertEqualWithAccuracy(aabb.min.z, -3.0, accuracy: kTestEPS, "min.z")
        XCTAssertEqualWithAccuracy(aabb.max.x, 1.0, accuracy: kTestEPS, "max.x")
        XCTAssertEqualWithAccuracy(aabb.max.y, 2.0, accuracy: kTestEPS, "max.y")
        XCTAssertEqualWithAccuracy(aabb.max.z, 3.0, accuracy: kTestEPS, "max.z")
        XCTAssertEqualWithAccuracy(aabb.centroid.x, 0.0, accuracy: kTestEPS, "centroid.x")
        XCTAssertEqualWithAccuracy(aabb.centroid.y, 0.0, accuracy: kTestEPS, "centroid.y")
        XCTAssertEqualWithAccuracy(aabb.centroid.z, 0.0, accuracy: kTestEPS, "centroid.z")
    }
    
    static var allTests = [
        ("testExpand", testExpand)
    ]
}
