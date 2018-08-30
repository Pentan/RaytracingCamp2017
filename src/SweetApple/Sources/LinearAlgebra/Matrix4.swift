#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

/*
 matrix[16] =
 | 0 4  8 12 |
 | 1 5  9 13 |
 | 2 6 10 14 |
 | 3 7 11 15 |
 */

public struct Matrix4 {
    // member
    public var m:[Double] = [
        1.0, 0.0, 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0
        ]
    /*
    public var m00:Double {
        get {
            return m[0]
        }
        set(a) {
            m[0] = a
        }
    }
     */
    
    // initializer
    public init() {
    }
    
    public init(
        _ im00:Double, _ im01:Double, _ im02:Double, _ im03:Double,
        _ im10:Double, _ im11:Double, _ im12:Double, _ im13:Double,
        _ im20:Double, _ im21:Double, _ im22:Double, _ im23:Double,
        _ im30:Double, _ im31:Double, _ im32:Double, _ im33:Double)
    {
        m[0] = im00
        m[1] = im01
        m[2] = im02
        m[3] = im03
        
        m[4] = im10
        m[5] = im11
        m[6] = im12
        m[7] = im13
        
        m[8] = im20
        m[9] = im21
        m[10] = im22
        m[11] = im23
        
        m[12] = im30
        m[13] = im31
        m[14] = im32
        m[15] = im33
    }
    
    public init(_ im:[Double]) {
        self.m = im
        /*
        for i in 0..<16 {
            m[i] = im[i]
        }
         */
    }
    
    public init(_ im:Matrix4) {
        self.m = im.m
    }
    
    public func copy() -> Matrix4 {
        return Matrix4(self)
    }
    
    // self operation
    public mutating func set(
        _ nm00:Double, _ nm01:Double, _ nm02:Double, _ nm03:Double,
        _ nm10:Double, _ nm11:Double, _ nm12:Double, _ nm13:Double,
        _ nm20:Double, _ nm21:Double, _ nm22:Double, _ nm23:Double,
        _ nm30:Double, _ nm31:Double, _ nm32:Double, _ nm33:Double)
    {
        m[0] = nm00
        m[1] = nm01
        m[2] = nm02
        m[3] = nm03
        
        m[4] = nm10
        m[5] = nm11
        m[6] = nm12
        m[7] = nm13
        
        m[8] = nm20
        m[9] = nm21
        m[10] = nm22
        m[11] = nm23
        
        m[12] = nm30
        m[13] = nm31
        m[14] = nm32
        m[15] = nm33
    }
    
    public mutating func set(_ nm:[Double]) {
        self.m = nm
        /*
        for i in 0..<16 {
            m[i] = nm[i]
        }
         */
    }
    
    public mutating func setColumns(_ c0:Vector4, _ c1:Vector4, _ c2:Vector4, _ c3:Vector4) {
        m[0] = c0.x
        m[1] = c0.y
        m[2] = c0.z
        m[3] = c0.w
        
        m[4] = c1.x
        m[5] = c1.y
        m[6] = c1.z
        m[7] = c1.w
        
        m[8] = c2.x
        m[9] = c2.y
        m[10] = c2.z
        m[11] = c2.w
        
        m[12] = c3.x
        m[13] = c3.y
        m[14] = c3.z
        m[15] = c3.w
    }
    
    public mutating func setRows(_ r0:Vector4, _ r1:Vector4, _ r2:Vector4, _ r3:Vector4) {
        m[0] = r0.x
        m[1] = r1.x
        m[2] = r2.x
        m[3] = r3.x
        
        m[4] = r0.y
        m[5] = r1.y
        m[6] = r2.y
        m[7] = r3.y
        
        m[8] = r0.z
        m[9] = r1.z
        m[10] = r2.z
        m[11] = r3.z
        
        m[12] = r0.w
        m[13] = r1.w
        m[14] = r2.w
        m[15] = r3.w
    }
    
