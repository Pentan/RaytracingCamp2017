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
    
    public func clone(_ src:Intersection) {
        distance = src.distance
        position = src.position
        
        hitNormal = src.hitNormal
        geometryNormal = src.geometryNormal
        tangent = src.tangent
        
        varyingWeight = src.varyingWeight
        
        faceId = src.faceId
        objectId = src.objectId
        materialId = src.materialId
    }
    
    /////
    internal class ShadingSpace {
        var shadingNormal = Vector3()
        var shadingTangentSpace = Matrix4()
        var shadingInverseTangentSpace = Matrix4()
    }
    
    internal var shadingSpace:ShadingSpace? = nil
    
    public var shadingNormal:Vector3 {
        get {
            return shadingSpace?.shadingNormal ?? Vector3(0.0, 0.0, 0.0)
        }
        set {
            if shadingSpace == nil {
                shadingSpace = ShadingSpace()
            }
            shadingSpace?.shadingNormal = newValue
            updateShadingSpace()
        }
    }
    
    public var shadingTangentSpace:Matrix4 {
        return shadingSpace?.shadingTangentSpace ?? Matrix4()
    }
    
    public var shadingInverseTangentSpace:Matrix4 {
        return shadingSpace?.shadingInverseTangentSpace ?? Matrix4()
    }
    
    internal func updateShadingSpace() {
        if let shdspc = shadingSpace {
            
            // compute tangent space
            if(tangent.isZero(kSweetAppleEPS)) {
                // tangent is not defined. generate it from hitNormal
                tangent = Vector3.cross(Vector3(0.0, 0.0, 1.0), hitNormal)
                if(!tangent.normalize()) {
                    tangent.set(1.0, 0.0, 0.0);
                }
            }
            
            let basisz = shdspc.shadingNormal
            let basisy = Vector3.normalized(Vector3.cross(basisz, tangent))
            let basisx = Vector3.normalized(Vector3.cross(basisz, basisy))
            
            shdspc.shadingTangentSpace.setBasis(basisx, basisy, basisz)
            shdspc.shadingInverseTangentSpace = Matrix4.transposed(shdspc.shadingTangentSpace)
        }
    }
}
