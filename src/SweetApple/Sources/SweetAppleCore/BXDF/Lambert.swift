#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class Lambert: BXDF {
    
    public override func typeFlag() -> Int {
        return BXDF.kDiffuse
    }
    
    public override func sample(_ inray:Ray, _ intersect:Intersection, _ rng:Random) -> Sample {
        let ret = Sample()
        
        let r1 = 2.0 * Double.pi * rng.nextDouble01()
        let r2 = rng.nextDouble01()
        let r2s = r2.squareRoot()
        
        var dir = Vector3(cos(r1) * r2s, sin(r1) * r2s, (1.0 - r2).squareRoot())
        
        let ndotd = dir.z // dir.z == dot(normal, direction)
        
        dir = Matrix4.mulV3(intersect.shadingInverseTangentSpace, dir)
        
        var norm = intersect.shadingNormal
        if Vector3.dot(inray.direction, norm) >= 0.0 {
            // from back
            dir = dir * -1.0
            norm = norm * -1.0
        }
        ret.position = intersect.position
        ret.direction = dir
        ret.normal = norm
        if(BXDF.isCorrectReflection(inray.direction, dir, intersect.geometryNormal)) {
            ret.bxdf = 1.0 / Double.pi
        } else {
            ret.bxdf = 0.0
        }
        ret.pdf = ndotd / Double.pi
        
        return ret
    }
    
    public override func evaluate(_ insident:Sample, _ outgoing:Sample) -> Double {
        let ndot = Vector3.dot(insident.normal, outgoing.normal)
        if 1.0 - ndot > kSweetAppleEPS {
            // different normal
            assertionFailure("different normal")
            return 0.0
        }
        
        let idot = Vector3.dot(insident.direction, insident.normal)
        let odot = Vector3.dot(outgoing.direction, outgoing.normal)
        if idot * odot < 0.0 {
            return 1.0 / Double.pi
        } else {
            return 0.0
        }
    }
    
    public override func sampleProbability(_ insident:Sample, _ sample:Sample) -> Double {
        return Vector3.dot(sample.direction, sample.normal) / Double.pi
    }
}

