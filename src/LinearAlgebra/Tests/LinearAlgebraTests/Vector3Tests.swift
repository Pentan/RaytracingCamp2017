import XCTest
@testable import LinearAlgebra

class Vector3Tests: XCTestCase {
    
    //private let kTestEPS = 1e-10
    
    func testInitNoArg() {
        let v0 = Vector3()
        XCTAssertEqualWithAccuracy(v0.x, 0.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v0.y, 0.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v0.z, 0.0, accuracy: kTestEPS)
    }
    
    func testInit3Num() {
        let v1 = Vector3(1.0, -1.0, 100.0)
        XCTAssertEqualWithAccuracy(v1.x, 1.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v1.y, -1.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v1.z, 100.0, accuracy: kTestEPS)
    }
    
    func testCopy() {
        let v1 = Vector3(1.0, -1.0, 100.0)
        let v2 = v1.copy()
        XCTAssertEqualWithAccuracy(v2.x, v1.x, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v2.y, v1.y, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v2.z, v1.z, accuracy: kTestEPS)
    }
    
    func testSet() {
        var v0 = Vector3()
        v0.set(3.0, 4.0, 5.0)
        XCTAssertEqualWithAccuracy(v0.x, 3.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v0.y, 4.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v0.z, 5.0, accuracy: kTestEPS)
    }
    
    func testNegate() {
        var v0 = Vector3(1.0, 2.0, 3.0)
        v0.negate()
        XCTAssertEqualWithAccuracy(v0.x, -1.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v0.y, -2.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v0.z, -3.0, accuracy: kTestEPS)
    }
    
    func testLength() {
        let x = 1.0
        let y = 2.0
        let z = 3.0
        let v0 = Vector3(x, y, z)
        XCTAssertEqualWithAccuracy(v0.length(), (x * x + y * y + z * z).squareRoot(), accuracy: kTestEPS)
    }
    
    func testNormalize() {
        var v0 = Vector3(3.0, 4.0, 5.0)
        XCTAssertTrue(v0.normalize())
        XCTAssertEqualWithAccuracy(v0.length(), 1.0, accuracy: kTestEPS)
    }
    
    func testDistance() {
        let v0 = Vector3.normalized(Vector3(1.0, 2.0, 3.0))
        let v1 = Vector3(-v0.x, -v0.y, -v0.z)
        XCTAssertEqualWithAccuracy(v0.distance(v1), 2.0, accuracy: kTestEPS)
    }
    
    func testIsZero() {
        XCTAssertTrue(Vector3(0.0, 0.0, 0.0).isZero())
        XCTAssertFalse(Vector3(1.0, 1.0, 1.0).isZero())
        XCTAssertTrue(Vector3(0.1, 0.1, 0.1).isZero(1.0))
    }
    
    func testMaxMagnitude() {
        let v1 = Vector3(10.0, 5.0, 3.0)
        XCTAssertEqual(v1.maxMagnitude(), 10.0)
        
        let valind1 = v1.maxMagnitudeAndIndex()
        XCTAssertEqual(valind1.value, 10.0)
        XCTAssertEqual(valind1.index, 0)
        
        let v2 = Vector3(10.0, 5.0, -30.0)
        XCTAssertEqual(v2.maxMagnitude(), -30.0)
        
        let valind2 = v2.maxMagnitudeAndIndex()
        XCTAssertEqual(valind2.value, -30.0)
        XCTAssertEqual(valind2.index, 2)
    }

