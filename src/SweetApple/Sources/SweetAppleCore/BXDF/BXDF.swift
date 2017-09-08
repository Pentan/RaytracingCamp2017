#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class BXDF {
    // kinds
    public static let kUnknown:Int      = -1
    public static let kSensor:Int       = 0
    public static let kDiffuse:Int      = 1
    public static let kSpecular:Int     = 2
    public static let kGlossy:Int       = 4
    public static let kRefraction:Int   = 8
    public static let kTransmit:Int     = 16
    
    // flags
    public static let kFlagInto:Int         = 1
    public static let kFlagReflected:Int    = 1 << 1
    
    //
    public class Sample {
        public var position:Vector3 = Vector3()
        public var direction:Vector3 = Vector3()
        public var normal:Vector3 = Vector3()
        public var bxdf:Double = 0.0
        public var pdf:Double = 1.0
        public var flag:Int = 0
        
        public func makeRay(_ wbias:Color = Color(1.0, 1.0, 1.0)) -> Ray {
            let offsetpos:Vector3
            let ndotd = Vector3.dot(normal, direction)
            if ndotd > 0 {
                offsetpos = position + normal * kSweetAppleRayOffet
            } else {
                offsetpos = position - normal * kSweetAppleRayOffet
            }
            
            let w = bxdf / pdf * abs(ndotd) * wbias
            let ray = Ray(offsetpos, direction, w)
            
            return ray
        }
    }
    
    //
    // correct  incorrect
    // vi->|    vi->|
    //   <-|ng    <-|ng
    // vo<-|        |->vo
    static public func isCorrectReflection(_ vi:Vector3, _ vo:Vector3, _ gn:Vector3) -> Bool {
        return Vector3.dot(vi, gn) * Vector3.dot(vo, gn) <= 0.0
    }
    
    //
    public func typeFlag() -> Int {
        return kUnknownType
    }
    
    public func sample(_ inray:Ray, _ intersect:Intersection, _ rng:Random) -> Sample {
        return Sample()
    }
    
    // vector direction
    // insident ->|
    // outgoing <-|
    public func evaluate(_ insident:Sample, _ outgoing:Sample) -> Double {
        return 0.0
    }
    
    public func sampleProbability(_ insident:Sample, _ sample:Sample) -> Double {
        return 0.0
    }
    
}

