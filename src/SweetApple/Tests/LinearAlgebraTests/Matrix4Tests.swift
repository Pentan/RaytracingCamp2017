//
//  Matrix4Tests.swift
//  LinearAlgebra
//
//  Created by SatoruNAKAJIMA on 2017/09/01.
//
//

import XCTest
@testable import LinearAlgebra

class Matrix4Tests: XCTestCase {
    
    func testInitNoArg() {
        let m0 = Matrix4()
        XCTAssertTrue(m0.isIdentity())
    }
    
    func testInit16Args() {
        let m0 = Matrix4(
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7
        )
        XCTAssertTrue(m0.isEqual([
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7]))
    }
    
    func testInitArrayArg() {
        let im = [
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7
        ]
        var m0 = Matrix4(im)
        XCTAssertTrue(m0.isEqual(im))
        
        m0.m[0] = 10.0
        XCTAssertNotEqual(m0.m[0], im[0])
    }
    
    func testCopy() {
        let im = [
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7
        ]
        var m0 = Matrix4(im)
        
        let m1 = m0.copy()
        XCTAssertTrue(m1.isEqual(im))
        
        m0.m[0] = 10.0
        XCTAssertNotEqual(m0.m[0], m1.m[0])
    }
    
    // self operation
    func testSet16Arg() {
        var m0 = Matrix4()
        m0.set(
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7)
        XCTAssertTrue(m0.isEqual([
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7]))
        
        m0.m[0] = 10.0
        XCTAssertNotEqual(m0.m[0], 1.0)
    }
    
    func testSetArrayArg() {
        let im = [
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7
        ]
        var m0 = Matrix4()
        m0.set(im)
        XCTAssertTrue(m0.isEqual(im))
        
        m0.m[0] = 10.0
        XCTAssertNotEqual(m0.m[0], im[0])
    }
    
    func testSetColumns() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        let v1 = Vector4(5.0, 6.0, 7.0, 8.0)
        let v2 = Vector4(9.0, 0.1, 0.2, 0.3)
        let v3 = Vector4(0.4, 0.5, 0.6, 0.7)
        
        var m0 = Matrix4()
        m0.setColumns(v0, v1, v2, v3)
        
