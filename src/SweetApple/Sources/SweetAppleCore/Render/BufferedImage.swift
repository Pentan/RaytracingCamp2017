#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

public class BufferedImage : Image {
    public var buffer:[Color] = []
    
    public override init(_ w:Int, _ h:Int) {
        super.init(w, h)
        for _ in 0..<(w * h) {
            buffer.append(Color(0.0, 0.0, 0.0))
        }
    }
    
    public init(_ img:Image) {
        super.init(img.width, img.height)
        for iy in 0..<height {
            for ix in 0..<width {
                buffer.append(img.color(ix, iy))
            }
        }
    }
    
    public func scan(_ img:Image) {
        width = img.width
        height = img.height
        
        buffer.removeAll()
        for iy in 0..<height {
            for ix in 0..<width {
                buffer.append(img.color(ix, iy))
            }
        }
    }
    
    public override func color(_ x:Int, _ y:Int) -> Color {
        return buffer[x + y * height]
    }
}
