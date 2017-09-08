#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

public class Integrator {
    public var scene:Scene
    public var camera:Camera
    public var config:Renderer.Config
    
    public init(_ scn:Scene, _ cam:Camera, _ conf:Renderer.Config) {
        scene = scn
        camera = cam
        config = conf
    }
    
    public func preprocess() {
        // some preprocess like build photon map
    }
    
    public func radiance(_ firstray:Ray, _ rng:Random) -> (color:Color, depth:Int) {
        // integration process
        return (Color(rng.nextDouble(), rng.nextDouble(), rng.nextDouble()), 0)
    }
}
