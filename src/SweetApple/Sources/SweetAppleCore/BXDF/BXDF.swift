#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

public class BXDF {
    // kinds
    public static let kSensor     = 0
    public static let kDiffuse    = 1
    public static let kSpecular   = 2
    public static let kGlossy     = 4
    public static let kRefraction = 8
    public static let kTransmit   = 16
    
}