    public mutating func setIdentity() {
        m[0] = 1.0
        m[1] = 0.0
        m[2] = 0.0
        m[3] = 0.0
        
        m[4] = 0.0
        m[5] = 1.0
        m[6] = 0.0
        m[7] = 0.0
        
        m[8] = 0.0
        m[9] = 0.0
        m[10] = 1.0
        m[11] = 0.0
        
        m[12] = 0.0
        m[13] = 0.0
        m[14] = 0.0
        m[15] = 1.0
    }
    
    public mutating func setTranslation(_ tx:Double, _ ty:Double, _ tz:Double) {
        setIdentity()
        m[12] = tx
        m[13] = ty
        m[14] = tz
    }
    
    public mutating func setRotation(_ rad:Double, _ axisx:Double, _ axisy:Double, _ axisz:Double, normalized:Bool = true) {
        let sn = sin(rad)
        let cs = cos(rad)
        
        var ax = axisx
        var ay = axisy
        var az = axisz
        
        if !normalized {
            let invl = 1.0 / (ax * ax + ay * ay + az * az).squareRoot()
            ax *= invl
            ay *= invl
            az *= invl
        }
        
        m[0] = ax * ax * (1.0 - cs) + cs
        m[1] = ax * ay * (1.0 - cs) + sn * az
        m[2] = ax * az * (1.0 - cs) + sn * -ay
        m[3] = 0.0
        
        m[4] = ax * ay * (1.0 - cs) + sn * -az
        m[5] = ay * ay * (1.0 - cs) + cs
        m[6] = ay * az * (1.0 - cs) + sn * ax
        m[7] = 0.0
        
        m[8] = ax * az * (1.0 - cs) + sn * ay
        m[9] = ay * az * (1.0 - cs) + sn * -ax
        m[10] = az * az * (1.0 - cs) + cs
        m[11] = 0.0
        
        m[12] = 0.0
        m[13] = 0.0
        m[14] = 0.0
        m[15] = 1.0
    }
    
    public mutating func setScale(_ sx:Double, _ sy:Double, _ sz:Double) {
        setIdentity()
        m[0] = sx
        m[5] = sy
        m[10] = sz
        
    }
    
    public mutating func setBasis(_ bvx:Vector3, _ bvy:Vector3, _ bvz:Vector3, normalized:Bool = true) {
        var vx = bvx
        var vy = bvy
        var vz = bvz
        
        if !normalized {
            _ = vx.normalize()
            _ = vy.normalize()
            _ = vz.normalize()
        }
        
        m[0] = vx.x
        m[1] = vy.x
        m[2] = vz.x
        m[3] = 0.0
        
        m[4] = vx.y
        m[5] = vy.y
        m[6] = vz.y
        m[7] = 0.0
        
        m[8] = vx.z
        m[9] = vy.z
        m[10] = vz.z
        m[11] = 0.0
        
        m[12] = 0.0
        m[13] = 0.0
        m[14] = 0.0
        m[15] = 1.0
    }
    
    public func getColumn(_ col:Int) -> Vector4 {
        let i = col * 4
        return Vector4(m[i], m[i + 1], m[i + 2], m[i + 3])
    }
    
    public mutating func setColumn(_ col:Int, _ v:Vector4) {
        let i = col * 4
        m[i] = v.x
        m[i + 1] = v.y
        m[i + 2] = v.z
        m[i + 3] = v.w
    }
    
    public func getRow(_ row:Int) -> Vector4 {
        return Vector4(m[row], m[row + 4], m[row + 8], m[row + 12])
    }
    
    public mutating func setRow(_ row:Int, _ v:Vector4) {
        m[row] = v.x
        m[row + 4] = v.y
        m[row + 8] = v.z
        m[row + 12] = v.w
    }
    
