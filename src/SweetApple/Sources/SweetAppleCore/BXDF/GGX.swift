#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class GGX:BXDF {
    
    public var roughness:Double = 0.5
    public var fresnelIOR:Double = 1.5
    
    public init(_ rough:Double, _ fresnel:Double) {
        super.init()
        roughness = rough
        fresnelIOR = fresnel
    }
    
    //
    public override func typeFlag() -> Int {
        return BXDF.kGlossy
    }
    
    public override func sample(_ inray:Ray, _ intersect:Intersection, _ rng:Random) -> Sample {
        return sample(inray, intersect, rng, roughness, fresnelIOR)
    }
    
    public func sample(_ inray:Ray, _ intersect:Intersection, _ rng:Random, _ rough:Double, _ ior:Double) -> Sample {
        // importance sampling
        let ret = Sample()
        
        var ag = rough * rough
        if ag < GGX.kMinAlphaG { // hack
            ag = GGX.kMinAlphaG;
        }
        
        // generate micro normal (= half vector)
        let r1 = rng.nextDouble01()
        let r2 = rng.nextDouble01()
        
        let theta = atan(ag * (r1 / (1.0 - r1)).squareRoot())
        let phi = 2.0 * Double.pi * r2
        
        let sintheta = sin(theta)
        var hv = Vector3(cos(phi) * sintheta, sin(phi) * sintheta, cos(theta))
        
        hv = Matrix4.mulV3(intersect.shadingInverseTangentSpace, hv);
        
        var norm = intersect.shadingNormal
        if Vector3.dot(inray.direction, norm) >= 0.0 {
            // from back
            hv = hv * -1.0
            norm = norm * -1.0
        }
        
        let iv = inray.direction * -1.0
        let ov = Vector3.dot(iv, hv) * hv * 2.0 - iv
        
        ret.position = intersect.position
        ret.direction = ov
        ret.normal = norm
        
        if(BXDF.isCorrectReflection(inray.direction, ov, intersect.geometryNormal)) {
            // evaluate
            let idotn = Vector3.dot(iv, norm)
            let odotn = Vector3.dot(ov, norm)
            let hdotn = Vector3.dot(hv, norm)
            
            let Fih = F(iv, hv, ior)
            let Gim = G(iv, hv, norm, ag)
            let Gom = G(ov, hv, norm, ag)
            let Dm = D(hv, norm, ag)
            let A = (4.0 * abs(idotn * odotn))
            
            ret.bxdf = Fih * (Gim * Gom) * Dm / A
            
            let hjacobian = 1.0 / (4.0 * abs(Vector3.dot(ov, hv)))
            ret.pdf = D(hv, norm, ag) * abs(hdotn) * hjacobian
            
        } else {
            ret.bxdf = 0.0;
            ret.pdf = 1.0;
        }
        
        return ret;
    }
    
    public override func evaluate(_ insident:Sample, _ outgoing:Sample) -> Double {
        assertionFailure()
        return 0.0
    }
    
    public override func sampleProbability(_ insident:Sample, _ sample:Sample) -> Double {
        assertionFailure()
        return Vector3.dot(sample.direction, sample.normal) / Double.pi
    }
    
    //
    static let kMinAlphaG:Double = 1e-4
    
    func Xt(_ x:Double) -> Double {
        if x > 0.0 {
            return 1.0
        } else {
            return 0.0
        }
    }
    
    func F(_ i:Vector3, _ n:Vector3, _ ior:Double) -> Double {
        let nsubn = 1.0 - ior
        let naddn = 1.0 + ior
        let F0 = (nsubn * nsubn) / (naddn * naddn)
        let idotn = Vector3.dot(i, n)
        return F0 + (1.0 - F0) * pow((1.0 - idotn), 5.0)
    }
    
    func G(_ v:Vector3, _ m:Vector3, _ n:Vector3, _ ag:Double) -> Double {
        let vdotn = Vector3.dot(v, n)
        let vdotm = Vector3.dot(v, m);
        let tv2 = (1.0 - vdotn * vdotn) / (vdotn * vdotn)
        let sqrt1a2t2 = (1.0 + ag * ag * tv2).squareRoot()
        return Xt(vdotm / vdotn) * (2.0 / (1.0 + sqrt1a2t2))
    }
    
    func D(_ m:Vector3, _ n:Vector3, _ ag:Double) -> Double {
        let mdotn = Vector3.dot(m, n)
        let a2X = ag * ag * Xt(mdotn)
        let a2c2s2 = (ag * ag) * (mdotn * mdotn) + (1.0 - mdotn * mdotn)
        return a2X / (Double.pi * pow(a2c2s2, 2.0))
    }
    
}

