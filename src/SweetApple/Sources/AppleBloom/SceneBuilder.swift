#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import SweetAppleCore
import LinearAlgebra

internal class SceneBuilder {
    
    static func cornelboxScene() -> Scene {
        let scene = Scene()
        
        // add camera
        let cam = Camera()
        cam.setLookat(Vector3(0.0, 5.0, 18.0), Vector3(0.0, 5.0, 0.0), Vector3(0.0, 1.0, 0.0))
        
        _ = scene.registerCamera(cam)
        
        // sky
        //let sky = SkyMaterial()
        //scene.skyMaterial = sky
        
        // object setup
        class ObjDesc {
            enum MatType: Int {
                case kDiffuse
                case kSpecular
                case kGlass
                case kEmit
            }
            let position:Vector3
            let radius:Double
            let color:Color
            let material:MatType
            
            init(pos:Vector3, r:Double, col:Color, mat:MatType) {
                position = pos
                radius = r
                color = col
                material = mat
            }
        }
        /*
         box size:(-5,0,-10),(5,10,20)
         */
        let descs = [
            // balls
            ObjDesc(pos:Vector3( 0.0, 3.0, -5.0), r:3.0, col:Color(0.8, 0.8, 0.8), mat:.kDiffuse),
            ObjDesc(pos:Vector3(-2.5, 2.0, -1.0), r:2.0, col:Color(0.9, 0.9, 0.9), mat:.kSpecular),
            ObjDesc(pos:Vector3( 2.5, 2.0,  1.0), r:2.0, col:Color(0.9, 0.9, 0.9), mat:.kGlass),
            // walls
            ObjDesc(pos:Vector3(-505.0, 5.0, 0.0), r:500.0, col:Color(1.0, 0.2, 0.2), mat:.kDiffuse),
            ObjDesc(pos:Vector3( 505.0, 5.0, 0.0), r:500.0, col:Color(0.2, 1.0, 0.2), mat:.kDiffuse),
            ObjDesc(pos:Vector3(0.0,  500.0, 0.0), r:500.0, col:Color(1.0, 1.0, 1.0), mat:.kDiffuse),
            ObjDesc(pos:Vector3(0.0,  510.0, 0.0), r:500.0, col:Color(1.0, 1.0, 1.0), mat:.kDiffuse),
            ObjDesc(pos:Vector3(0.0, 5.0, -510.0), r:500.0, col:Color(1.0, 1.0, 1.0), mat:.kDiffuse),
            ObjDesc(pos:Vector3(0.0, 5.0,  520.0), r:500.0, col:Color(0.05, 0.05, 0.05), mat:.kDiffuse),
            // light
            ObjDesc(pos:Vector3(0.0, 19.5, 0.0), r:10.0, col:Color(1.0, 1.0, 1.0), mat:.kEmit)
        ]
        
        for d in descs {
            let mat:Material
            switch d.material {
            case .kDiffuse:
                mat = DiffuseMaterial(diffuse: d.color, emit:Vector3(0.0, 0.0, 0.0), roughness:0.2)
            case .kGlass:
                mat = PerfectGlassMaterial(reflect: Vector3(1.0, 1.0, 1.0), transmit: d.color)
            case .kSpecular:
                mat = PerfectSpecularMaterial(reflect: d.color)
            case .kEmit:
                mat = DiffuseMaterial(diffuse: Vector3(0.0, 0.0, 0.0), emit: d.color)
            }
            
            let geom:Geometry = Sphere(d.radius, d.position)
            let obj:Object = Object(geom, mat)
            _ = scene.registerObject(obj)
        }
        
        return scene
    }
    