    public mutating func invert() -> Bool {
        var rows = [
            [m[0], m[4], m[8], m[12]],
            [m[1], m[5], m[9], m[13]],
            [m[2], m[6], m[10], m[14]],
            [m[3], m[7], m[11], m[15]]
        ]
        var invrows = [
            [1.0, 0.0, 0.0, 0.0],
            [0.0, 1.0, 0.0, 0.0],
            [0.0, 0.0, 1.0, 0.0],
            [0.0, 0.0, 0.0, 1.0]
        ]
        var rowIndex = [0, 1, 2, 3]
        
        for i in 0..<4 {
            // choose pivot
            var maxIndex = i
            var maxValue = abs(rows[rowIndex[i]][i])
            for j in (i + 1)..<4 {
                let absrow = abs(rows[rowIndex[j]][i])
                if absrow > maxValue {
                    maxValue = absrow
                    maxIndex = j
                }
            }
            if maxIndex != i {
                rowIndex.swapAt(i, maxIndex)
            }
            
            // error
            if abs(rows[rowIndex[i]][i]) < kLamEPS {
                return false
            }
            
            // eliminate
            let pivotIndex = rowIndex[i]
            let pivotValue = rows[pivotIndex][i]
            
            // normalize pivot row
            for k in 0..<4 {
                rows[pivotIndex][k] /= pivotValue
                invrows[pivotIndex][k] /= pivotValue
            }
            
            // eliminate other rows
            for j in 0..<4 {
                if i == j { continue }
                
                let irow = rowIndex[j]
                let tmpval = rows[irow][i]
                
                for k in 0..<4 {
                    rows[irow][k] -= rows[pivotIndex][k] * tmpval
                    invrows[irow][k] -= invrows[pivotIndex][k] * tmpval
                }
            }
        }
        
        m[0] = invrows[0][0]
        m[1] = invrows[1][0]
        m[2] = invrows[2][0]
        m[3] = invrows[3][0]
        
        m[4] = invrows[0][1]
        m[5] = invrows[1][1]
        m[6] = invrows[2][1]
        m[7] = invrows[3][1]
        
        m[8]  = invrows[0][2]
        m[9]  = invrows[1][2]
        m[10] = invrows[2][2]
        m[11] = invrows[3][2]
        
        m[12] = invrows[0][3]
        m[13] = invrows[1][3]
        m[14] = invrows[2][3]
        m[15] = invrows[3][3]
        
        return true;
    }
    
    public mutating func transpose() {
        m.swapAt(1, 4)
        m.swapAt(2, 8)
        m.swapAt(3, 12)
        m.swapAt(6, 9)
        m.swapAt(7, 13)
        m.swapAt(11, 14)
    }
    
    public mutating func invTrans() -> Bool{
        let ret = invert()
        transpose()
        return ret
    }
    
    public mutating func translate(_ tx:Double,_ ty:Double, _ tz:Double) {
        m[12] = m[0] * tx + m[4] * ty + m[8] * tz + m[12]
        m[13] = m[1] * tx + m[5] * ty + m[9] * tz + m[13]
        m[14] = m[2] * tx + m[6] * ty + m[10] * tz + m[14]
    }
    
    public mutating func translate(_ tv:Vector3) {
        translate(tv.x, tv.y, tv.z)
    }
    
    public mutating func rotate(_ rad:Double, _ ax:Double, _ ay:Double, _ az:Double, normalized:Bool = true) {
        self = self * Matrix4.makeRotation(rad, ax, ay, az, normalized: normalized)
    }
    
    public mutating func rotate(_ rad:Double, _ axisv:Vector3, normalized:Bool = true) {
        rotate(rad, axisv.x, axisv.y, axisv.z, normalized: normalized)
    }
    
    public mutating func scale(_ sx:Double, _ sy:Double, _ sz:Double) {
        m[0] *= sx;
        m[1] *= sx;
        m[2] *= sx;
        m[3] *= sx;
        
        m[4] *= sy;
        m[5] *= sy;
        m[6] *= sy;
        m[7] *= sy;
        
        m[8] *= sz;
        m[9] *= sz;
        m[10] *= sz;
        m[11] *= sz;
    }
    
    public mutating func scale(_ scalev:Vector3) {
        scale(scalev.x, scalev.y, scalev.z)
    }
    
    // 1 matrix operations
    static public func makeTranslation(_ tx:Double, _ ty:Double, _ tz:Double) -> Matrix4 {
        var ret = Matrix4()
        ret.setTranslation(tx, ty, tz)
        return ret
    }
    
    static public func makeRotation(_ rad:Double, _ ax:Double, _ ay:Double, _ az:Double, normalized:Bool = true) -> Matrix4 {
        var ret = Matrix4()
        ret.setRotation(rad, ax, ay, az, normalized: normalized)
        return ret
    }
    