    // 2 vector operations utilities
    func testVector3Normalized() {
        let v0 = Vector3(1.0, 1.0, 1.0)
        
        let nv = Vector3.normalized(v0)
        let kInvSqrt3 = 1.0 / 3.0.squareRoot()
        XCTAssertEqualWithAccuracy(nv.length(), 1.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(nv.x, kInvSqrt3, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(nv.y, kInvSqrt3, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(nv.z, kInvSqrt3, accuracy: kTestEPS)
        
        XCTAssertEqualWithAccuracy(v0.x, 1.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v0.y, 1.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(v0.z, 1.0, accuracy: kTestEPS)
    }
    
    func testVector3Negated() {
        let v1 = Vector3(-1.0, -3.0, -5.0)
        let negv = Vector3.negated(v1)
        XCTAssertEqualWithAccuracy(negv.x, -v1.x, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(negv.y, -v1.y, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(negv.z, -v1.z, accuracy: kTestEPS)
    }
    
    func testVector3Mul() {
        let v1 = Vector3(-1.0, -3.0, -5.0)
        let v2 = Vector3(2.0, 4.0, 8.0)
        
        let mulv = Vector3.mul(v1, v2)
        XCTAssertEqualWithAccuracy(mulv.x, v1.x * v2.x, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(mulv.y, v1.y * v2.y, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(mulv.z, v1.z * v2.z, accuracy: kTestEPS)
    }
    
    func testVector3Div() {
        let v1 = Vector3(-1.0, -3.0, -5.0)
        let v2 = Vector3(2.0, 4.0, 8.0)
        let divv = Vector3.div(v1, v2)
        XCTAssertEqualWithAccuracy(divv.x, v1.x / v2.x, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(divv.y, v1.y / v2.y, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(divv.z, v1.z / v2.z, accuracy: kTestEPS)
    }
    
    func testVector3Dot() {
        let v1 = Vector3(-1.0, -3.0, -5.0)
        let v2 = Vector3(2.0, 4.0, 8.0)
        let dot = Vector3.dot(v1, v2)
        XCTAssertEqualWithAccuracy(dot, (v1.x * v2.x + v1.y * v2.y + v1.z * v2.z), accuracy: kTestEPS)
    }
    
    func testVector3Cross() {
        let crossv = Vector3.cross(Vector3(1.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0))
        XCTAssertEqualWithAccuracy(crossv.x, 0.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(crossv.y, 0.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(crossv.z, 1.0, accuracy: kTestEPS)
    }
    
    func testVector3Lerp() {
        let lerpv = Vector3.lerp(Vector3(1.0, 2.0, 3.0), Vector3(3.0, 4.0, 5.0), 0.5)
        XCTAssertEqualWithAccuracy(lerpv.x, 2.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(lerpv.y, 3.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(lerpv.z, 4.0, accuracy: kTestEPS)
    }
    
    func testVector3Project() {
        let projv = Vector3.projected(Vector3(1.0, 1.0, 1.0), Vector3(0.0, 1.0, 0.0))
        XCTAssertEqualWithAccuracy(projv.x, 0.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(projv.y, 1.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(projv.z, 0.0, accuracy: kTestEPS)
    }
    
    func testOperatorAdd() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let v1 = Vector3(4.0, 5.0, 6.0)
        let tmpv = v0 + v1
        XCTAssertEqualWithAccuracy(tmpv.x, v0.x + v1.x, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.y, v0.y + v1.y, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.z, v0.z + v1.z, accuracy: kTestEPS)
    }
    
    func testOperatorSub() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let v1 = Vector3(4.0, 5.0, 6.0)
        let tmpv = v0 - v1
        XCTAssertEqualWithAccuracy(tmpv.x, v0.x - v1.x, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.y, v0.y - v1.y, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.z, v0.z - v1.z, accuracy: kTestEPS)
    }
    
    func testOperatorMulScalarBack() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let tmpv = v0 * 2.0
        XCTAssertEqualWithAccuracy(tmpv.x, v0.x * 2.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.y, v0.y * 2.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.z, v0.z * 2.0, accuracy: kTestEPS)
    }
    
    func testOperatorMulScalarFront() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let tmpv = 2.0 * v0
        XCTAssertEqualWithAccuracy(tmpv.x, v0.x * 2.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.y, v0.y * 2.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.z, v0.z * 2.0, accuracy: kTestEPS)
    }
    
    func testOperatorDivBack() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let tmpv = v0 / 2.0
        XCTAssertEqualWithAccuracy(tmpv.x, v0.x / 2.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.y, v0.y / 2.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.z, v0.z / 2.0, accuracy: kTestEPS)
    }
    /*
    func testOperatorDivFront() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let v1 = Vector3(4.0, 5.0, 6.0)
        let tmpv = 2.0 / v0
        XCTAssertEqualWithAccuracy(tmpv.x, v0.x / 2.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.y, v0.y / 2.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.z, v0.z / 2.0, accuracy: kTestEPS)
    }
    */
    func testOperatorAddIn() {
        var tmpv = Vector3(10.0, 20.0, 30.0)
        tmpv += Vector3(1.0, 2.0, 3.0)
        XCTAssertEqualWithAccuracy(tmpv.x, 11.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.y, 22.0, accuracy: kTestEPS)
        XCTAssertEqualWithAccuracy(tmpv.z, 33.0, accuracy: kTestEPS)
    }
    
    static var allTests = [
        ("testInitNoArg", testInitNoArg),
        ("testInit3Num", testInit3Num),
        ("testCopy", testCopy),
        ("testMaxMagnitude", testMaxMagnitude),
        ("testVector3Normalized", testVector3Normalized),
        ("testVector3Negated", testVector3Negated),
        ("testVector3Mul", testVector3Mul),
        ("testVector3Div", testVector3Div),
        ("testVector3Dot", testVector3Dot),
        ("testVector3Cross", testVector3Cross),
        ("testVector3Lerp", testVector3Lerp),
        ("testVector3Project", testVector3Project),
        ("testOperatorAdd", testOperatorAdd),
        ("testOperatorSub", testOperatorSub),
        ("testOperatorMulScalarBack", testOperatorMulScalarBack),
        ("testOperatorMulScalarFront", testOperatorMulScalarFront),
        ("testOperatorDivBack", testOperatorDivBack),
        ("testOperatorAddIn", testOperatorAddIn)
    ]
}
