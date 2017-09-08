#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class PerfectSpecularMaterial: Material {
    private var bxdf:BXDF = PerfectReflection()
    
    private var emittanceTexId:Int = -1
    private var diffuseTexId:Int = -1
    
    public override init() {
        super.init()
        diffuseTexId = registerTextue(ConstantColorTexture(0.0, 1.0, 1.0))
        emittanceTexId = registerTextue(ConstantColorTexture(1.0, 0.0, 0.0))
    }
    
    public init(reflect:Color, emit:Color = Color(), roughness:Double = 0.0, fresnel:Double = 1.5) {
        super.init()
        diffuseTexId = registerTextue(ConstantColorTexture(reflect))
        emittanceTexId = registerTextue(ConstantColorTexture(emit))
        
        if roughness > 0.0 {
            bxdf = GGX(roughness, fresnel)
        }
    }
    
    public override func emittance(_ intersect:Intersection) -> Color {
        let tex = textures[emittanceTexId]
        return tex.sample(intersect)
    }
    
    
    public override func terminationProbability(_ intersect:Intersection) -> Double {
        let tex = textures[diffuseTexId]
        return abs(tex.sample(intersect).maxMagnitude())
    }
    
    public override func nextSampleRays(_ inray:Ray, _ intersect:Intersection, _ rng:Random, _ depth:Int, _ outrays:inout [Ray]) {
        let tex = textures[diffuseTexId]
        let reflectance = tex.sample(intersect)
        
        let smpl = bxdf.sample(inray, intersect, rng)
        let oray = smpl.makeRay(reflectance)
        oray.fromBXDF = bxdf.typeFlag()
        
        outrays.append(oray)
    }

}

