#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import Dispatch

public class Renderer {
    //
    public enum RenderMode: Int {
        case kStandard
        case kTimeLimit
    }
    
    public class Config {
        public var width:Int = 640
        public var height:Int = 360
        public var subSamples:Int = 2
        public var samples:Int = 2
        public var minDepth:Int = 3
        public var maxDepth:Int = 32
        //public var defaultThreads:Int = 4
        //public var maxThreads:Int = 0      // 0 is unlimited
        public var tileSize:Int = 32
        public var renderMode:RenderMode = RenderMode.kStandard
        public var progressOutInterval:Double = 0.0
        public var maxLimitTime:Double = 0.0
        public var outputFile:String = "output.bmp"
        
        public init() {
        }
    }
    
    /*
    public class Context {
        var workRays:[Ray] = []
        
        var random:Random
        var config:Config
        
        public init(_ seed:UInt64, _ conf:Config) {
            random = Random(seed)
            config = conf
        }
    }
    */
    
    public enum RenderState: Int {
        case kStandby
        case kProcessing
        case kDone
    }
    
    class TileInfo {
        var tile:Image.Tile
        var startTime:Double
        var endTime:Double
        var state:RenderState
        
        public init(_ t:Image.Tile) {
            tile = t
            startTime = -1.0
            endTime = -1.0
            state = .kStandby
        }
    }
    
    //
    var config = Config()
    //let contexts:[Context] = []
    
    var tileInfos:[TileInfo] = []
    
    var renderImage:AccumuratorImage
    
    //
    public init() {
        renderImage = AccumuratorImage(config.width, config.height)
    }
    
    public init(_ conf:Config) {
        self.config = conf
        renderImage = AccumuratorImage(config.width, config.height)
    }
    
    public func render(_ scene:Scene, _ camera:Camera, async:Bool) -> BufferdImage {
        // preprocess
        scene.renderPreprocess()
        
        // clear
        renderImage.clear()
        
        // make tile list
        for iy in stride(from: 0, to: renderImage.height, by: config.tileSize) {
            for ix in stride(from: 0, to: renderImage.width, by: config.tileSize) {
                let tile = renderImage.makeTile(ix, iy, config.tileSize, config.tileSize)
                tileInfos.append(TileInfo(tile))
            }
        }
        
        let dspqueue = DispatchQueue.global(qos: .default)
        let dspgroup = DispatchGroup()
        
        let seedbase:UInt64 = UInt64(time(nil))
        
        for i in 0..<tileInfos.count {
            dspqueue.async(group:dspgroup) {
                // render tile
                let tlinfo = self.tileInfos[i]
                tlinfo.state = .kProcessing
                tlinfo.startTime = Double(DispatchWallTime.now().rawValue)
                
                // parameters
                let samples = self.config.samples
                let ss = self.config.subSamples
                
                let ssrate = 1.0 / Double(self.config.subSamples)
                let divw = 1.0 / Double(self.renderImage.width)
                let divh = 1.0 / Double(self.renderImage.height)
                
                // context
                let rng = Random(seedbase + UInt64(i))
                
                for iy in tlinfo.tile.starty..<tlinfo.tile.endy {
                    for ix in tlinfo.tile.startx..<tlinfo.tile.endx {
                        for ssy in 0..<ss {
                            for ssx in 0..<ss {
                                for _ in 0..<samples {
                                    let px = Double(ix) + (Double(ssx) + rng.nextDouble()) * ssrate
                                    let py = Double(iy) + (Double(ssy) + rng.nextDouble()) * ssrate
                                    let cx = px * divw * 2.0 - 1.0
                                    let cy = py * divh * 2.0 - 1.0
                                    
                                    let ray = camera.makeRay(cx, cy, rng)
                                    let col = self.computeRadiance(scene, ray, rng)
                                    
                                    self.renderImage.accumulate(ix, iy, col)
                                    //self.renderImage.accumulate(0, 0, col)
                                }
                            }
                        }
                    }
                }
                tlinfo.endTime = Double(DispatchWallTime.now().rawValue)
                tlinfo.state = .kDone
                
                //print("tile \(i) done. \(tlinfo.endTime),\(tlinfo.endTime - tlinfo.startTime)")
            
                DispatchQueue.main.async {
                    print("tile \(i) done. \(tlinfo.endTime),\(tlinfo.endTime - tlinfo.startTime)")
                }
            
            }
        }
        
        dspgroup.wait() // FIXME
        
        return BufferdImage(renderImage)
    }
    
    internal func computeRadiance(_ scene:Scene, _ ray:Ray, _ rng:Random) -> Color {
        //+++++
        return Color(rng.nextDouble(), rng.nextDouble(), rng.nextDouble())
        //+++++
    }
    
    
}
