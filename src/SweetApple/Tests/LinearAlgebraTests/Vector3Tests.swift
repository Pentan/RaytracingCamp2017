import XCTest
@testable import LinearAlgebra

class Vector3Tests: XCTestCase {
    
    //private let kTestEPS = 1e-10
    func testInitNoArg() {
        let v0 = Vector3()
        XCTAssertEqual(v0.x, 0.0, accuracy: kTestEPS)
        XCTAssertEqual(v0.y, 0.0, accuracy: kTestEPS)
        XCTAssertEqual(v0.z, 0.0, accuracy: kTestEPS)
    }
    
    func testInit3Num() {
        let v1 = Vector3(1.0, -1.0, 100.0)
        XCTAssertEqual(v1.x, 1.0, accuracy: kTestEPS)
        XCTAssertEqual(v1.y, -1.0, accuracy: kTestEPS)
        XCTAssertEqual(v1.z, 100.0, accuracy: kTestEPS)
    }
    
    func testCopy() {
        let v1 = Vector3(1.0, -1.0, 100.0)
        let v2 = v1.copy()
        XCTAssertEqual(v2.x, v1.x, accuracy: kTestEPS)
        XCTAssertEqual(v2.y, v1.y, accuracy: kTestEPS)
        XCTAssertEqual(v2.z, v1.z, accuracy: kTestEPS)
    }
    
    func testSet() {
        var v0 = Vector3()
        v0.set(3.0, 4.0, 5.0)
        XCTAssertEqual(v0.x, 3.0, accuracy: kTestEPS)
        XCTAssertEqual(v0.y, 4.0, accuracy: kTestEPS)
        XCTAssertEqual(v0.z, 5.0, accuracy: kTestEPS)
    }
    
    func testNegate() {
        var v0 = Vector3(1.0, 2.0, 3.0)
        v0.negate()
        XCTAssertEqual(v0.x, -1.0, accuracy: kTestEPS)
        XCTAssertEqual(v0.y, -2.0, accuracy: kTestEPS)
        XCTAssertEqual(v0.z, -3.0, accuracy: kTestEPS)
    }
    
    func testLength() {
        let x = 1.0
        let y = 2.0
        let z = 3.0
        let v0 = Vector3(x, y, z)
        XCTAssertEqual(v0.length(), (x * x + y * y + z * z).squareRoot(), accuracy: kTestEPS)
    }
    
    func testNormalize() {
        var v0 = Vector3(3.0, 4.0, 5.0)
        XCTAssertTrue(v0.normalize())
        XCTAssertEqual(v0.length(), 1.0, accuracy: kTestEPS)
    }
    
    func testDistance() {
        let v0 = Vector3.normalized(Vector3(1.0, 2.0, 3.0))
        let v1 = Vector3(-v0.x, -v0.y, -v0.z)
        XCTAssertEqual(v0.distance(v1), 2.0, accuracy: kTestEPS)
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
        XCTAssertEqual(nv.length(), 1.0, accuracy: kTestEPS)
        XCTAssertEqual(nv.x, kInvSqrt3, accuracy: kTestEPS)
        XCTAssertEqual(nv.y, kInvSqrt3, accuracy: kTestEPS)
        XCTAssertEqual(nv.z, kInvSqrt3, accuracy: kTestEPS)
        
        XCTAssertEqual(v0.x, 1.0, accuracy: kTestEPS)
        XCTAssertEqual(v0.y, 1.0, accuracy: kTestEPS)
        XCTAssertEqual(v0.z, 1.0, accuracy: kTestEPS)
    }
    
    func testVector3Negated() {
        let v1 = Vector3(-1.0, -3.0, -5.0)
        let negv = Vector3.negated(v1)
        XCTAssertEqual(negv.x, -v1.x, accuracy: kTestEPS)
        XCTAssertEqual(negv.y, -v1.y, accuracy: kTestEPS)
        XCTAssertEqual(negv.z, -v1.z, accuracy: kTestEPS)
    }
    
    func testVector3Mul() {
        let v1 = Vector3(-1.0, -3.0, -5.0)
        let v2 = Vector3(2.0, 4.0, 8.0)
        
        let mulv = Vector3.mul(v1, v2)
        XCTAssertEqual(mulv.x, v1.x * v2.x, accuracy: kTestEPS)
        XCTAssertEqual(mulv.y, v1.y * v2.y, accuracy: kTestEPS)
        XCTAssertEqual(mulv.z, v1.z * v2.z, accuracy: kTestEPS)
    }
    
    func testVector3Div() {
        let v1 = Vector3(-1.0, -3.0, -5.0)
        let v2 = Vector3(2.0, 4.0, 8.0)
        let divv = Vector3.div(v1, v2)
        XCTAssertEqual(divv.x, v1.x / v2.x, accuracy: kTestEPS)
        XCTAssertEqual(divv.y, v1.y / v2.y, accuracy: kTestEPS)
        XCTAssertEqual(divv.z, v1.z / v2.z, accuracy: kTestEPS)
    }
    
