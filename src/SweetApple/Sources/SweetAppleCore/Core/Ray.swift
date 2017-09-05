#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class Ray {
    public var origin:Vector3
    public var direction:Vector3
    public var weight:Color
    public var fromBXDF:Int
    
    public init() {
        origin = Vector3(0.0, 0.0, 0.0)
        direction = Vector3(0.0, 0.0, -1.0)
        weight = Color(1.0, 1.0, 1.0)
        fromBXDF = -1
    }
    
    public init(_ orig:Vector3, _ dir:Vector3, _ from:Int = -1) {
        origin = orig
        direction = dir
        weight = Color(1.0, 1.0, 1.0)
        fromBXDF = from
    }
    
    public init(_ orig:Vector3, _ dir:Vector3, _ w:Color, _ from:Int = -1) {
        origin = orig
        direction = dir
        weight = w
        fromBXDF = from
    }
    
    public func copy() -> Ray {
        return Ray(origin, direction, weight, fromBXDF)
    }
    
    //
    static public func makeTransformed(_ ray:Ray, _ transm:Matrix4) -> Ray {
        let ret = ray.copy()
        ret.origin = Matrix4.transformV3(transm, ray.origin)
        ret.direction = Matrix4.mulV3(transm, ray.direction)
        _ = ret.direction.normalize()
        return ret
    }
}

