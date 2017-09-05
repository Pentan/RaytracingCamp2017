#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public extension Vector3 {
    public var r:Double {
        get {
            return x
        }
        set {
            x = newValue
        }
    }
    
    public var g:Double {
        get {
            return y
        }
        set {
            y = newValue
        }
    }
    
    public var b:Double {
        get {
            return z
        }
        set {
            z = newValue
        }
    }
}

public typealias Color = Vector3
