#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

public struct Vector3 {
    public var x:Double
    public var y:Double
    public var z:Double
    
    public enum Component: Int {
        case kX = 0
        case kY
        case kZ
        
        static let iterate = [kX, kY, kZ]
    }
    
    //
    public init() {
        x = 0.0
        y = 0.0
        z = 0.0
    }
    
    public init(_ x:Double, _ y:Double, _ z:Double) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public init(_ v:Vector3) {
        self.x = v.x;
        self.y = v.y;
        self.z = v.z;
    }
    
    public func copy() -> Vector3 {
        return Vector3(self);
    }
    
    // self operations
    public mutating func set(_ x:Double, _ y:Double, _ z:Double) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public func length() -> Double {
        return (x * x + y * y + z * z).squareRoot()
    }
    
    public func distance(_ v:Vector3) -> Double {
        let dv = self - v
        return dv.length()
    }
    
    public mutating func normalize() -> Bool {
        let l = length()
        
        if l < kLamEPS {
            return false
        }
        
        x /= l
        y /= l
        z /= l
        
        return true
    }
    
    public mutating func negate() {
        x = -x
        y = -y
        z = -z
    }
    
    /*
    public func isZero() -> Bool {
        return x == 0.0 && y == 0.0 && z == 0.0
    }
     */
    
    public func isZero(_ eps:Double = kLamEPS) -> Bool {
        return (abs(x) < eps) && (abs(y) < eps) && (abs(z) < eps)
    }
    
    public func maxMagnitude() -> Double {
        return Double.maximumMagnitude(Double.maximumMagnitude(x, y), z)
    }
    
    public func maxMagnitudeAndIndex() -> (value:Double, index:Int) {
        var n:Double
        var i:Int
        
        if(abs(x) > abs(y)) {
            n = x
            i = 0
        } else {
            n = y
            i = 1
        }
        if(abs(z) > n) {
            n = z
            i = 2
        }
        return (n, i)
    }
    
    // 2 vector operations utilities
    static public func distance(_ v0:Vector3, _ v1:Vector3) -> Double {
        let tmpv:Vector3 = v0 - v1
        return tmpv.length()
    }
    
    static public func normalized(_ v:Vector3) -> Vector3 {
        var ret:Vector3 = v
        _ = ret.normalize()
        return ret;
    }
    
    static public func negated(_ v:Vector3) ->Vector3 {
        return Vector3(-v.x, -v.y, -v.z)
    }
    
    static public func mul(_ v0:Vector3, _ v1:Vector3) -> Vector3 {
        let x = v0.x * v1.x
        let y = v0.y * v1.y
        let z = v0.z * v1.z
        return Vector3(x, y, z)
    }
    
    static public func div(_ v0:Vector3, _ v1:Vector3) -> Vector3 {
        let x = v0.x / v1.x
        let y = v0.y / v1.y
        let z = v0.z / v1.z
        return Vector3(x, y, z)
    }
    
    static public func dot(_ v0:Vector3, _ v1:Vector3) -> Double {
        return v0.x * v1.x + v0.y * v1.y + v0.z * v1.z
    }
    
    static public func cross(_ v0:Vector3, _ v1:Vector3) -> Vector3 {
        let x = v0.y * v1.z - v0.z * v1.y
        let y = v0.z * v1.x - v0.x * v1.z
        let z = v0.x * v1.y - v0.y * v1.x
        return Vector3(x, y, z);
    }
    
    static public func lerp(_ v0:Vector3, _ v1:Vector3, _ t:Double) -> Vector3 {
        let t0 = 1.0 - t
        let x = v0.x * t0 + v1.x * t
        let y = v0.y * t0 + v1.y * t
        let z = v0.z * t0 + v1.z * t
        return Vector3(x, y, z);
    }
    
    static public func projected(_ v0:Vector3, _ v1:Vector3) -> Vector3 {
        let nv:Vector3 = Vector3.normalized(v1)
        let d:Double = Vector3.dot(v0, nv)
        return nv * d
    }
    
    // utils
    public func toString() -> String {
        return "Vector3(\(x),\(y),\(z))"
    }
    
    public func componentValue(_ i:Component) -> Double {
        switch i {
        case .kX: return x
        case .kY: return y
        case .kZ: return z
        }
    }
    
    public mutating func setComponentValue(_ i:Component, _ v:Double) {
        switch i {
        case .kX: x = v
        case .kY: y = v
        case .kZ: z = v
        }
    }
    
    // operators
    static public func - (a:Vector3, b:Vector3) -> Vector3 {
        return Vector3(a.x - b.x, a.y - b.y, a.z - b.z)
    }
    
    static public func + (a:Vector3, b:Vector3) -> Vector3 {
        return Vector3(a.x + b.x, a.y + b.y, a.z + b.z)
    }
    
    static public func * (v:Vector3, s:Double) -> Vector3 {
        return Vector3(v.x * s, v.y * s, v.z * s)
    }
    static public func * (s:Double, v:Vector3) -> Vector3 {
        return v * s
    }
    
    static public func / (v:Vector3, s:Double) -> Vector3 {
        return Vector3(v.x / s, v.y / s, v.z / s)
    }
    /*
    static public func / (s:Double, v:Vector3) -> Vector3 {
        return v / s
    }
    */
    static public func += (a:inout Vector3, b:Vector3) {
        a = a + b;
    }
}
