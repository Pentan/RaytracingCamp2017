#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class PerfectGlassMaterial: Material {
    
    private var reflectionBXDF = PerfectReflection()
    private var refractionBXDF = PerfectRefraction(ior:1.5)
    
    private var emittanceTexId:Int = -1
    private var reflectanceTexId:Int = -1
    private var transmittanceTexId:Int = -1
    
    public var indexOfRefraction:Double {
        get {
            return refractionBXDF.indexOfRefraction
        }
        set {
            refractionBXDF.indexOfRefraction = newValue
        }
    }
    
    public override init() {
        super.init()
        emittanceTexId = registerTextue(ConstantColorTexture(1.0, 0.0, 0.0))
        reflectanceTexId = registerTextue(ConstantColorTexture(0.0, 1.0, 0.0))
        transmittanceTexId = registerTextue(ConstantColorTexture(0.0, 0.0, 1.0))
    }
    
    public init(reflect:Color, transmit:Color, emit:Color = Color()) {
        super.init()
        emittanceTexId = registerTextue(ConstantColorTexture(emit))
        reflectanceTexId = registerTextue(ConstantColorTexture(reflect))
        transmittanceTexId = registerTextue(ConstantColorTexture(transmit))
    }
    
    public override func emittance(_ intersect:Intersection) -> Color {
        let tex = textures[emittanceTexId]
        return tex.sample(intersect)
    }
    
    public override func terminationProbability(_ intersect:Intersection) -> Double {
        let reftex = textures[reflectanceTexId]
        let refmax = abs(reftex.sample(intersect).maxMagnitude())
        
        let trtex = textures[transmittanceTexId]
        let trfmax = abs(trtex.sample(intersect).maxMagnitude())
        
        return Double.maximum(refmax, trfmax)
    }
    
    public override func nextSampleRays(_ inray:Ray, _ intersect:Intersection, _ rng:Random, _ depth:Int, _ outrays:inout [Ray]) {
        // Fresnel reflection (Schlick's approximation)
        let reftex = textures[reflectanceTexId]
        let trtex = textures[transmittanceTexId]
        let reflectance = reftex.sample(intersect)
        let transmittance = trtex.sample(intersect)
        
        let tr_smpl = refractionBXDF.sample(inray, intersect, rng)
        
        // full reflection case
        if (tr_smpl.flag & BXDF.kFlagReflected) != 0 {
            let tmpray = tr_smpl.makeRay(reflectance)
            tmpray.fromBXDF = BXDF.kSpecular
            outrays.append(tmpray)
            return
        }
        
        // transmit
        let ref_smpl = reflectionBXDF.sample(inray, intersect, rng)
        
        let ior = refractionBXDF.indexOfRefraction
        let nsubn = 1.0 - ior
        let naddn = 1.0 + ior
        let F0 = (nsubn * nsubn) / (naddn * naddn)
        
        let rdotn:Double
        if (tr_smpl.flag & BXDF.kFlagInto) == 0 && ior < 1.0 {
            // use outgoing angle
            rdotn = Vector3.dot(tr_smpl.direction, tr_smpl.normal)
        } else {
            // use insident angle
            rdotn = Vector3.dot(inray.direction, intersect.shadingNormal);
        }
        let Re = F0 + (1.0 - F0) * pow(1.0 - abs(rdotn), 5.0)
        let Tr = 1.0 - Re
        
        if(depth > 1) {
            // trace one
            let prob = 0.25 + 0.5 * Re
            if rng.nextDouble01() < prob {
                // reflect
                let tmpray = ref_smpl.makeRay(reflectance * (Re / prob))
                tmpray.fromBXDF = BXDF.kSpecular
                outrays.append(tmpray)
            } else {
                // transmit
                let tmpray = tr_smpl.makeRay(transmittance * (Tr / ( 1.0 - prob)))
                tmpray.fromBXDF = BXDF.kRefraction
                outrays.append(tmpray)
            }
        } else {
            // trace both
            var tmpray:Ray
            tmpray = ref_smpl.makeRay(reflectance * Re)
            tmpray.fromBXDF = BXDF.kSpecular
            outrays.append(tmpray)
            
            tmpray = tr_smpl.makeRay(transmittance * Tr)
            tmpray.fromBXDF = BXDF.kRefraction
            outrays.append(tmpray)
        }
    }
}
