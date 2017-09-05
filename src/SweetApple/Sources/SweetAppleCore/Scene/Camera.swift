#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class Camera : SceneNode {
    
    public class Aperture {
        // pinhole
        public func sample(_ rng:Random) -> (u:Double, v:Double) {
            return (0.0, 0.0)
        }
    }
    
    public class RadialApertuer : Aperture {
        public override func sample(_ rng:Random) -> (u:Double, v:Double) {
            let r = rng.nextDouble11().squareRoot()
            let theta = rng.nextDouble11() * 2.0 * Double.pi
            return (r * cos(theta), r * sin(theta))
        }
    }
    
    //
    private var inverseTransform:Matrix4 = Matrix4()
    
    public var focalLength:Double      = 28.0   // [mm]
    public var fNumber:Double          = 0.0	// [focal length / diameter of entrance pupil]
    public var sensorWidth:Double      = 36.0	// [mm]
    public var sensorHeight:Double     = 24.0	// [mm]
    public var focusDistance:Double    = 1.0	// [m]
    
    public var apertuer:Aperture
    
    //
    public override init() {
        apertuer = RadialApertuer()
    }
    
    public func setLookat(_ eye:Vector3, _ look:Vector3, _ up:Vector3) {
        inverseTransform = Matrix4.makeLookAt(eye, look, up)
        _ = inverseTransform.invert()
    }
    
    public func setTransform(_ transmat:Matrix4) {
        inverseTransform = Matrix4.inverted(transmat).result
    }
    
    public func setSensorSize(_ w:Double, _ h:Double) {
        sensorWidth = w
        sensorHeight = h
    }
    
    public func setSensorWidthWithAspect(_ w:Double, _ aspect:Double) {
        sensorWidth = w
        sensorHeight = w / aspect
    }
    
    public func sensorAspectRatio() -> Double {
        return sensorWidth / sensorHeight
    }
    
    public func makeRay(_ tx:Double, _ ty:Double, _ rng:Random) -> Ray {
        var eyep = Vector3()
        var dir = Vector3()
        
        // calc image plane position
        var ip = Vector3()
        ip.x = sensorWidth * 0.5 * tx * focusDistance / focalLength;
        ip.y = sensorHeight * 0.5 * ty * focusDistance / focalLength;
        ip.z = -focusDistance;
        
        if(fNumber > 0.0) {
            // thin lens
            let apertuerR = focalLength / fNumber * 0.0005 // 1/1000*0.5[m]
            let apertuerSample = apertuer.sample(rng)
            
            eyep.set(apertuerSample.u * apertuerR, apertuerSample.v * apertuerR, 0.0)
            dir = ip - eyep
            _ = dir.normalize()
        } else {
            // pinhole
            eyep.set(0.0, 0.0, 0.0)
            dir = Vector3.normalized(ip)
        }
        
        eyep = Matrix4.transformV3(inverseTransform, eyep)
        dir = Matrix4.mulV3(inverseTransform, dir)
        
        return Ray(eyep, dir, BXDF.kSensor)
    }
}

