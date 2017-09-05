#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

public class Image {
    public var width:Int
    public var height:Int
    
    public init(_ w:Int, _ h:Int) {
        width = w
        height = h
    }
    
    public func color(_ x:Int, _ y:Int) -> Color {
        return Color(0.0, 0.0, 0.0)
    }
    
    //
    public struct Tile {
        var startx:Int, endx:Int
        var starty:Int, endy:Int
        
        public init(_ sx:Int, _ sy:Int, _ w:Int, _ h:Int) {
            startx = sx
            endx = sx + w
            starty = sy
            endy = sy + h
        }
    }
    
    public func makeTile(_ x:Int, _ y:Int, _ w:Int, _ h:Int) -> Tile {
        var ret = Tile(x, y, w, h)
        
        func clamp(_ a:inout Int, min:Int, max:Int) {
            if a < min {
                a = min
            } else if a > max {
                a = max
            }
        }
        
        clamp(&ret.startx, min:0, max:width - 1)
        clamp(&ret.starty, min:0, max:height - 1)
        
        clamp(&ret.endx, min:0, max:width)
        clamp(&ret.endy, min:0, max:height)
        
        return ret;
    }
}
