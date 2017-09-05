#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import Dispatch
import SweetAppleCore
import LinearAlgebra

print("Hello, world!")

// load scene
let scene = Scene()

do {
    // add camera
    let cam = Camera()
    cam.setLookat(Vector3(0.0, 0.0, 5.0), Vector3(0.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0))
    scene.registerCamera(cam)
    
    // object setup
    let mat = DiffuseMaterial()
    let geom = Sphere(1.0, Vector3(0.0, 0.0, 0.0))
    let obj = Object(geom, mat)
    
    // add objects
    scene.registerObject(obj)
}

// scene.findCamera()
let camera = scene.cameras[0]

// render()
let renderconf = Renderer.Config()
renderconf.width = 160
renderconf.height = 90
renderconf.tileSize = 40
renderconf.samples = 2
renderconf.subSamples = 2

let render = Renderer(renderconf)
let img = render.render(scene, camera, async:true)

// wait and check render

// imageProcessor(camera.image)

// finalimage.write
_ = ImageWriter.writeBMP(filepath: "output.bmp", width: Int32(img.width), height: Int32(img.height), data: img.buffer)

// done!