    func testVector3Dot() {
        let v1 = Vector3(-1.0, -3.0, -5.0)
        let v2 = Vector3(2.0, 4.0, 8.0)
        let dot = Vector3.dot(v1, v2)
        XCTAssertEqual(dot, (v1.x * v2.x + v1.y * v2.y + v1.z * v2.z), accuracy: kTestEPS)
    }
    
    func testVector3Cross() {
        let crossv = Vector3.cross(Vector3(1.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0))
        XCTAssertEqual(crossv.x, 0.0, accuracy: kTestEPS)
        XCTAssertEqual(crossv.y, 0.0, accuracy: kTestEPS)
        XCTAssertEqual(crossv.z, 1.0, accuracy: kTestEPS)
    }
    
    func testVector3Lerp() {
        let lerpv = Vector3.lerp(Vector3(1.0, 2.0, 3.0), Vector3(3.0, 4.0, 5.0), 0.5)
        XCTAssertEqual(lerpv.x, 2.0, accuracy: kTestEPS)
        XCTAssertEqual(lerpv.y, 3.0, accuracy: kTestEPS)
        XCTAssertEqual(lerpv.z, 4.0, accuracy: kTestEPS)
    }
    
    func testVector3Project() {
        let projv = Vector3.projected(Vector3(1.0, 1.0, 1.0), Vector3(0.0, 1.0, 0.0))
        XCTAssertEqual(projv.x, 0.0, accuracy: kTestEPS)
        XCTAssertEqual(projv.y, 1.0, accuracy: kTestEPS)
        XCTAssertEqual(projv.z, 0.0, accuracy: kTestEPS)
    }
    
    //
    func testGetSetComponent() {
        var v0 = Vector3(1.0, 2.0, 3.0)
        // get
        XCTAssertEqual(v0.componentValue(Vector3.Component.kX), 1.0)
        XCTAssertEqual(v0.componentValue(Vector3.Component.kY), 2.0)
        XCTAssertEqual(v0.componentValue(Vector3.Component.kZ), 3.0)
        
        // set
        v0.setComponentValue(Vector3.Component.kX, -1.0)
        v0.setComponentValue(Vector3.Component.kY, -2.0)
        v0.setComponentValue(Vector3.Component.kZ, -3.0)
        XCTAssertEqual(v0.x, -1.0)
        XCTAssertEqual(v0.y, -2.0)
        XCTAssertEqual(v0.z, -3.0)
    }
    
    //
    func testOperatorAdd() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let v1 = Vector3(4.0, 5.0, 6.0)
        let tmpv = v0 + v1
        XCTAssertEqual(tmpv.x, v0.x + v1.x, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.y, v0.y + v1.y, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.z, v0.z + v1.z, accuracy: kTestEPS)
    }
    
    func testOperatorSub() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let v1 = Vector3(4.0, 5.0, 6.0)
        let tmpv = v0 - v1
        XCTAssertEqual(tmpv.x, v0.x - v1.x, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.y, v0.y - v1.y, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.z, v0.z - v1.z, accuracy: kTestEPS)
    }
    
    func testOperatorMulScalarBack() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let tmpv = v0 * 2.0
        XCTAssertEqual(tmpv.x, v0.x * 2.0, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.y, v0.y * 2.0, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.z, v0.z * 2.0, accuracy: kTestEPS)
    }
    
    func testOperatorMulScalarFront() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let tmpv = 2.0 * v0
        XCTAssertEqual(tmpv.x, v0.x * 2.0, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.y, v0.y * 2.0, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.z, v0.z * 2.0, accuracy: kTestEPS)
    }
    
    func testOperatorDivBack() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let tmpv = v0 / 2.0
        XCTAssertEqual(tmpv.x, v0.x / 2.0, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.y, v0.y / 2.0, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.z, v0.z / 2.0, accuracy: kTestEPS)
    }
    /*
    func testOperatorDivFront() {
        let v0 = Vector3(1.0, 2.0, 3.0)
        let v1 = Vector3(4.0, 5.0, 6.0)
        let tmpv = 2.0 / v0
        XCTAssertEqual(tmpv.x, v0.x / 2.0, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.y, v0.y / 2.0, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.z, v0.z / 2.0, accuracy: kTestEPS)
    }
    */
    func testOperatorAddIn() {
        var tmpv = Vector3(10.0, 20.0, 30.0)
        tmpv += Vector3(1.0, 2.0, 3.0)
        XCTAssertEqual(tmpv.x, 11.0, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.y, 22.0, accuracy: kTestEPS)
        XCTAssertEqual(tmpv.z, 33.0, accuracy: kTestEPS)
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
        ("testGetSetComponent", testGetSetComponent),
        ("testOperatorAdd", testOperatorAdd),
        ("testOperatorSub", testOperatorSub),
        ("testOperatorMulScalarBack", testOperatorMulScalarBack),
        ("testOperatorMulScalarFront", testOperatorMulScalarFront),
        ("testOperatorDivBack", testOperatorDivBack),
        ("testOperatorAddIn", testOperatorAddIn)
    ]
}
