import XCTest
@testable import LinearAlgebra

class Vector4Tests: XCTestCase {
    
    // initialize
    func testInitNoArg() {
        let v0 = Vector4()
        XCTAssertTrue(v0.isEqual(0.0, 0.0, 0.0, 0.0))
    }
    
    func testInit4Args() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        XCTAssertTrue(v0.isEqual(1.0, 2.0, 3.0, 4.0))
    }
    
    func testInitCopy() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        let v1 = v0.copy()
        XCTAssertTrue(v1.isEqual(v0))
    }
    
    // self ops
    func testSet4Args() {
        var v0 = Vector4()
        v0.set(1.0, 2.0, 3.0, 4.0)
        XCTAssertTrue(v0.isEqual(1.0, 2.0, 3.0, 4.0))
    }
    
    func testSetV3Float() {
        var v0 = Vector4()
        v0.set(Vector3(1.0, 2.0, 3.0), 4.0)
        XCTAssertTrue(v0.isEqual(1.0, 2.0, 3.0, 4.0))
    }
    
    func testGetXYZ() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        let v3 = v0.getXYZ()
        XCTAssertTrue(v3.isEqual(1.0, 2.0, 3.0))
    }
    
    func testLength() {
        let v0 = Vector4(1.0, 1.0, 1.0, 1.0)
        XCTAssertEqualWithAccuracy(v0.length(), 2.0, accuracy:kTestEPS)
    }
    
    func testDistance() {
        let v0 = Vector4(1.0, 1.0, 1.0, 1.0)
        let v1 = Vector4(-1.0, -1.0, -1.0, -1.0)
        XCTAssertEqualWithAccuracy(v0.distance(v1), 4.0, accuracy:kTestEPS)
    }
    
    func testNormalize() {
        var v0 = Vector4(1.0, 1.0, 1.0, 1.0)
        XCTAssertTrue(v0.normalize())
        XCTAssertEqualWithAccuracy(v0.length(), 1.0, accuracy:kTestEPS)
    }
    
    func testNegate() {
        var v0 = Vector4(1.0, 1.0, 1.0, 1.0)
        v0.negate()
        XCTAssertTrue(v0.isEqual(-1.0, -1.0, -1.0, -1.0))
    }
    
    func testIsZero() {
        XCTAssertTrue(Vector4(0.0, 0.0, 0.0, 0.0).isZero())
        XCTAssertFalse(Vector4(1.0, 0.0, 0.0, 0.0).isZero())
        XCTAssertTrue(Vector4(0.1, 0.0, 0.0, 0.0).isZero(1.0))
    }
    
    func testMaxMagnitude() {
        XCTAssertEqualWithAccuracy(Vector4(1.0, 4.0, 0.0, 2.0).maxMagnitude(), 4.0, accuracy:kTestEPS)
        XCTAssertEqualWithAccuracy(Vector4(1.0, 4.0, -10.0, 2.0).maxMagnitude(), -10.0, accuracy:kTestEPS)
    }
    
    func testMaxMagnitudeAndIndex() {
        let v0 = Vector4(1.0, 4.0, 0.0, 2.0)
        let res0 = v0.maxMagnitudeAndIndex()
        XCTAssertEqual(res0.index, 1)
        XCTAssertEqualWithAccuracy(res0.value, 4.0, accuracy:kTestEPS)
        
        let v1 = Vector4(1.0, 4.0, 0.0, -12.0)
        let res1 = v1.maxMagnitudeAndIndex()
        XCTAssertEqual(res1.index, 3)
        XCTAssertEqualWithAccuracy(res1.value, -12.0, accuracy:kTestEPS)
    }
    
    // 2 vector op
    func testVector4Distance() {
        let v0 = Vector4(1.0, 1.0, 1.0, 1.0)
        let v1 = Vector4(-1.0, -1.0, -1.0, -1.0)
        XCTAssertEqualWithAccuracy(Vector4.distance(v0, v1), 4.0, accuracy:kTestEPS)
    }
    
    func testVector4Normalized() {
        let v0 = Vector4.normalized(Vector4(1.0, 1.0, 1.0, 1.0))
        XCTAssertEqualWithAccuracy(v0.length(), 1.0, accuracy:kTestEPS)
    }
    
    func testVector4Negated() {
        let v0 = Vector4.negated(Vector4(1.0, 1.0, 1.0, 1.0))
        XCTAssertTrue(v0.isEqual(-1.0, -1.0, -1.0, -1.0))
    }
    
    func testVector4Mul() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        let v1 = Vector4(5.0, 6.0, 7.0, 8.0)
        XCTAssertTrue(Vector4.mul(v0, v1).isEqual(5.0, 12.0, 21.0, 32.0))
    }
    
    func testVector4Div() {
        let v0 = Vector4(10.0, 18.0, 28.0, 40.0)
        let v1 = Vector4(5.0, 6.0, 7.0, 8.0)
        XCTAssertTrue(Vector4.div(v0, v1).isEqual(2.0, 3.0, 4.0, 5.0))
    }
    
    func testVector4Dot() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        let v1 = Vector4(5.0, 6.0, 7.0, 8.0)
        let d = v0.x * v1.x + v0.y * v1.y + v0.z * v1.z + v0.w * v1.w
        XCTAssertEqualWithAccuracy(Vector4.dot(v0, v1), d, accuracy:kTestEPS)
    }
    
    func testVector4Lerp() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        let v1 = Vector4(5.0, 6.0, 7.0, 8.0)
        XCTAssertTrue(Vector4.lerp(v0, v1, 0.5).isEqual(3.0, 4.0, 5.0, 6.0))
    }
    
    func testVector4Proj() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        let v1 = Vector4(5.0, 0.0, 0.0, 0.0)
        let pv = Vector4.projected(v0, v1)
        XCTAssertEqualWithAccuracy(pv.x, 1.0, accuracy:kTestEPS)
    }
    
    //
    func testGetSetComponent() {
        var v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        // get
        XCTAssertEqual(v0.componentValue(Vector4.Component.kX), 1.0)
        XCTAssertEqual(v0.componentValue(Vector4.Component.kY), 2.0)
        XCTAssertEqual(v0.componentValue(Vector4.Component.kZ), 3.0)
        XCTAssertEqual(v0.componentValue(Vector4.Component.kW), 4.0)
        
        // set
        v0.setComponentValue(Vector4.Component.kX, -1.0)
        v0.setComponentValue(Vector4.Component.kY, -2.0)
        v0.setComponentValue(Vector4.Component.kZ, -3.0)
        v0.setComponentValue(Vector4.Component.kW, -4.0)
        XCTAssertEqual(v0.x, -1.0)
        XCTAssertEqual(v0.y, -2.0)
        XCTAssertEqual(v0.z, -3.0)
        XCTAssertEqual(v0.w, -4.0)
    }

    
    // operator
    func testOperatorAdd() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        let v1 = Vector4(5.0, 6.0, 7.0, 8.0)
        XCTAssertTrue((v0 + v1).isEqual(6.0, 8.0, 10.0, 12.0))
    }
    
    func testOperatorSub() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        let v1 = Vector4(5.0, 6.0, 7.0, 8.0)
        XCTAssertTrue((v0 - v1).isEqual(-4.0, -4.0, -4.0, -4.0))
    }
    
    func testOperatorMulScalarBack() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        XCTAssertTrue((v0 * 2.0).isEqual(2.0, 4.0, 6.0, 8.0))
    }
    
    func testOperatorMulScalarFront() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        XCTAssertTrue((2.0 * v0).isEqual(2.0, 4.0, 6.0, 8.0))
    }
    
    func testOperatorDivScalarBack() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        XCTAssertTrue((v0 / 2.0).isEqual(0.5, 1.0, 1.5, 2.0))
    }
    
    func testOperatorAddIn() {
        var v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        v0 += Vector4(1.0, 2.0, 3.0, 4.0)
        XCTAssertTrue(v0.isEqual(2.0, 4.0, 6.0, 8.0))
    }
    
    static var allTests = [
        ("testInitNoArg", testInitNoArg),
        ("testInit4Args", testInit4Args),
        ("testInitCopy", testInitCopy),
        ("testSet4Args", testSet4Args),
        ("testSetV3Float", testSetV3Float),
        ("testGetXYZ", testGetXYZ),
        ("testLength", testLength),
        ("testDistance", testDistance),
        ("testNormalize", testNormalize),
        ("testNegate", testNegate),
        ("testMaxMagnitude", testMaxMagnitude),
        ("testMaxMagnitudeAndIndex", testMaxMagnitudeAndIndex),
        ("testVector4Distance", testVector4Distance),
        ("testVector4Normalized", testVector4Normalized),
        ("testVector4Negated", testVector4Negated),
        ("testVector4Mul", testVector4Mul),
        ("testVector4Div", testVector4Div),
        ("testVector4Dot", testVector4Dot),
        ("testVector4Lerp", testVector4Lerp),
        ("testVector4Proj", testVector4Proj),
        ("testGetSetComponent", testGetSetComponent),
        ("testOperatorAdd", testOperatorAdd),
        ("testOperatorSub", testOperatorSub),
        ("testOperatorMulScalarBack", testOperatorMulScalarBack),
        ("testOperatorMulScalarFront", testOperatorMulScalarFront),
        ("testOperatorDivScalarBack", testOperatorDivScalarBack),
        ("testOperatorAddIn", testOperatorAddIn),
    ]
}
