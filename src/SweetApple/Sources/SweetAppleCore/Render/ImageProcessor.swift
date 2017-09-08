#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

public protocol ImageProcessor {
    func apply(_ img:BufferedImage)
}
