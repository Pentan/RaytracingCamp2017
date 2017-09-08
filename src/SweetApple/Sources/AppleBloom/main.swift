#if os(OSX)
    import Darwin
#else
    import Glibc
    
func dummyForDispatch() -> Int {
    let pn = getprogname()
    let buf = UnsafeMutablePointer<Int8>.allocate(capacity: 128)
    let r = strlcpy(buf, pn, 128)
    //print("pn:\(String(cString: pn!)),buf:\(String(cString: buf)),r:\(r)")
    return Int(r)
}
_ = dummyForDispatch()
    
#endif


import Dispatch
import SweetAppleCore
import LinearAlgebra

print("AplBlm start")
let startTime = SweetAppleSeconds()

// load scene
let scene:Scene
//scene = SceneBuilder.testScene()
//scene = SceneBuilder.cornelboxScene()
scene = SceneBuilder.mainScene()

// scene.findCamera()
let camera = scene.getCamera(0)

// render()
let renderconf = Renderer.Config()
/*
renderconf.width = 640 //160
renderconf.height = Int(Double(renderconf.width) / camera.sensorAspectRatio()) //90
 */
renderconf.width = 1280
renderconf.height = 720
renderconf.tileSize = 128
renderconf.samples = 2
renderconf.subSamples = 2
renderconf.renderMode = .kTimeLimit
renderconf.maxLimitTime = 260.0
renderconf.verboseInterval = 1.0
renderconf.progressInterval = 30.0
renderconf.minDepth = 1
renderconf.maxDepth = 2

//
if CommandLine.argc > 2 {
    if CommandLine.arguments[1] == "-t" {
        if let t:Double = Double(CommandLine.arguments[2]) {
            renderconf.maxLimitTime = t
        }
    } else if CommandLine.arguments[1] == "-s" {
        renderconf.renderMode = .kStandard
    }
}

switch renderconf.renderMode {
case .kStandard:
    print("standard render mode")
case .kTimeLimit:
    print("time limit render mode")
}

print("render size:(\(renderconf.width),\(renderconf.height))")
print("tile size:\(renderconf.tileSize)")
print("maxLimitTime:\(renderconf.maxLimitTime)")
print("progressInterval:\(renderconf.progressInterval)")
print("sample:\(renderconf.samples)")
print("subsample:\(renderconf.subSamples)")
print("depth:(min:\(renderconf.minDepth),max:\(renderconf.maxDepth))")

//
let render = Renderer(renderconf)

var progressCount = 1
let progress = Renderer.ProgressHandler(renderconf.progressInterval, {rndr in
    let img = rndr.currentImage
    let countstr = String(progressCount)
    var progressbase = "progress00000"
    progressbase.characters.removeLast(countstr.characters.count)
    let outname = "\(progressbase)\(countstr).bmp"
    
    ImageWriter.writeBMP(filepath: outname, width: Int32(img.width), height: Int32(img.height), data: img.buffer)
    print("\nprogress out \(outname)")
    //print("progress \(progressCount)")
    progressCount += 1
})
let img = render.render(scene, camera, progress: progress)
print("\nrender complete")
// wait and check render

// imageProcessor(camera.image)

// finalimage.write
ImageWriter.writeBMP(filepath: renderconf.outputFile, width: Int32(img.width), height: Int32(img.height), data: img.buffer)
print("finale image \(renderconf.outputFile) saved")

let endTime = SweetAppleSeconds()
print("process time:\(endTime - startTime) [sec]")

// done!