    static public func makeScale(_ sx:Double, _ sy:Double, _ sz:Double) -> Matrix4 {
        var ret = Matrix4()
        ret.setScale(sx, sy, sz)
        return ret
    }

    static public func makeFromQuaternion(_ qx:Double, _ qy:Double, _ qz:Double, _ qw:Double) -> Matrix4 {
        var ret = Matrix4()
        
        ret.m[0] = 1.0 - 2.0 * (qy * qy + qz * qz)
        ret.m[1] = 2.0 * (qx * qy + qz * qw)
        ret.m[2] = 2.0 * (qz * qx - qw * qy)
        ret.m[3] = 0.0
        
        ret.m[4] = 2.0 * (qx * qy - qz * qw)
        ret.m[5] = 1.0 - 2.0 * (qz * qz + qx * qx)
        ret.m[6] = 2.0 * (qy * qz + qw * qx)
        ret.m[7] = 0.0
        
        ret.m[8] = 2.0 * (qz * qx + qw * qy)
        ret.m[9] = 2.0 * (qy * qz - qx * qw)
        ret.m[10] = 1.0 - 2.0 * (qx * qx + qy * qy)
        ret.m[11] = 0.0
        
        ret.m[12] = 0.0
        ret.m[13] = 0.0
        ret.m[14] = 0.0
        ret.m[15] = 1.0
        
        return ret
    }
    
    static public func makeOrtho(_ left:Double, _ right:Double, _ bottom:Double, _ top:Double, _ near:Double, _ far:Double) -> Matrix4 {
        var ret = Matrix4()
        ret.m[0] = 2.0 / (right - left)
        ret.m[1] = 0.0
        ret.m[2] = 0.0
        ret.m[3] = 0.0
        
        ret.m[4] = 0.0
        ret.m[5] = 2.0 / (top - bottom)
        ret.m[6] = 0.0
        ret.m[7] = 0.0
        
        ret.m[8] = 0.0
        ret.m[9] = 0.0
        ret.m[10] = -2.0 / (far - near)
        ret.m[11] = 0.0
        
        ret.m[12] = -(right + left) / (right - left)
        ret.m[13] = -(top + bottom) / (top - bottom)
        ret.m[14] = -(far + near) / (far - near)
        ret.m[15] = 1.0
        return ret
    }
    static public func makeFrustum(_ left:Double, _ right:Double, _ bottom:Double, _ top:Double, _ near:Double, _ far:Double) -> Matrix4 {
        var ret = Matrix4()
        ret.m[0] = 2.0 * near / (right - left)
        ret.m[1] = 0.0
        ret.m[2] = 0.0
        ret.m[3] = 0.0
        
        ret.m[4] = 0.0
        ret.m[5] = 2.0 * near / (top - bottom)
        ret.m[6] = 0.0
        ret.m[7] = 0.0
        
        ret.m[8] = (right + left) / (right - left)
        ret.m[9] = (top + bottom) / (top - bottom)
        ret.m[10] = -(far + near) / (far - near)
        ret.m[11] = -1.0
        
        ret.m[12] = 0.0
        ret.m[13] = 0.0
        ret.m[14] = -2.0 * far * near / (far - near)
        ret.m[15] = 0.0
        return ret
    }
    
    static public func makePerspective(_ yrad:Double, _ aspect:Double, _ near:Double, _ far:Double) -> Matrix4 {
        let top:Double = tan(yrad * 0.5) * near
        let right:Double = top * aspect
        return Matrix4.makeFrustum(-right, right, -top, top, near, far);
    }
    
