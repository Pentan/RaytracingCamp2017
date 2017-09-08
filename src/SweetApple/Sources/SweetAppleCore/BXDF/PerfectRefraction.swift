#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class PerfectRefraction: BXDF {
    
    public var indexOfRefraction:Double = 1.5
    
    public init(ior:Double = 1.5) {
        super.init()
        indexOfRefraction = ior
    }
    
    public override func typeFlag() -> Int {
        return BXDF.kRefraction
    }
    
    public override func sample(_ inray:Ray, _ intersect:Intersection, _ rng:Random) -> Sample {
        let smpl = Sample()
        
        let shdnorm = intersect.shadingNormal
        let idotn = Vector3.dot(inray.direction, shdnorm)
        let reflect_dir = inray.direction - shdnorm * 2.0 * idotn
        let isInto = idotn < 0.0
        let abs_normal:Vector3
        if isInto {
            abs_normal = shdnorm
            smpl.flag |= BXDF.kFlagInto
        } else {
            abs_normal = shdnorm * -1.0
        }
        
        // Snell's law
        let n1n2:Double
        if isInto {
            n1n2 = 1.0 / indexOfRefraction
        } else {
            n1n2 = indexOfRefraction / 1.0
        }
        let cos2t = 1.0 - n1n2 * n1n2 * (1.0 - idotn * idotn) // power of 2 makes sign of idotn is don't care.
        
        // full reflection part
        if(cos2t < 0.0) {
            smpl.position = intersect.position
            smpl.normal = abs_normal
            smpl.direction = reflect_dir
            smpl.bxdf = 1.0
            smpl.pdf = abs(idotn)
            smpl.flag |= BXDF.kFlagReflected
            return smpl;
        }
        
        // refraction part
        let refract_dir = Vector3.normalized(inray.direction * n1n2 - abs_normal * (-1.0 * abs(idotn) * n1n2 + cos2t.squareRoot()))
        
        smpl.position = intersect.position;
        smpl.normal = abs_normal * -1.0
        smpl.direction = refract_dir
        smpl.bxdf = n1n2 * n1n2 / abs(Vector3.dot(smpl.normal, smpl.direction))
        smpl.pdf = 1.0
        
        return smpl
    }
    
    public override func evaluate(_ insident:Sample, _ outgoing:Sample) -> Double {
        // FIXME!
        assertionFailure()
        return 1.0 / abs(Vector3.dot(outgoing.normal, outgoing.direction))
    }
    
    public override func sampleProbability(_ insident:Sample, _ sample:Sample) -> Double {
        // FIXME!
        assertionFailure()
        return 1.0
    }
}

