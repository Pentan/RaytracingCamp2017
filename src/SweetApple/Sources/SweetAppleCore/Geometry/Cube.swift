#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class Cube : Geometry {
    public var aabb:AABB
    
    public override init() {
        aabb = AABB(Vector3(-1.0, -1.0, -1.0), Vector3(1.0, 1.0, 1.0))
    }
    
    public init(position:Vector3, size:Vector3) {
        let minp = position - size * 0.5
        let maxp = position + size * 0.5
        aabb = AABB(minp, maxp)
    }
    
    public override func transfomredAABB(_ tm:Matrix4) -> AABB {
        // oriented AABB
        let vertices:[Vector3] = [
            Vector3(aabb.min.x, aabb.min.y, aabb.min.z),
            Vector3(aabb.min.x, aabb.min.y, aabb.max.z),
            Vector3(aabb.min.x, aabb.max.y, aabb.min.z),
            Vector3(aabb.min.x, aabb.max.y, aabb.max.z),
            Vector3(aabb.max.x, aabb.min.y, aabb.min.z),
            Vector3(aabb.max.x, aabb.min.y, aabb.max.z),
            Vector3(aabb.max.x, aabb.max.y, aabb.min.z),
            Vector3(aabb.max.x, aabb.max.y, aabb.max.z)
        ]
        let ret = AABB()
        for v in vertices {
            ret.expand(Matrix4.transformV3(tm, v))
        }
        return ret
    }
    
    public override func isIntersect(_ ray:Ray, _ intersect:Intersection) -> Bool {
        let (ishit, distance, axisid) = aabb.isIntersect(ray)
        
        if !ishit {
            return false
        }
        
        let compid = Vector3.Component.init(rawValue: axisid)!
        
        intersect.position = ray.origin + ray.direction * distance
        intersect.geometryNormal.set(0.0, 0.0, 0.0)
        if ray.direction.componentValue(compid) < 0.0 {
            intersect.geometryNormal.setComponentValue(compid, 1.0)
        } else {
            intersect.geometryNormal.setComponentValue(compid, -1.0)
        }
        intersect.hitNormal = intersect.geometryNormal
        intersect.materialId = 0
        
        return true
    }
    
    public override func makeSamplePoint(_ rng:Random) -> SamplePoint {
        assertionFailure("Cube.makeSamplePoint")
        return SamplePoint()
    }
}

