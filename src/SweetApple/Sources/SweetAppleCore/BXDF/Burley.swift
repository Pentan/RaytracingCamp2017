#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class Burley: BXDF {
    
    public var roughness:Double = 0.0
    
    public init(_ r:Double) {
        super.init()
        roughness = r
    }
    
    public override func typeFlag() -> Int {
        return BXDF.kDiffuse
    }
    
    public override func sample(_ inray:Ray, _ intersect:Intersection, _ rng:Random) -> Sample {
        return sample(inray, intersect, rng, roughness)
    }
    
    public func sample(_ inray:Ray, _ intersect:Intersection, _ rng:Random, _ rough:Double) -> Sample {
        // importance sampling using cosine distoribution.
        let ret = Sample()
        
        let r1 = 2.0 * Double.pi * rng.nextDouble01()
        let r2 = rng.nextDouble01()
        let r2s = r2.squareRoot()
        
        var dir = Vector3(cos(r1) * r2s, sin(r1) * r2s, (1.0 - r2).squareRoot())
        
        let ndotd = dir.z; // dir.z == dot(normal, direction)
        
        dir = Matrix4.mulV3(intersect.shadingInverseTangentSpace, dir)
        
        var norm = intersect.shadingNormal
        if(Vector3.dot(inray.direction, norm) >= 0.0) {
            // from back
            dir = dir * -1.0
            norm = norm * -1.0
        }
        ret.position = intersect.position
        ret.direction = dir
        ret.normal = norm
        
        if BXDF.isCorrectReflection(inray.direction, dir, intersect.geometryNormal) {
            let vi = inray.direction * -1.0
            let vl = dir
            let vh = Vector3.normalized((vi + vl) * 0.5)
            
            let costl = Vector3.dot(norm, vl)
            let costv = Vector3.dot(norm, vi)
            let costd = Vector3.dot(vh, vl)
            
            let FD90 = 0.5 + 2.0 * costd * costd * rough
            let L = 1.0 + (FD90 - 1.0) * pow(1.0 - costl, 5.0)
            let V = 1.0 + (FD90 - 1.0) * pow(1.0 - costv, 5.0)
            
            ret.bxdf = L * V / Double.pi
            
        } else {
            ret.bxdf = 0.0;
        }
        ret.pdf = ndotd / Double.pi
        
        return ret;
    }
    
    public override func evaluate(_ insident:Sample, _ outgoing:Sample) -> Double {
        // FIXME
        assertionFailure()
        return 0.0
    }
    
    public override func sampleProbability(_ insident:Sample, _ sample:Sample) -> Double {
        return Vector3.dot(sample.direction, sample.normal) / Double.pi
    }
}

