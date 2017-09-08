#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

public class Scene {
    internal var allNodes:[SceneNode] = []
    internal var cameras:[Camera] = []
    internal var lights:[Light] = []
    internal var objects:[Object] = []
    
    internal var objectBVH:BVH = BVH()
    
    public var skyMaterial:SkyMaterial? = nil
    
    public init() {
    }
    
    public func registerCamera(_ camera:Camera) -> Int {
        let camid = cameras.count
        cameras.append(camera)
        return camid
    }
    
    public func getCamera(_ i:Int) -> Camera {
        return cameras[i]
    }
    
    public func registerObject(_ obj:Object) -> Int {
        obj.objectId = objects.count
        objects.append(obj)
        return obj.objectId
    }
    
    public func getObject(_ i:Int) -> Object {
        return objects[i]
    }
    
    public func renderPreprocess() {
        // objects preprocess
        // build object BVH
        // etc...
        let aabblist:[AABB] = objects.map { obj -> AABB in
            return obj.boundsAABB()
        }
        objectBVH.buildTree(aabblist)
    }
    
    public func intersect(_ ray:Ray, _ intersect:Intersection) -> Bool {
        intersect.clear()
        
        // BVH
        _ = objectBVH.intersect(ray, intersect) { (objid, ray, intersect) -> Bool in
            if self.objects[objid].isIntersect(ray, intersect) {
                intersect.objectId = objid
                return true
            }
            return false
        }
        /*
        // bruteforce
        let tmpisect = Intersection()
        for obj in objects {
            tmpisect.clear()
            
            if obj.isIntersect(ray, tmpisect) {
                if tmpisect.distance < intersect.distance {
                    intersect.clone(tmpisect)
                    intersect.objectId = obj.objectId
                }
            }
        }
        */
        
        return intersect.objectId != Intersection.kNoneId
    }
    
}
