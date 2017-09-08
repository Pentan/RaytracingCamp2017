#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class Geometry {
    //
    public struct SamplePoint {
        var position = Vector3()
        var normal = Vector3()
        var pdf:Double = 0.0
    }
    
    //
    public func transfomredAABB(_ tm:Matrix4) -> AABB {
        return AABB(Vector3(), Vector3())
    }
    
    public func isIntersect(_ ray:Ray, _ isect:Intersection) -> Bool {
        return false;
    }
    
    public func makeSamplePoint(_ rng:Random) -> SamplePoint {
        return SamplePoint()
    }
    
    public func renderPreprocess() {
        // for build BVH etc ...
    }
}