    static public func makeLookAt(_ eyepos:Vector3, _ lookat:Vector3, _ updir:Vector3) -> Matrix4 {
        var ret = Matrix4();
        
        let nrmupv = Vector3.normalized(updir)
        let eyev = Vector3.normalized(lookat - eyepos)
        let sidev = Vector3.normalized(Vector3.cross(eyev, nrmupv))
        let upv = Vector3.normalized(Vector3.cross(sidev, eyev))
        
        ret.m[0] = sidev.x;
        ret.m[1] = upv.x;
        ret.m[2] = -eyev.x;
        ret.m[3] = 0.0;
        
        ret.m[4] = sidev.y;
        ret.m[5] = upv.y;
        ret.m[6] = -eyev.y;
        ret.m[7] = 0.0;
        
        ret.m[8] = sidev.z;
        ret.m[9] = upv.z;
        ret.m[10] = -eyev.z;
        ret.m[11] = 0.0;
        
        ret.m[12] = 0.0;
        ret.m[13] = 0.0;
        ret.m[14] = 0.0;
        ret.m[15] = 1.0;
        
        return Matrix4.translated(ret, -eyepos.x, -eyepos.y, -eyepos.z);
    }
    
    static public func makeBasis(_ ivy:Vector3) -> Matrix4 {
        var vx = Vector3()
        var tmpmin:Double
        
        let ax = abs(ivy.x)
        let ay = abs(ivy.y)
        let az = abs(ivy.z)
        
        if ax < ay {
            vx.set(1.0, 0.0, 0.0)
            tmpmin = ax
        } else {
            vx.set(0.0, 1.0, 0.0)
            tmpmin = ay
        }
        
        if az < tmpmin {
            vx.set(0.0, 0.0, 1.0)
            tmpmin = az
        }
        
        let vz = Vector3.normalized(Vector3.cross(vx, ivy))
        vx = Vector3.normalized(Vector3.cross(ivy, vz))
        
        var ret = Matrix4()
        ret.setBasis(vx, ivy, vz)
        
        return ret
    }
    
    static public func inverted(_ m:Matrix4) -> (result:Matrix4, valid:Bool) {
        var tmpm = m.copy()
        let invres = tmpm.invert()
        return (tmpm, invres)
    }
    static public func transposed(_ m:Matrix4) -> Matrix4 {
        var tmpm = m.copy()
        tmpm.transpose()
        return tmpm
    }
    static public func invTransed(_ m:Matrix4) -> (result:Matrix4, valid:Bool) {
        var tmpm = m.copy()
        let invres = tmpm.invTrans()
        return (tmpm, invres)
    }
    
    static public func translated(_ m:Matrix4, _ tx:Double, _ ty:Double, _ tz:Double) -> Matrix4 {
        var tmpm = m.copy()
        tmpm.translate(tx, ty, tz)
        return tmpm
    }
    
    static public func translated(_ m:Matrix4, _ tv:Vector3) -> Matrix4 {
        var tmpm = m.copy()
        tmpm.translate(tv)
        return tmpm
    }
    
    static public func rotated(_ m:Matrix4, _ rad:Double, _ ax:Double, _ ay:Double, _ az:Double) -> Matrix4 {
        var tmpm = m.copy()
        tmpm.rotate(rad, ax, ay, az)
        return tmpm
    }
    
    static public func rotated(_ m:Matrix4, _ rad:Double, _ axisv:Vector3) -> Matrix4 {
        var tmpm = m.copy()
        tmpm.rotate(rad, axisv)
        return tmpm
    }
    
    static public func scaled(_ m:Matrix4, _ sx:Double, _ sy:Double, _ sz:Double) -> Matrix4 {
        var tmpm = m.copy()
        tmpm.scale(sx, sy, sz)
        return tmpm
    }
    
    static public func scaled(_ m:Matrix4, _ scalev:Vector3) -> Matrix4 {
        var tmpm = m.copy()
        tmpm.scale(scalev)
        return tmpm
    }
    
    // vs vectors
    static public func mulV3(_ ml:Matrix4, _ vr:Vector3) -> Vector3 {
        // multiply upper 3x3 matrix
        let vx = ml.m[0] * vr.x + ml.m[4] * vr.y + ml.m[8] * vr.z
        let vy = ml.m[1] * vr.x + ml.m[5] * vr.y + ml.m[9] * vr.z
        let vz = ml.m[2] * vr.x + ml.m[6] * vr.y + ml.m[10] * vr.z
        return Vector3(vx, vy, vz)
    }
    
