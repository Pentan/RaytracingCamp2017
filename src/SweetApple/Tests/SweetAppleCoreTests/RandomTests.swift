//
//  RandomTests.swift
//  SweetAppleCore
//
//  Created by SatoruNAKAJIMA on 2017/09/04.
//
//

import XCTest
@testable import SweetAppleCore

class RandomTests: XCTestCase {

    func testValue() {
        let LOOP = 5000
        var min = 1.0
        var max = 0.0
        var total = 0.0
        
        let rng = Random(12345678)
        for _ in 0..<LOOP {
            let r = rng.nextDouble()
            if min > r { min = r }
            if max < r { max = r }
            total += r
        }
        let average = total / Double(LOOP)
        
        XCTAssertGreaterThanOrEqual(min, 0.0)
        XCTAssertLessThan(max, 1.0)
        XCTAssertEqualWithAccuracy(average, 0.5, accuracy: 0.1)
    }

    func testCount() {
        let PERBIN = 100
        var bin = Array<UInt64>(repeating: 0, count: 64)
        
        let rng = Random(12345678)
        for _ in 0..<(PERBIN * 2) {
            let r = rng.next()
            for i in 0..<64 {
                if (r >> UInt64(i)) & 0x1 != 0 {
                    bin[i] += 1
                }
            }
        }
        
        var min:UInt64 = UInt64.max
        var max:UInt64 = 0
        var diff:Double = 0.0
        for c in bin {
            if min > c { min = c }
            if max < c { max = c }
            let d = Double(Int64(c) - Int64(PERBIN)) / Double(PERBIN)
            diff += d * d
        }
        diff /= 64.0
        //print("bin min:\(min),max\(max),diff:\(diff)")
        XCTAssertEqualWithAccuracy(Double(max - min) / Double(PERBIN), 0.0, accuracy: 0.5)
        XCTAssertEqualWithAccuracy(diff, 0.0, accuracy: 0.01)
    }
    
    func testValue11() {
        let LOOP = 5000
        var min = 1.0
        var max = -1.0
        var total = 0.0
        
        let rng = Random(12345678)
        for _ in 0..<LOOP {
            let r = rng.nextDouble11()
            if min > r { min = r }
            if max < r { max = r }
            total += r
        }
        let average = total / Double(LOOP)
        
        XCTAssertGreaterThan(min, -1.0)
        XCTAssertLessThan(max, 1.0)
        XCTAssertEqualWithAccuracy(average, 0.0, accuracy: 0.01)
    }
    
    static var allTests = [
        ("testValue", testValue),
        ("testCount", testCount)
    ]
}
