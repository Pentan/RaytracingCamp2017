#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

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
    
}