    static public func transformV3(_ ml:Matrix4, _ vr:Vector3) -> Vector3 {
        let vx = ml.m[0] * vr.x + ml.m[4] * vr.y + ml.m[8] * vr.z + ml.m[12]
        let vy = ml.m[1] * vr.x + ml.m[5] * vr.y + ml.m[9] * vr.z + ml.m[13]
        let vz = ml.m[2] * vr.x + ml.m[6] * vr.y + ml.m[10] * vr.z + ml.m[14]
        return Vector3(vx, vy, vz)
    }
    
    static public func mulV4(_ ml:Matrix4, _ vr:Vector4) -> Vector4{
        // multiply upper 3x3 matrix
        let vx = ml.m[0] * vr.x + ml.m[4] * vr.y + ml.m[8] * vr.z + ml.m[12] * vr.w
        let vy = ml.m[1] * vr.x + ml.m[5] * vr.y + ml.m[9] * vr.z + ml.m[13] * vr.w
        let vz = ml.m[2] * vr.x + ml.m[6] * vr.y + ml.m[10] * vr.z + ml.m[14] * vr.w
        let vw = ml.m[3] * vr.x + ml.m[7] * vr.y + ml.m[11] * vr.z + ml.m[15] * vr.w
        return Vector4(vx, vy, vz, vw)
    }
    
    static public func mulAndProjectV3(_ ml:Matrix4, _ vr:Vector3) -> Vector3 {
        var v4 = Vector4(vr, 1.0)
        v4 = Matrix4.mulV4(ml, v4) * (1.0 / v4.w);
        return v4.getXYZ();
    }
    
    
    // operaters
    static public func + (ml:Matrix4, mr:Matrix4) -> Matrix4 {
        var mres = Matrix4()
        
        mres.m[0] = ml.m[0] + mr.m[0]
        mres.m[1] = ml.m[1] + mr.m[1]
        mres.m[2] = ml.m[2] + mr.m[2]
        mres.m[3] = ml.m[3] + mr.m[3]
        
        mres.m[4] = ml.m[4] + mr.m[4]
        mres.m[5] = ml.m[5] + mr.m[5]
        mres.m[6] = ml.m[6] + mr.m[6]
        mres.m[7] = ml.m[7] + mr.m[7]
        
        mres.m[8] = ml.m[8] + mr.m[8]
        mres.m[9] = ml.m[9] + mr.m[9]
        mres.m[10] = ml.m[10] + mr.m[10]
        mres.m[11] = ml.m[11] + mr.m[11]
        
        mres.m[12] = ml.m[12] + mr.m[12]
        mres.m[13] = ml.m[13] + mr.m[13]
        mres.m[14] = ml.m[14] + mr.m[14]
        mres.m[15] = ml.m[15] + mr.m[15]
        
        return mres
    }
    
    static public func - (ml:Matrix4, mr:Matrix4) -> Matrix4 {
        var mres = Matrix4()
        
        mres.m[0] = ml.m[0] - mr.m[0]
        mres.m[1] = ml.m[1] - mr.m[1]
        mres.m[2] = ml.m[2] - mr.m[2]
        mres.m[3] = ml.m[3] - mr.m[3]
        
        mres.m[4] = ml.m[4] - mr.m[4]
        mres.m[5] = ml.m[5] - mr.m[5]
        mres.m[6] = ml.m[6] - mr.m[6]
        mres.m[7] = ml.m[7] - mr.m[7]
        
        mres.m[8] = ml.m[8] - mr.m[8]
        mres.m[9] = ml.m[9] - mr.m[9]
        mres.m[10] = ml.m[10] - mr.m[10]
        mres.m[11] = ml.m[11] - mr.m[11]
        
        mres.m[12] = ml.m[12] - mr.m[12]
        mres.m[13] = ml.m[13] - mr.m[13]
        mres.m[14] = ml.m[14] - mr.m[14]
        mres.m[15] = ml.m[15] - mr.m[15]
        
        return mres
    }
    
