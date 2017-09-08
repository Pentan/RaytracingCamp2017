#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public let kSweetAppleINF:Double = 1e128
public let kSweetAppleEPS:Double = kLamEPS
public let kSweetAppleRayOffet:Double = 1e-8
public let kSweetAppleUp:Vector3 = Vector3(0.0, 1.0, 0.0)

public func SweetAppleSeconds() -> Double {
    let timeval = UnsafeMutablePointer<timeval>.allocate(capacity: 1)
    gettimeofday(timeval, nil)
    return Double(timeval.pointee.tv_sec) + Double(timeval.pointee.tv_usec) * 1e-6
    
    /*
    let tp = UnsafeMutablePointer<timespec>.allocate(capacity: 1)
    if #available(OSX 10.12, *) {
        clock_gettime(_CLOCK_REALTIME, tp)
    } else {
        // Fallback on earlier versions
    }
    return Double(timeval.pointee.tv_sec) + Double(timeval.pointee.tv_usec) * 1e-6
     */
}

