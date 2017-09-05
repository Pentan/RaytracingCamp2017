#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

class AccumuratorImage: Image {
    //
    /*
    internal struct Pixel {
        var accumulatedColor:Color = Color(0.0, 0.0, 0.0)
        var sampleCount:Int = 0
        
        public mutating func clear() {
            accumulatedColor.set(0.0, 0.0, 0.0)
            sampleCount = 0
        }
        
        public mutating func addSample(_ c:Color) {
            accumulatedColor += c
            sampleCount += 1
        }
        
        public func estimatedColor() -> Color {
            return accumulatedColor / Double(sampleCount)
        }
    }
    */
    internal class Pixel {
        var accumulatedColor:Color = Color(0.0, 0.0, 0.0)
        var sampleCount:Int = 0
        
        public func clear() {
            accumulatedColor.set(0.0, 0.0, 0.0)
            sampleCount = 0
        }
        
        public func addSample(_ c:Color) {
            accumulatedColor += c
            sampleCount += 1
        }
        
        public func estimatedColor() -> Color {
            return accumulatedColor / Double(sampleCount)
        }
    }
    
    //
    internal var pixels:[Pixel] = []
    
    public override init(_ w: Int, _ h: Int) {
        super.init(w, h)
        for _ in 0..<(w * h) {
            pixels.append(Pixel())
        }
        //pixels = Array<Pixel>(repeating: Pixel(), count: w * h)
    }
    
    public func clear() {
        for i in 0..<pixels.count {
            pixels[i].clear()
        }
    }
    
    public override func color(_ x:Int, _ y:Int) -> Color {
        if x < 0 || x >= width || y < 0 || y >= height {
            assertionFailure("AccumuratorImage color() out of range")
            return Color(0.0, 0.0, 0.0)
        }
        return pixels[x + y * width].estimatedColor()
    }
    
    public func accumulate(_ x:Int, _ y:Int, _ color:Color) {
        if x < 0 || x >= width || y < 0 || y >= height {
            assertionFailure("AccumuratorImage accumulate() out of range")
        }
        pixels[x + y * width].addSample(color)
    }
}

