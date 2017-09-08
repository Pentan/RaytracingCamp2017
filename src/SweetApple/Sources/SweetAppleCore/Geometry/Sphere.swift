#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class Sphere : Geometry {
    public var radius:Double
    public var position:Vector3
    
    public override init() {
        radius = 1.0
        position = Vector3()
    }
    
    public init(_ r:Double, _ p:Vector3) {
        radius = r
        position = p
    }
    
    public override func transfomredAABB(_ tm: Matrix4) -> AABB {
        // oriented AABB
        let vertices:[Vector3] = [
            position + Vector3( radius,  radius,  radius),
            position + Vector3(-radius,  radius,  radius),
            position + Vector3( radius, -radius,  radius),
            position + Vector3(-radius, -radius,  radius),
            position + Vector3( radius,  radius, -radius),
            position + Vector3(-radius,  radius, -radius),
            position + Vector3( radius, -radius, -radius),
            position + Vector3(-radius, -radius, -radius)
        ]
        let ret = AABB()
        for v in vertices {
            ret.expand(Matrix4.transformV3(tm, v))
        }
        return ret
    }
    
    public override func isIntersect(_ ray:Ray, _ intersect:Intersection) -> Bool {
        let p_o = position - ray.origin
        let b = Vector3.dot(p_o, ray.direction)
        let D4 = b * b - Vector3.dot(p_o, p_o) + radius * radius
        
        if D4 < 0.0 {
            return false
        }
        
        let sqrt_D4 = sqrt(D4)
        let t1 = b - sqrt_D4
        let t2 = b + sqrt_D4
        
        if t1 < kSweetAppleEPS && t2 < kSweetAppleEPS {
            return false
        }
        
        if t1 > kSweetAppleEPS {
            intersect.distance = t1
        } else {
            intersect.distance = t2
        }
        
        intersect.position = ray.origin + intersect.distance * ray.direction
        intersect.geometryNormal = Vector3.normalized(intersect.position - position)
        intersect.hitNormal = intersect.geometryNormal
        intersect.materialId = 0
        
        return true
    }
    
    public override func makeSamplePoint(_ rng: Random) -> Geometry.SamplePoint {
        var ret = SamplePoint()
        
        // uniform sphare sampling
        let z = 1.0 - 2.0 * rng.nextDouble()
        let r = Double.maximum(0.0, 1.0 - z * z).squareRoot()
        let phi = 2.0 * Double.pi * rng.nextDouble()
        let p = Vector3(cos(phi) * r, sin(phi) * r, z)
        
        ret.position = p * radius + position
        ret.normal = Vector3.normalized(p)
        ret.pdf = 1.0 / (4.0 * Double.pi * radius * radius)
        
        return ret
    }
    
}

