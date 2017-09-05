#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

public class Scene {
    public var allNodes:[SceneNode] = []
    public var cameras:[Camera] = []
    public var lights:[Light] = []
    public var objects:[Object] = []
    
    public var visibleBVH:Any? = nil
    
    public init() {
    }
    
    public func registerCamera(_ camera:Camera) {
        cameras.append(camera)
    }
    
    public func registerObject(_ obj:Object) {
        objects.append(obj)
    }
    
    public func renderPreprocess() {
        // objects preprocess
        // build object BVH
        // etc...
    }
    
}