    static func testScene() -> Scene {
        let scene = Scene()
        
        // add camera
        let cam = Camera()
        cam.setLookat(Vector3(0.0, 0.0, 5.0), Vector3(0.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0))
        _ = scene.registerCamera(cam)
        
        // sky
        let sky = SkyMaterial()
        scene.skyMaterial = sky
        
        // object setup
        var mat:Material
        var geom:Geometry
        var obj:Object
        
        mat = DiffuseMaterial(diffuse:Color(0.8, 0.8, 0.8), emit:Color(0.0, 0.0, 0.0))
        geom = Sphere(1.0, Vector3(0.0, 0.0, 0.0))
        obj = Object(geom, mat)
        _ = scene.registerObject(obj)
        
        mat = DiffuseMaterial(diffuse:Color(0.0, 0.0, 0.0), emit:Color(0.0, 1.0, 0.0))
        geom = Sphere(0.8, Vector3(2.0, 0.0, 0.0))
        obj = Object(geom, mat)
        _ = scene.registerObject(obj)
        
        /*
        mat = DiffuseMaterial(diffuse:Color(0.0, 0.0, 0.0), emit:Color(0.0, 0.0, 1.0))
        geom = Sphere(0.8, Vector3(-2.0, 0.0, 0.0))
        obj = Object(geom, mat)
        _ = scene.registerObject(obj)
        */
        mat = DiffuseMaterial(diffuse:Color(0.5, 0.5, 0.8), emit:Color(0.0, 0.0, 0.0))
        geom = Cube(position:Vector3(-2.0, 0.0, 0.0), size:Vector3(1.5, 1.5, 1.5))
        obj = Object(geom, mat)
        obj.setTransform(Matrix4.makeRotation(1.0, 0.0, 0.0, 1.0))
        _ = scene.registerObject(obj)
        
        
        return scene
    }
    
    
    static func sampleScene() -> Scene {
        let scene = Scene()
        
        // add camera
        let cam = Camera()
        cam.setLookat(Vector3(0.0, 0.0, 7.0), Vector3(0.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0))
        _ = scene.registerCamera(cam)
        
        // sky
        let sky = SkyMaterial()
        scene.skyMaterial = sky
        
        // object setup
        var mat:Material
        var geom:Geometry
        var obj:Object
        
        mat = DiffuseMaterial(diffuse:Color(0.2, 0.8, 0.2), emit:Color(0.0, 0.0, 0.0))
        geom = Sphere(1.0, Vector3(-1.5, 0.0, 0.0))
        obj = Object(geom, mat)
        _ = scene.registerObject(obj)
        
        mat = DiffuseMaterial(diffuse:Color(0.2, 0.2, 0.8), emit:Color(0.0, 0.0, 0.0))
        geom = Cube(position:Vector3(1.5, 0.0, 0.0), size:Vector3(2.0, 2.0, 2.0))
        obj = Object(geom, mat)
        _ = scene.registerObject(obj)
        
        return scene
    }
    
    ///////////
    
    static public func mainScene() -> Scene {
        let scene = Scene()
        
        // add camera
        let cam = Camera()
        cam.setLookat(Vector3(6.6, 7.7, 7.7), Vector3(-0.35, 0.78, 1.1), Vector3(0.0, 1.0, 0.0))
        cam.focalLength = 45.0
        _ = scene.registerCamera(cam)
        
        // sky
        let sky = SkyMaterial()
        scene.skyMaterial = sky
        
        // floor
        addFloor(scene)
        
        // desk
        addDesk(scene)
        
        // cornel box
        addCornelBox(scene)
        
        // sphere
        addSphere(scene)
        
        //
        addManKind(scene)
        
        return scene
    }
    
    static internal func addFloor(_ scene:Scene) {
        // floor
        let mat = DiffuseMaterial(diffuse:Color(0.25, 0.5, 0.3))
        let geom = Cube(position:Vector3(0.0, -1.0, 0.0), size:Vector3(30.0, 2.0, 30.0))
        let obj = Object(geom, mat)
        _ = scene.registerObject(obj)
    }
    
    static internal func addDesk(_ scene:Scene) {
        var geom:Geometry
        var obj:Object
        
        // top
        let deskmat = DiffuseMaterial(diffuse:Color(0.3, 0.24, 0.19))
        geom = Cube(position:Vector3(0.0, 2.0, 0.0), size:Vector3(8.0, 0.2, 2.4))
        obj = Object(geom, deskmat)
        _ = scene.registerObject(obj)
        
        // leg
        let legpos = [
            Vector3( 3.8, 1.0,  1.0),
            Vector3( 3.8, 1.0, -1.0),
            Vector3(-3.8, 1.0,  1.0),
            Vector3(-3.8, 1.0, -1.0)
        ]
        
        for p in legpos {
            geom = Cube(position:p, size:Vector3(0.24, 2.0, 0.24))
            obj = Object(geom, deskmat)
            _ = scene.registerObject(obj)
        }
        
        // under light
        let litmat = DiffuseMaterial(diffuse:Color(0.0, 0.0, 0.0), emit:Color(2.0, 2.0, 2.0))
        geom = Cube(position:Vector3(0.0, 1.8, -0.8), size:Vector3(6.0, 0.2, 0.6))
        obj = Object(geom, litmat)
        _ = scene.registerObject(obj)
    }
    
