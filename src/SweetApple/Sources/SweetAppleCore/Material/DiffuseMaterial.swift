#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class DiffuseMaterial: Material {
    private let bsdf = Lambert()
    
    private var emittanceTexId:Int = -1
    private var diffuseTexId:Int = -1
    
    public override init() {
        super.init()
        diffuseTexId = registerTextue(ConstantColorTexture(1.0, 1.0, 0.0))
        emittanceTexId = registerTextue(ConstantColorTexture(1.0, 0.0, 0.0))
    }
    
    public init(_ diffuse:Color, _ emit:Color = Color()) {
        super.init()
        diffuseTexId = registerTextue(ConstantColorTexture(diffuse))
        emittanceTexId = registerTextue(ConstantColorTexture(emit))
    }
    
    public override func emittance(_ intersect:Intersection) -> Color {
        let tex = textures[emittanceTexId]
        return tex.sample(intersect)
    }
    
    
}
