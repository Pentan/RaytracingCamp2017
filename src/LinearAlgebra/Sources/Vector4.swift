#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

public struct Vector4 {
    public var x:Double
    public var y:Double
    public var z:Double
    public var w:Double
    
    
    public enum Component: Int {
        case kX = 0
        case kY
        case kZ
        case kW
        
        static let iterate = [kX, kY, kZ]
    }
    
    //
    public init() {
        x = 0.0
        y = 0.0
        z = 0.0
        w = 0.0
    }
    
    public init(_ x:Double, _ y:Double, _ z:Double, _ w:Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    public init(_ v3:Vector3, _ w:Double) {
        self.x = v3.x
        self.y = v3.y
        self.z = v3.z
        self.w = w
    }
    
    public init(_ v:Vector4) {
        self.x = v.x
        self.y = v.y
        self.z = v.z
        self.w = v.w
    }
    
    public func copy() -> Vector4 {
        return Vector4(self)
    }
    
    // self operations
    public mutating func set(_ x:Double, _ y:Double, _ z:Double, _ w:Double) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    public mutating func set(_ v3:Vector3, _ w:Double) {
        self.x = v3.x
        self.y = v3.y
        self.z = v3.z
        self.w = w
    }
    
    public func getXYZ() -> Vector3 {
        return Vector3(x, y, z)
    }
    
    public func length() -> Double {
        return (x * x + y * y + z * z + w * w).squareRoot()
    }
    
    public func distance(_ v:Vector4) -> Double {
        let dv = self - v;
        return dv.length();
    }
    
    public mutating func normalize() -> Bool {
        let l = length()
        
        if l < kLamEPS {
            return false
        }
        
        x /= l
        y /= l
        z /= l
        w /= l
        
        return true
    }
    
    public mutating func negate() {
        x = -x
        y = -y
        z = -z
        w = -w
    }
    
    public func isZero(_ eps:Double = kLamEPS) -> Bool {
        return (abs(x) < eps) && (abs(y) < eps) && (abs(z) < eps) && (abs(w) < eps)
    }
    
    public func maxMagnitude() -> Double {
        return Double.maximumMagnitude(Double.maximumMagnitude(Double.maximumMagnitude(x, y), z), w)
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
        if(abs(w) > n) {
            n = w
            i = 3
        }
        return (n, i)
    }
    
    // 2 vector operations utilities
    static public func distance(_ v0:Vector4, _ v1:Vector4) -> Double {
        let tmpv:Vector4 = v0 - v1
        return tmpv.length()
    }
    
    static public func normalized(_ v:Vector4) -> Vector4 {
        var ret:Vector4 = v
        _ = ret.normalize()
        return ret
    }
    
    static public func negated(_ v:Vector4) -> Vector4 {
        return Vector4(-v.x, -v.y, -v.z, -v.w)
    }
    
    static public func mul(_ v0:Vector4, _ v1:Vector4) -> Vector4 {
        let x = v0.x * v1.x
        let y = v0.y * v1.y
        let z = v0.z * v1.z
        let w = v0.w * v1.w
        return Vector4(x, y, z, w)
    }
    
    static public func div(_ v0:Vector4, _ v1:Vector4) -> Vector4 {
        let x = v0.x / v1.x
        let y = v0.y / v1.y
        let z = v0.z / v1.z
        let w = v0.w / v1.w
        return Vector4(x, y, z, w)
    }
    
    static public func dot(_ v0:Vector4, _ v1:Vector4) -> Double {
        return v0.x * v1.x + v0.y * v1.y + v0.z * v1.z + v0.w * v1.w
    }
    
    static public func lerp(_ v0:Vector4, _ v1:Vector4, _ t:Double) -> Vector4 {
        let t0 = 1.0 - t
        let x = v0.x * t0 + v1.x * t
        let y = v0.y * t0 + v1.y * t
        let z = v0.z * t0 + v1.z * t
        let w = v0.w * t0 + v1.w * t
        return Vector4(x, y, z, w);
    }
    
    static public func projected(_ v0:Vector4, _ v1:Vector4) -> Vector4 {
        let nv:Vector4 = Vector4.normalized(v1);
        let d:Double = Vector4.dot(v0, nv);
        return nv * d;
    }
    
    // utils
    public func toString() -> String {
        return "Vector4(\(x),\(y),\(z),\(w))";
    }
    
    public func componentValue(_ i:Component) -> Double {
        switch i {
        case .kX: return x
        case .kY: return y
        case .kZ: return z
        case .kW: return w
        }
    }
    
    public mutating func setComponentValue(_ i:Component, _ v:Double) {
        switch i {
        case .kX: x = v
        case .kY: y = v
        case .kZ: z = v
        case .kW: w = v
        }
    }
    
    // operators
    static public func - (a:Vector4, b:Vector4) -> Vector4 {
        return Vector4(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w);
    }
    
    static public func + (a:Vector4, b:Vector4) -> Vector4 {
        return Vector4(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w);
    }
    
    static public func * (v:Vector4, s:Double) -> Vector4 {
        return Vector4(v.x * s, v.y * s, v.z * s, v.w * s);
    }
    static public func * (s:Double, v:Vector4) -> Vector4 {
        return v * s;
    }
    
    static public func / (v:Vector4, s:Double) -> Vector4 {
        return Vector4(v.x / s, v.y / s, v.z / s, v.w / s);
    }
    /*
    static public func / (s:Double, v:Vector4) -> Vector4 {
        return v / s;
    }
    */
    static public func += (a:inout Vector4, b:Vector4) {
        a = a + b;
    }
}
