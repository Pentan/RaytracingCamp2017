import XCTest
@testable import SweetAppleCore
import LinearAlgebra

class SweetAppleCoreTests: XCTestCase {
    
    func testBasicFlow() {
        // build scene
        let scene = Scene()
        
        // scene setup
        do {
            // add camera
            let cam = Camera()
            cam.setLookat(Vector3(0.0, 0.0, 5.0), Vector3(0.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0))
            scene.registerCamera(cam)
            XCTAssertEqual(scene.cameras.count, 1, "register camera")
            
            // object setup
            let mat = DiffuseMaterial()
            let geom = Sphere(1.0, Vector3(0.0, 0.0, 0.0))
            let obj = Object(geom, mat)
            
            // add objects
            scene.registerObject(obj)
            XCTAssertEqual(scene.objects.count, 1, "register object")
        }
        
        // render
        do {
            let cam = scene.cameras[0]
            
            let renderconf = Renderer.Config()
            renderconf.width = 160
            renderconf.height = 90
            renderconf.tileSize = 40
            renderconf.samples = 2
            renderconf.subSamples = 2
            
            let render = Renderer(renderconf)
            render.render(scene, cam, async:true)
            
            
        }
        
        
    }

    static var allTests = [
        ("testBasicFlow", testBasicFlow),
    ]
}