        XCTAssertTrue(m0.isEqual([
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7]))
    }
    
    func testSetRows() {
        let v0 = Vector4(1.0, 2.0, 3.0, 4.0)
        let v1 = Vector4(5.0, 6.0, 7.0, 8.0)
        let v2 = Vector4(9.0, 0.1, 0.2, 0.3)
        let v3 = Vector4(0.4, 0.5, 0.6, 0.7)
        
        var m0 = Matrix4()
        m0.setRows(v0, v1, v2, v3)
        
        XCTAssertTrue(m0.isEqual([
            1.0, 5.0, 9.0, 0.4,
            2.0, 6.0, 0.1, 0.5,
            3.0, 7.0, 0.2, 0.6,
            4.0, 8.0, 0.3, 0.7]))
    }
    
    func testSetIdentity() {
        var m0 = Matrix4(
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7
            
        )
        m0.setIdentity()
        XCTAssertTrue(m0.isIdentity())
    }
    
    func testTranslation() {
        var m0 = Matrix4()
        m0.setTranslation(10.0, 20.0, 30.0)
        
        XCTAssertTrue(m0.isEqual([
            1.0, 0.0, 0.0, 0.0,
            0.0, 1.0, 0.0, 0.0,
            0.0, 0.0, 1.0, 0.0,
            10.0, 20.0, 30.0, 1.0]))
    }
    
    func testRotation() {
        let rot0 = Double.pi * 30.0 / 180.0
        var m0 = Matrix4()
        
        m0.setRotation(rot0, 1.0, 0.0, 0.0)
        XCTAssertTrue(m0.isEqual([
            1.0, 0.0, 0.0, 0.0,
            0.0, cos(rot0), -sin(rot0), 0.0,
            0.0, sin(rot0),  cos(rot0), 0.0,
            0.0, 0.0, 0.0, 1.0]))
        
        m0.setRotation(rot0, 0.0, 1.0, 0.0)
        XCTAssertTrue(m0.isEqual([
             cos(rot0), 0.0, sin(rot0), 0.0,
                   0.0, 1.0,       0.0, 0.0,
            -sin(rot0), 0.0, cos(rot0), 0.0,
            0.0, 0.0, 0.0, 1.0]))
        
        m0.setRotation(rot0, 0.0, 0.0, 1.0)
        XCTAssertTrue(m0.isEqual([
            cos(rot0), -sin(rot0), 0.0, 0.0,
            sin(rot0),  cos(rot0), 0.0, 0.0,
            0.0, 0.0, 1.0, 0.0,
            0.0, 0.0, 0.0, 1.0]))
    }
    
    func testScale() {
        var m0 = Matrix4()
        m0.setScale(10.0, 20.0, 30.0)
        
        XCTAssertTrue(m0.isEqual([
            10.0, 0.0, 0.0, 0.0,
            0.0, 20.0, 0.0, 0.0,
            0.0, 0.0, 30.0, 0.0,
            0.0, 0.0, 0.0, 1.0]))
    }
    
    func testSetBasis() {
        var m0 = Matrix4()
        
        let bvx = Vector3.normalized(Vector3(1.0, 1.0, 1.0))
        let bvy = Vector3.normalized(Vector3(0.0, 2.0, -1.0))
        let bvz = Vector3.normalized(Vector3(-1.0, 0.0, 3.0))
        
        m0.setBasis(bvx, bvy, bvz)
        XCTAssertTrue(m0.isEqual([
            bvx.x, bvy.x, bvz.x, 0.0,
            bvx.y, bvy.y, bvz.y, 0.0,
            bvx.z, bvy.z, bvz.z, 0.0,
            0.0, 0.0, 0.0, 1.0]))
    }
    
    func testGetColumn() {
        let m0 = Matrix4(
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7
        )
        let v = m0.getColumn(0)
        XCTAssertTrue(v.isEqual(1.0, 2.0, 3.0, 4.0))
    }
    
    func testSetColumn() {
        var m0 = Matrix4()
        
        m0.setColumn(1, Vector4(-1.0, -2.0, -3.0, -4.0))
        XCTAssertTrue(m0.isEqual([
            1.0, 0.0, 0.0, 0.0,
            -1.0, -2.0, -3.0, -4.0,
            0.0, 0.0, 1.0, 0.0,
            0.0, 0.0, 0.0, 1.0]))
        
        let v = m0.getColumn(1)
        XCTAssertTrue(v.isEqual(-1.0, -2.0, -3.0, -4.0))
    }
    
    func testGetRow() {
        let m0 = Matrix4(
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7
        )
        let v = m0.getRow(0)
        XCTAssertTrue(v.isEqual(1.0, 5.0, 9.0, 0.4))
    }
    
    func testSetRow() {
        var m0 = Matrix4()
        
        m0.setRow(2, Vector4(-1.0, -2.0, -3.0, -4.0))
        XCTAssertTrue(m0.isEqual([
            1.0, 0.0, -1.0, 0.0,
            0.0, 1.0, -2.0, 0.0,
            0.0, 0.0, -3.0, 0.0,
            0.0, 0.0, -4.0, 1.0]))
        
        let v = m0.getRow(2)
        XCTAssertTrue(v.isEqual(-1.0, -2.0, -3.0, -4.0))
    }
    
    func testInvert() {
        let m0 = Matrix4(
            1.34242, 1.64535, 1.85, 0.0,
            -1.13071, -1.01591, 2.35432, 0.0,
            0.958851, -3.50154, 0.186233, 0.0,
            0.759721, 7.04498, -11.8232, -11.8232)
        var m1 = m0.copy()
        XCTAssertTrue(m1.invert())
        XCTAssertTrue((m0 * m1).isIdentity())
    }
    
    func testTranspose() {
        var m0 = Matrix4(
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 0.1, 0.2, 0.3,
            0.4, 0.5, 0.6, 0.7
        )
        m0.transpose()
        XCTAssertTrue(m0.isEqual([
            1.0, 5.0, 9.0, 0.4,
            2.0, 6.0, 0.1, 0.5,
            3.0, 7.0, 0.2, 0.6,
            4.0, 8.0, 0.3, 0.7]))
    }
    
    /*
    func testInvTrans() {
        
    }
    */
    
    func testTransform() {
        var m0 = Matrix4.makeScale(2.0, 4.0, 3.0)
        m0.translate(2.0, 5.0, -3.0)
        m0.rotate(1.5, 1.0, 0.0, 0.0)
        m0.rotate(0.5, 0.0, 1.0, 0.0)
        m0.rotate(0.7, 0.0, 0.0, 1.0)
        m0.translate(-3.0, 1.0, 2.0)
        
        XCTAssertTrue(m0.isEqual([
            1.34242, 1.64535, 1.85, 0.0,
            -1.13071, -1.01591, 2.35432, 0.0,
            0.958851, -3.50154, 0.186233, 0.0,
            0.759721, 7.04498, -11.8232, -11.8232], 1e-5))
    }
    
    func testMakeOrtho() {
        // TODO
    }
    
    func testMakeFrustum() {
        // TODO
    }
    
    func testMakePerspective() {
        // TODO
    }
    
    func testMakeLookAt() {
        let eye = Vector3(1.0, 2.0, 3.0)
        let look = Vector3(2.0, 1.0, -1.0)
        let up = Vector3(0.0, 1.0, 0.0)
        let m0 = Matrix4.makeLookAt(eye, look, up)
        
        XCTAssertTrue(m0.isEqual([
            0.970142, 0.0571662, -0.235702, 0.0,
            -0.0, 0.971825, 0.235702, 0.0,
            0.242536, -0.228665, 0.942809, 0.0,
            -1.69775, -1.31482, -3.06413, -3.06413], 1e-5))
    }
    
    func testInverted() {
        let m0 = Matrix4(
            1.34242, 1.64535, 1.85, 0.0,
            -1.13071, -1.01591, 2.35432, 0.0,
            0.958851, -3.50154, 0.186233, 0.0,
            0.759721, 7.04498, -11.8232, -11.8232)
        let invres = Matrix4.inverted(m0)
        XCTAssertTrue(invres.valid)
        XCTAssertTrue((m0 * invres.result).isIdentity())
    }
    
    func testTransposed() {
        // TODO
    }
    
    func testInvTransed() {
        // TODO
    }
    
    func testTranslated() {
        // TODO
    }
    
    func testRotated() {
        // TODO
    }
    
    func testScaled() {
        // TODO
    }
    
    func testMulV3() {
        let v0 = Vector3()
        let m0 = Matrix4.makeTranslation(1.0, 2.0, 3.0)
        
        let vt = Matrix4.mulV3(m0, v0)
        XCTAssertTrue(vt.isEqual(0.0, 0.0, 0.0))
    }
    
    func testTransformV3() {
        let v0 = Vector3()
        let m0 = Matrix4.makeTranslation(1.0, 2.0, 3.0)
        
        let vt = Matrix4.transformV3(m0, v0)
        XCTAssertTrue(vt.isEqual(1.0, 2.0, 3.0))
    }
    
    func testMulV4() {
        let v0 = Vector4(0.0, 0.0, 0.0, 1.0)
        let m0 = Matrix4.makeTranslation(1.0, 2.0, 3.0)
        
        let vt = Matrix4.mulV4(m0, v0)
        XCTAssertTrue(vt.isEqual(1.0, 2.0, 3.0, 1.0))
    }
    
    /*
    func testMulAndProjectV3() {
        // TODO
    }
    */
    
    // operaters
    func testOperatorAdd() {
        let m0 = Matrix4(
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 10.0, 11.0, 12.0,
            13.0, 14.0, 15.0, 16.0
        )
        let m1 = Matrix4(
            11.0, 12.0, 13.0, 14.0,
            15.0, 16.0, 17.0, 18.0,
            19.0, 20.0, 21.0, 22.0,
            23.0, 24.0, 25.0, 26.0
        )
        let m2 = m0 + m1
        XCTAssertTrue(m2.isEqual([
            12.0, 14.0, 16.0, 18.0,
            20.0, 22.0, 24.0, 26.0,
            28.0, 30.0, 32.0, 34.0,
            36.0, 38.0, 40.0, 42.0
            ]))
    }
    
    func testOperatorSub() {
        let m0 = Matrix4(
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 10.0, 11.0, 12.0,
            13.0, 14.0, 15.0, 16.0
        )
        let m1 = Matrix4(
            11.0, 12.0, 13.0, 14.0,
            15.0, 16.0, 17.0, 18.0,
            19.0, 20.0, 21.0, 22.0,
            23.0, 24.0, 25.0, 26.0
        )
        let m2 = m0 - m1
        XCTAssertTrue(m2.isEqual([
            -10.0, -10.0, -10.0, -10.0,
            -10.0, -10.0, -10.0, -10.0,
            -10.0, -10.0, -10.0, -10.0,
            -10.0, -10.0, -10.0, -10.0
            ]))
    }
    
    func testOperatorMul() {
        let m0 = Matrix4(
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 10.0, 11.0, 12.0,
            13.0, 14.0, 15.0, 16.0
        )
        let m1 = Matrix4(
            11.0, 12.0, 13.0, 14.0,
            15.0, 16.0, 17.0, 18.0,
            19.0, 20.0, 21.0, 22.0,
            23.0, 24.0, 25.0, 26.0
        )
        
        let m2 = m0 * m1
        XCTAssertTrue(m2.isEqual([
            370.0, 420.0, 470.0, 520.0,
            482.0, 548.0, 614.0, 680.0,
            594.0, 676.0, 758.0, 840.0,
            706.0, 804.0, 902.0, 902.0
            ]))
    }
    
    func testOperatorMulScalarBack() {
        let m0 = Matrix4(
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 10.0, 11.0, 12.0,
            13.0, 14.0, 15.0, 16.0
        )
        let m1 = m0 * 2.0
        XCTAssertTrue(m1.isEqual([
            2.0, 4.0, 6.0, 8.0,
            10.0, 12.0, 14.0, 16.0,
            18.0, 20.0, 22.0, 24.0,
            26.0, 28.0, 30.0, 32.0
            ]))
    }
    
    func testOperatorMulScalarFront() {
        let m0 = Matrix4(
            1.0, 2.0, 3.0, 4.0,
            5.0, 6.0, 7.0, 8.0,
            9.0, 10.0, 11.0, 12.0,
            13.0, 14.0, 15.0, 16.0
        )
        let m1 = 2.0 * m0
        XCTAssertTrue(m1.isEqual([
            2.0, 4.0, 6.0, 8.0,
            10.0, 12.0, 14.0, 16.0,
            18.0, 20.0, 22.0, 24.0,
            26.0, 28.0, 30.0, 32.0
            ]))
    }
    
    
    static var allTests = [
        ("testInitNoArg", testInitNoArg),
        ("testInit16Args", testInit16Args),
        ("testInitArrayArg", testInitArrayArg),
        ("testCopy", testCopy),
        ("testSet16Arg", testSet16Arg),
        ("testSetArrayArg", testSetArrayArg),
        ("testSetColumns", testSetColumns),
        ("testSetRows", testSetRows),
        ("testSetIdentity", testSetIdentity),
        ("testTranslation", testTranslation),
        ("testRotation", testRotation),
        ("testScale", testScale),
        ("testSetBasis", testSetBasis),
        ("testGetColumn", testGetColumn),
        ("testSetColumn", testSetColumn),
        ("testGetRow", testGetRow),
        ("testSetRow", testSetRow),
        ("testInvert", testInvert),
        ("testTranspose", testTranspose),
        ("testTransform", testTransform),
        ("testMulV3", testMulV3),
        ("testTransformV3", testTransformV3),
        ("testMulV4", testMulV4),
        ("testOperatorAdd", testOperatorAdd),
        ("testOperatorSub", testOperatorSub),
        ("testOperatorMul", testOperatorMul),
        ("testOperatorMulScalarBack", testOperatorMulScalarBack),
        ("testOperatorMulScalarFront", testOperatorMulScalarFront),
        //("", ),
        ]
}
