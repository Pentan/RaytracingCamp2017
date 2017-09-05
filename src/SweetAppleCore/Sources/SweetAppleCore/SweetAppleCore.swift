#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public let kSweetAppleINF:Double = 1e128
public let kSweetAppleEPS:Double = kLamEPS

