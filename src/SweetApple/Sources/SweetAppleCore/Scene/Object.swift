#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class Object : SceneNode {
    
    public var name:String = "unnamed object"
    public var objectId:Int = 0
    
    var geometry:Geometry
    var materials:[Material] = []
    var lightMaterialCount:Int = 0
    
    var transform = Matrix4()
    var iTransform = Matrix4()
    var itTransform = Matrix4()
    
    
    // initialize
    public init(_ geom:Geometry) {
        self.geometry = geom
    }
    
    public init(_ geom:Geometry, _ mat:Material) {
        self.geometry = geom
        self.materials.append(mat)
    }
    
    // material
    public func registerMaterial(_ mat:Material) -> Int {
        materials.append(mat)
        if mat.isLight() {
            lightMaterialCount += 1
        }
        return materials.count - 1
    }
    
    public func materialCount() -> Int {
        return materials.count
    }
    
    public func getMaterialById(_ i:Int) -> Material {
        return materials[i]
    }
    
    public func replaceMaterial(_ i:Int, _ mat:Material) {
        if materials[i].isLight() {
            lightMaterialCount -= 1
        }
        if mat.isLight() {
            lightMaterialCount += 1
        }
        materials[i] = mat
    }
    
    // transform
    public func setTransform(_ m:Matrix4) {
        transform = m
        iTransform = Matrix4.inverted(m).result
        itTransform = Matrix4.transposed(iTransform)
    }
    
    public func transformMatrix() -> Matrix4 {
        return transform
    }
    
    public func toLocalPosition(_ wp:Vector3) -> Vector3 {
        return Matrix4.transformV3(iTransform, wp)
    }
    public func toWorldNormal(_ ln:Vector3) -> Vector3 {
        return Matrix4.transformV3(itTransform, ln)
    }
    
    public func boundsAABB() -> AABB {
        let aabb = geometry.transfomredAABB(transform)
        aabb.dataId = objectId
        return aabb
    }
    
    //
    public func isIntersect(_ ray:Ray, _ intersect:Intersection) -> Bool {
        let tray = Ray.makeTransformed(ray, iTransform)
        
        if geometry.isIntersect(tray, intersect) {
            // fix transform
            // position
            intersect.position = Matrix4.transformV3(transform, intersect.position)
            // normal
            intersect.hitNormal = Matrix4.mulV3(itTransform, intersect.hitNormal)
            _ = intersect.hitNormal.normalize()
            intersect.geometryNormal = Matrix4.mulV3(itTransform, intersect.geometryNormal)
            _ = intersect.geometryNormal.normalize()
            // calc distance
            intersect.distance = Vector3.distance(ray.origin, intersect.position)
            return true
        }
        return false;
    }
    
    public func getSamplePoint(_ rng:Random) -> Geometry.SamplePoint {
        var sp = geometry.makeSamplePoint(rng)
        // transform to world space
        sp.position = Matrix4.transformV3(transform, sp.position)
        sp.normal = Vector3.normalized(Matrix4.mulV3(itTransform, sp.normal))
        return sp;
    }
    
    public func isLight() -> Bool {
        return lightMaterialCount > 0
    }
}