    static public func * (ml:Matrix4, mr:Matrix4) -> Matrix4 {
        var mres = Matrix4()
        /*
         | 0 4  8 12 | | 0 4  8 12 |
         | 1 5  9 13 | | 1 5  9 13 |
         | 2 6 10 14 | | 2 6 10 14 |
         | 3 7 11 15 | | 3 7 11 15 |
         */
        
        mres.m[0] = ml.m[0] * mr.m[0] + ml.m[4] * mr.m[1] + ml.m[8]  * mr.m[2] + ml.m[12] * mr.m[3]
        mres.m[1] = ml.m[1] * mr.m[0] + ml.m[5] * mr.m[1] + ml.m[9]  * mr.m[2] + ml.m[13] * mr.m[3]
        mres.m[2] = ml.m[2] * mr.m[0] + ml.m[6] * mr.m[1] + ml.m[10] * mr.m[2] + ml.m[14] * mr.m[3]
        mres.m[3] = ml.m[3] * mr.m[0] + ml.m[7] * mr.m[1] + ml.m[11] * mr.m[2] + ml.m[15] * mr.m[3]
        
        mres.m[4] = ml.m[0] * mr.m[4] + ml.m[4] * mr.m[5] + ml.m[8]  * mr.m[6] + ml.m[12] * mr.m[7]
        mres.m[5] = ml.m[1] * mr.m[4] + ml.m[5] * mr.m[5] + ml.m[9]  * mr.m[6] + ml.m[13] * mr.m[7]
        mres.m[6] = ml.m[2] * mr.m[4] + ml.m[6] * mr.m[5] + ml.m[10] * mr.m[6] + ml.m[14] * mr.m[7]
        mres.m[7] = ml.m[3] * mr.m[4] + ml.m[7] * mr.m[5] + ml.m[11] * mr.m[6] + ml.m[15] * mr.m[7]
        
        mres.m[8]  = ml.m[0] * mr.m[8] + ml.m[4] * mr.m[9] + ml.m[8]  * mr.m[10] + ml.m[12] * mr.m[11]
        mres.m[9]  = ml.m[1] * mr.m[8] + ml.m[5] * mr.m[9] + ml.m[9]  * mr.m[10] + ml.m[13] * mr.m[11]
        mres.m[10] = ml.m[2] * mr.m[8] + ml.m[6] * mr.m[9] + ml.m[10] * mr.m[10] + ml.m[14] * mr.m[11]
        mres.m[11] = ml.m[3] * mr.m[8] + ml.m[7] * mr.m[9] + ml.m[11] * mr.m[10] + ml.m[15] * mr.m[11]
        
        mres.m[12] = ml.m[0] * mr.m[12] + ml.m[4] * mr.m[13] + ml.m[8]  * mr.m[14] + ml.m[12] * mr.m[15]
        mres.m[13] = ml.m[1] * mr.m[12] + ml.m[5] * mr.m[13] + ml.m[9]  * mr.m[14] + ml.m[13] * mr.m[15]
        mres.m[14] = ml.m[2] * mr.m[12] + ml.m[6] * mr.m[13] + ml.m[10] * mr.m[14] + ml.m[14] * mr.m[15]
        mres.m[15] = ml.m[3] * mr.m[12] + ml.m[7] * mr.m[13] + ml.m[11] * mr.m[14] + ml.m[15] * mr.m[15]
        
        return mres
    }
    
    static public func * (ml:Matrix4, s:Double) -> Matrix4 {
        var mres = Matrix4()
        
        mres.m[0] = ml.m[0] * s
        mres.m[1] = ml.m[1]  * s
        mres.m[2] = ml.m[2]  * s
        mres.m[3] = ml.m[3]  * s
        
        mres.m[4] = ml.m[4]  * s
        mres.m[5] = ml.m[5]  * s
        mres.m[6] = ml.m[6]  * s
        mres.m[7] = ml.m[7]  * s
        
        mres.m[8] = ml.m[8]  * s
        mres.m[9] = ml.m[9]  * s
        mres.m[10] = ml.m[10]  * s
        mres.m[11] = ml.m[11]  * s
        
        mres.m[12] = ml.m[12]  * s
        mres.m[13] = ml.m[13]  * s
        mres.m[14] = ml.m[14]  * s
        mres.m[15] = ml.m[15]  * s
        
        return mres
    }
    
    static public func * (s:Double, mr:Matrix4) -> Matrix4 {
        return mr * s
    }
}
