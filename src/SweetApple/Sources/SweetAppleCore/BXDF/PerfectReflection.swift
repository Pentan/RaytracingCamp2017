#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class PerfectReflection: BXDF {
    
    public override func typeFlag() -> Int {
        return BXDF.kSpecular
    }
    
    public override func sample(_ inray:Ray, _ intersect:Intersection, _ rng:Random) -> Sample {
        let shdnorm = intersect.shadingNormal
        let idotn = Vector3.dot(inray.direction, shdnorm)
        let vreflect = inray.direction - shdnorm * 2.0 * idotn
        
        let smpl = Sample()
        smpl.position = intersect.position
        if idotn < 0.0 {
            smpl.normal = shdnorm
        } else {
            smpl.normal = shdnorm * -1.0
        }
        smpl.direction = vreflect;
        
        if(BXDF.isCorrectReflection(inray.direction, vreflect, intersect.geometryNormal)) {
            smpl.bxdf = 1.0 / abs(idotn)
        } else {
            smpl.bxdf = 0.0
        }
        smpl.pdf = 1.0
        
        return smpl
    }
    
    public override func evaluate(_ insident:Sample, _ outgoing:Sample) -> Double {
        let indot = Vector3.dot(insident.direction * -1.0, insident.normal)
        let outdot = Vector3.dot(outgoing.direction, outgoing.normal)
        let ndot = Vector3.dot(insident.normal, outgoing.normal)
        
        if indot * outdot < 0.0 || (1.0 - ndot) > kSweetAppleEPS {
            // another side or different normal
            return 0.0;
        }
        
        if abs(indot - outdot) < kSweetAppleEPS {
            return 1.0 / abs(outdot)
        } else {
            return 0.0
        }
    }
    
    public override func sampleProbability(_ insident:Sample, _ sample:Sample) -> Double {
        return 0.0
    }
}

