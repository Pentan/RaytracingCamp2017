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
        public var verboseInterval:Double = 0.0 // [sec] 0.0 is silent
        public var maxLimitTime:Double = 0.0    // [sec]
        public var progressInterval:Double = 30.0 // [sec] 0.0 is no progress output
        public var outputFile:String = "output.bmp"
        
        public init() {
        }
    }
    
    public class ProgressHandler {
        var interval:Double
        var leeway:Double
        var action:(_ renderer:Renderer)->()
        
        public init(_ interSec:Double, _ act:@escaping (_ renderer:Renderer)->()) {
            interval = interSec
            action = act
            leeway = 1.0
        }
        
        public init(_ interSec:Double, _ leewaySec:Double, _ act:@escaping (_ renderer:Renderer)->()) {
            interval = interSec
            action = act
            leeway = leewaySec
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
        var renderTime:Double
        var state:RenderState
        var minDepth:Int
        var maxDepth:Int
        
        public init(_ t:Image.Tile) {
            tile = t
            renderTime = 0.0
            state = .kStandby
            minDepth = 0
            maxDepth = 0
        }
    }
    
    //
    var config = Config()
    //let contexts:[Context] = []
    
    var tileInfos:[TileInfo] = []
    var renderImage:AccumuratorImage
    
    public var currentImage:BufferedImage {
        return BufferedImage(renderImage)
    }
    
    //
    public init() {
        renderImage = AccumuratorImage(config.width, config.height)
    }
    
    public init(_ conf:Config) {
        self.config = conf
        renderImage = AccumuratorImage(config.width, config.height)
    }
    
    public func render(_ scene:Scene, _ camera:Camera, progress:ProgressHandler? = nil) -> BufferedImage {
        //
        let timeout = DispatchWallTime.now() + config.maxLimitTime
        let startTime = SweetAppleSeconds()
        
        let integrator:Integrator = PathTracer(scene, camera, config)
        
        // preprocess
        scene.renderPreprocess()
        integrator.preprocess()
        
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
        
        var progresstimer:DispatchSourceTimer? = nil
        if let prog = progress {
            progresstimer = DispatchSource.makeTimerSource()
            
            let microleeway = DispatchTimeInterval.microseconds(Int(prog.leeway * 1000000.0))
            let deadline = DispatchTime.now() + prog.interval
            
            progresstimer?.schedule(deadline: deadline, repeating: prog.interval, leeway: microleeway)
            progresstimer?.setEventHandler(handler: DispatchWorkItem(block: {
                prog.action(self)
            }))
            progresstimer?.resume()
        }
        
        var verbosetimer:DispatchSourceTimer? = nil
        if config.verboseInterval > 0.0 {
            verbosetimer = DispatchSource.makeTimerSource()
            verbosetimer?.schedule(deadline: DispatchTime.now() + config.verboseInterval, repeating: config.verboseInterval)
            verbosetimer?.setEventHandler(handler: DispatchWorkItem(block: { 
                //print("verbose progress")
                var yet = 0
                var working = 0
                var done = 0
                
                for tile in self.tileInfos {
                    switch tile.state {
                    case .kStandby:     yet += 1
                    case .kProcessing:  working += 1
                    case .kDone:        done += 1
                    }
                }
                print("\rtotal:\(self.tileInfos.count)/standby:\(yet),working:\(working),done:\(done)", terminator:"")
                fflush(stdout)
            }))
            verbosetimer?.resume()
        }
        
        // render process
        var pastTime = 0.0
        
        repeat {
            let seedbase:UInt64 = UInt64(time(nil))
            
            for i in 0..<tileInfos.count {
                dspqueue.async(group:dspgroup) {
                    self.renderTile(integrator, i, seedbase)
                }
            }
            
            if config.renderMode == .kStandard {
                // standard mode. wait for finish
                dspgroup.wait()
                pastTime = config.maxLimitTime
            } else {
                // time limit mode. render until time limit
                let waitres = dspgroup.wait(wallTimeout: timeout)
                if waitres == .success {
                    // not timeouted. may be not enough time passed
                    // some post process?
                    print("\nrewind")
                }
                pastTime = SweetAppleSeconds() - startTime
            }
        } while (pastTime < config.maxLimitTime)
        
        // clean
        progresstimer?.cancel()
        verbosetimer?.cancel()
        
        /*
        //+++++
        print("render info dump")
        for (i, tli) in tileInfos.enumerated() {
            print("tile[\(i)]:time:\(tli.renderTime),depth(min:\(tli.minDepth),max:\(tli.maxDepth))")
        }
        //+++++
        */
        
        return BufferedImage(renderImage)
    }
    
    internal func renderTile(_ integra:Integrator, _ i:Int, _ seedbase:UInt64) {
        // render tile
        let tlinfo = self.tileInfos[i]
        tlinfo.state = .kProcessing
        let startTime = SweetAppleSeconds()
        
        // parameters
        let samples = self.config.samples
        let ss = self.config.subSamples
        
        let ssrate = 1.0 / Double(self.config.subSamples)
        let divw = 1.0 / Double(self.renderImage.width)
        let divh = 1.0 / Double(self.renderImage.height)
        
        // context
        let rng = Random(seedbase + UInt64(i))
        let camera = integra.camera
        
        var minDepth = Int.max
        var maxDepth = 0
        
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
                            let (col, depth) = integra.radiance(ray, rng)
                            
                            self.renderImage.accumulate(ix, iy, col)
                            
                            if minDepth > depth {
                                minDepth = depth
                            }
                            if maxDepth < depth {
                                maxDepth = depth
                            }
                        }
                    }
                }
            }
        }
        
        let endTime = SweetAppleSeconds()
        
        tlinfo.renderTime = endTime - startTime
        tlinfo.state = .kDone
        tlinfo.minDepth = minDepth
        tlinfo.maxDepth = maxDepth
        
        //print("tile \(i) done. \(startTime) to \(endTime), \(tlinfo.renderTime)")
    }
}
