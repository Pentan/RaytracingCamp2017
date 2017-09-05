#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class Intersection {
    
    static let kNoneId:Int = -1
    
    public var distance:Double
    public var position:Vector3
    
    public var hitNormal:Vector3
    public var geometryNormal:Vector3
    public var tangent:Vector3
    
    public var varyingWeight:Vector3
    
    public var faceId:Int
    public var objectId:Int
    public var materialId:Int
    
    public init() {
        distance = kSweetAppleINF
        position = Vector3()
        
        hitNormal = Vector3()
        geometryNormal = Vector3()
        tangent = Vector3()
        
        varyingWeight = Vector3()
        
        faceId = Intersection.kNoneId
        objectId = Intersection.kNoneId
        materialId = Intersection.kNoneId
    }
    
    public func clear() {
        distance = kSweetAppleINF
        faceId = Intersection.kNoneId
        objectId = Intersection.kNoneId
    }
}
