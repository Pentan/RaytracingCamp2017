#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra


public class AABB {
    public var min:Vector3
    public var max:Vector3
    public var centroid:Vector3
    public var dataId:Int
    
    public init() {
        let greatest = Double.greatestFiniteMagnitude
        min = Vector3(greatest, greatest, greatest)
        max = Vector3(-greatest, -greatest, -greatest)
        centroid = Vector3(0.0, 0.0, 0.0)
        dataId = 0
    }
    
    public init(_ minv:Vector3, _ maxv:Vector3) {
        min = minv.copy()
        max = maxv.copy()
        
        if(min.x > max.x) {
            swap(&min.x, &max.x)
        }
        if(min.y > max.y) {
            swap(&min.y, &max.y)
        }
        if(min.z > max.z) {
            swap(&min.z, &max.z)
        }
        
        centroid = (max + min) * 0.5
        dataId = 0
    }
    
    public func clear() {
        let greatest = Double.greatestFiniteMagnitude
        min.set(greatest, greatest, greatest)
        max.set(-greatest, -greatest, -greatest)
        centroid.set(0.0, 0.0, 0.0)
        dataId = 0
    }
    
    public func size() -> Vector3 {
        return max - min
    }
    
    public func expand(_ p:Vector3) {
        if(p.x < min.x) { min.x = p.x }
        if(p.y < min.y) { min.y = p.y }
        if(p.z < min.z) { min.z = p.z }
        
        if(p.x > max.x) { max.x = p.x }
        if(p.y > max.y) { max.y = p.y }
        if(p.z > max.z) { max.z = p.z }
        
        centroid = (min + max) * 0.5
    }
    
    public func expand(_ aabb:AABB) {
        if(aabb.min.x < min.x) { min.x = aabb.min.x }
        if(aabb.min.y < min.y) { min.y = aabb.min.y }
        if(aabb.min.z < min.z) { min.z = aabb.min.z }
        
        if(aabb.max.x > max.x) { max.x = aabb.max.x }
        if(aabb.max.y > max.y) { max.y = aabb.max.y }
        if(aabb.max.z > max.z) { max.z = aabb.max.z }
        
        centroid = (min + max) * 0.5
    }
    
    public func updateCentroid() {
        centroid = (min + max) * 0.5
    }
    
    public func isInside(_ p:Vector3) -> Bool {
        return ((p.x > min.x && p.y > min.y && p.z > min.z) && (p.x < max.x && p.y < max.y && p.z < max.z))
    }
    
    public func isIntersect(_ ray:Ray) -> (result:Bool, min:Double, axis:Int) {
        var tmin:Double = -Double.greatestFiniteMagnitude
        var tmax:Double = Double.greatestFiniteMagnitude
        var tmpmin:Double
        var tmpmax:Double
        var minaxis:Int = 0
        
        for i in 0..<3 {
            let comp = Vector3.Component.init(rawValue: i)!
            let dircomp = ray.direction.componentValue(comp)
            
            if(abs(dircomp) < kLamEPS) {
                let op = ray.origin.componentValue(comp)
                let minp = min.componentValue(comp)
                let maxp = max.componentValue(comp)
                if op < minp || op > maxp {
                    return (false, Double.greatestFiniteMagnitude, -1)
                }
                continue
            }
            
            let vdiv = 1.0 / dircomp
            if(dircomp >= 0.0) {
                tmpmin = (min.componentValue(comp) - ray.origin.componentValue(comp)) * vdiv
                tmpmax = (max.componentValue(comp) - ray.origin.componentValue(comp)) * vdiv
            } else {
                tmpmax = (min.componentValue(comp) - ray.origin.componentValue(comp)) * vdiv
                tmpmin = (max.componentValue(comp) - ray.origin.componentValue(comp)) * vdiv
            }
            
            // reduction width
            if(tmpmin > tmin) {
                tmin = tmpmin;
                minaxis = i;
            }
            if(tmpmax < tmax) {
                tmax = tmpmax;
            }
            
            // not hit
            if(tmax < tmin) {
                return (false, Double.greatestFiniteMagnitude, -1)
            }
        }
        
        // behind the ray
        if(tmax < 0.0 && tmin < 0.0) {
            return (false, Double.greatestFiniteMagnitude, -1)
        }
        
        // result
        return (true, tmin, minaxis)
    }
}

