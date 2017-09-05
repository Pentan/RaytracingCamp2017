#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

// base class
public class Texture {
    
    public func sample(_ i:Intersection) -> Color {
        return Color(1.0, 0.0, 0.0)
    }
    
    public func sample(_ p:Vector3) -> Color {
        return Color(1.0, 0.0, 0.0)
    }
}

// constant color
public class ConstantColorTexture : Texture {
    private var color:Color
    
    public override init() {
        color = Color()
    }
    
    public init(_ r:Double, _ g:Double, _ b:Double) {
        self.color = Color(r, g, b)
    }
    
    public init(_ col:Color) {
        self.color = col.copy()
    }
    
    //
    public override func sample(_ i:Intersection) -> Color {
        return color
    }
    
    public override func sample(_ p:Vector3) -> Color {
        return color
    }
    
    //
    public func setColor(_ r:Double, _ g:Double, _ b:Double) {
        self.color.set(r, g, b)
    }
    
    public func setColor(_ col:Color) {
        self.color = col.copy()
    }
}
