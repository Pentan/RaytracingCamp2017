#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class BVH {
    
    internal class Node {
        public var aabb:AABB = AABB()
        public var children:[Node] = []
        public var isLeaf:Bool = false
        
        public init() {
        }
        
        public init(_ aabb:AABB, leaf:Bool) {
            self.aabb = aabb
            isLeaf = leaf
        }
    }
    
    //
    var tree:Node
    
    public init() {
        tree = Node()
    }
    
    // build tree
    public func buildTree(_ aabblist:[AABB]) {
        _ = recurseBuildTree(tree, aabblist, 0)
    }
    
    internal func recurseBuildTree(_ node:Node, _ aabblist:[AABB], _ depth:Int) -> Int {
        var maxdepth = depth
        
        if aabblist.count > 1 {
            // tree
            // measure AABB
            node.aabb.clear()
            for ab in aabblist {
                node.aabb.expand(ab)
            }
            node.isLeaf = false
            
            // split
            let boundsSize = node.aabb.size()
            let axisid = boundsSize.maxMagnitudeAndIndex().index
            let axis = Vector3.Component.init(rawValue: axisid)!
            
            let sortedaabb = aabblist.sorted { (a, b) -> Bool in
                let aval = a.centroid.componentValue(axis)
                let bval = b.centroid.componentValue(axis)
                return aval < bval
            }
            
            let node0 = Node()
            let node1 = Node()
            node.children.append(node0)
            node.children.append(node1)
            
            let aaddcount = sortedaabb.count
            let halfcount = aaddcount / 2
            
            let aabblist0 = Array(sortedaabb[0..<halfcount])
            let aabblist1 = Array(sortedaabb[halfcount..<aaddcount])
            
            let d0 = recurseBuildTree(node0, aabblist0, depth + 1)
            let d1 = recurseBuildTree(node1, aabblist1, depth + 1)
            
            maxdepth = max(d0, d1)
            
        } else {
            // leaf
            node.aabb = aabblist[0]
            node.isLeaf = true
        }
        
        return maxdepth
    }
    
    // intersection test
    public typealias intersectTest = (_ dataId:Int, _ ray:Ray, _ intersect:Intersection) -> Bool
    
    public func intersect(_ ray:Ray, _ intersect:Intersection, _ leafIntersect:intersectTest) -> Bool {
        return intersectTree(tree, ray, intersect, leafIntersect)
    }
    
    internal func intersectTree(_ node:Node, _ ray:Ray, _ intersect:Intersection, _ leafIntersect:intersectTest) -> Bool {
        if node.isLeaf {
            // leaf node
            let tmpisect = Intersection()
            
            if leafIntersect(node.aabb.dataId, ray, tmpisect) {
                if tmpisect.distance < intersect.distance {
                    intersect.clone(tmpisect)
                    return true
                }
            }
        } else {
            let (ishit, d, _) = node.aabb.isIntersect(ray)
            if ishit && d < intersect.distance {
                let nearest = Intersection()
                let tmpisect = Intersection()
                
                for childnode in node.children {
                    if intersectTree(childnode, ray, tmpisect, leafIntersect) {
                        if tmpisect.distance < nearest.distance {
                            nearest.clone(tmpisect)
                        }
                    }
                }
                if nearest.distance < intersect.distance {
                    intersect.clone(nearest)
                    return true
                }
            }
        }
        
        return false
    }
}