    static internal func addCornelBox(_ scene:Scene) {
        
        // walls
        struct WallDef {
            let pos:Vector3
            let size:Vector3
            let color:Color
            
            init (p:Vector3, s:Vector3, c:Color) {
                pos = p
                size = s
                color = c
            }
        }
        let walldefs = [
            WallDef(p: Vector3(1.085, 2.6  , -0.095), s: Vector3(0.05, 1.0, 1.0), c: Color(0.0, 0.8, 0.0)),
            WallDef(p: Vector3(0.035, 2.6  , -0.095), s: Vector3(0.05, 1.0, 1.0), c: Color(0.8, 0.0, 0.0)),
            WallDef(p: Vector3(0.56 , 2.125, -0.095), s: Vector3(1.0, 0.05, 1.0), c: Color(0.8, 0.8, 0.8)),
            WallDef(p: Vector3(0.56 , 3.075, -0.095), s: Vector3(1.0, 0.05, 1.0), c: Color(0.8, 0.8, 0.8)),
            WallDef(p: Vector3(0.56 , 2.6  , -0.57 ), s: Vector3(1.0, 0.9, 0.05), c: Color(0.8, 0.8, 0.8))
        ]
        
        for wall in walldefs {
            let mat = DiffuseMaterial(diffuse:wall.color)
            let geom = Cube(position:wall.pos, size:wall.size)
            let obj = Object(geom, mat)
            _ = scene.registerObject(obj)
        }
        
        var mat:Material
        var geom:Geometry
        var obj:Object
        
        // diffuse sphere
        mat = DiffuseMaterial(diffuse:Color(0.5, 0.5, 0.5))
        geom = Sphere(0.2, Vector3(0.44, 2.355, -0.32))
        obj = Object(geom, mat)
        _ = scene.registerObject(obj)
        
        // glass sphere
        mat = PerfectGlassMaterial(reflect: Color(0.8, 0.8, 0.8), transmit:Color(0.8, 0.8, 0.8))
        geom = Sphere(0.2, Vector3(0.29, 2.355, 0.12))
        obj = Object(geom, mat)
        _ = scene.registerObject(obj)
        
        // specular sphere
        mat = PerfectSpecularMaterial(reflect: Color(0.8, 0.8, 0.8))
        geom = Sphere(0.2, Vector3(0.83, 2.355, -0.075))
        obj = Object(geom, mat)
        _ = scene.registerObject(obj)
        
        // emission
        mat = DiffuseMaterial(diffuse:Color(0.0, 0.0, 0.0), emit:Color(2.0, 2.0, 2.0))
        geom = Cube(position:Vector3(0.56, 3.025, -0.095), size:Vector3(0.3, 0.05, 0.3))
        obj = Object(geom, mat)
        _ = scene.registerObject(obj)
    }
    
    static internal func addSphere(_ scene:Scene) {
        let mat = DiffuseMaterial(diffuse:Color(0.0, 0.0, 0.0), emit:Color(0.8, 0.75, 0.58))
        let geom = Sphere(1.0, Vector3(-3.3, 1.0, 2.5))
        let obj = Object(geom, mat)
        _ = scene.registerObject(obj)
    }
    
    static internal func addManKind(_ scene:Scene) {
        let cubesize = Vector3(0.072, 0.072, 0.072)
        
        
        var mat:Material
        
        // head
        mat = DiffuseMaterial(diffuse:Color(0.64, 0.45, 0.13))
        for pos in SceneDataHead.data {
            let geom = Cube(position:pos, size:cubesize)
            let obj = Object(geom, mat)
            _ = scene.registerObject(obj)
        }
        
        // face
        mat = DiffuseMaterial(diffuse:Color(0.65, 0.54, 0.34))
        for pos in SceneDataFace.data {
            let geom = Cube(position:pos, size:cubesize)
            let obj = Object(geom, mat)
            _ = scene.registerObject(obj)
        }
        
        // hand
        mat = DiffuseMaterial(diffuse:Color(0.75, 0.7, 0.5))
        for pos in SceneDataHand.data {
            let geom = Cube(position:pos, size:cubesize)
            let obj = Object(geom, mat)
            _ = scene.registerObject(obj)
        }
        
        // tops
        mat = DiffuseMaterial(diffuse:Color(0.7, 0.7, 0.7))
        for pos in SceneDataTops.data {
            let geom = Cube(position:pos, size:cubesize)
            let obj = Object(geom, mat)
            _ = scene.registerObject(obj)
        }
        
        // hip
        //mat = DiffuseMaterial(diffuse:Color(0.64, 0.45, 0.13))
        mat = DiffuseMaterial(diffuse:Color(0.6, 0.18, 0.01))
        for pos in SceneDataHip.data {
            let geom = Cube(position:pos, size:cubesize)
            let obj = Object(geom, mat)
            _ = scene.registerObject(obj)
        }
        
        // leg
        //mat = DiffuseMaterial(diffuse:Color(0.75, 0.7, 0.5))
        mat = DiffuseMaterial(diffuse:Color(0.12, 0.07, 0.06))
        for pos in SceneDataLeg.data {
            let geom = Cube(position:pos, size:cubesize)
            let obj = Object(geom, mat)
            _ = scene.registerObject(obj)
        }
    }
}

