#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class Material {
    internal var textures:[Texture] = []
    
    public init() {
    }
    
    public func registerTextue(_ tex:Texture) -> Int {
        let ret = textures.count
        textures.append(tex)
        return ret
    }
    
    public func emittance(_ intersect:Intersection) -> Color {
        return Color(0.0, 0.0, 0.0)
    }
    
    public func isLight() -> Bool {
        return false
    }
    
    public func shadingNormal(_ intersect:Intersection) -> Vector3 {
        return intersect.hitNormal
    }
    
    public func terminationProbability(_ intersect:Intersection) -> Double {
        assertionFailure("Material.terminationProbability")
        return 0.0
    }
    
    public func nextSampleRays(_ inray:Ray, _ intersect:Intersection, _ rng:Random, _ depth:Int, _ outrays:inout [Ray]) {
        assertionFailure("Material.nextSampleRays")
    }
}
