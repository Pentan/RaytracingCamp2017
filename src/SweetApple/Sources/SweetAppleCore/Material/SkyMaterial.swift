#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class SkyMaterial: Material {
    
    public func skyColor(_ ray:Ray) -> Color {
        let dy = ray.direction.y * 0.5 + 0.5
        
        return Color(0.4, 0.4, 0.4) * dy
        /*
        let dy = ray.direction.y
        if dy > 0.0 {
            //return Color(100.0, 100.0, 10.0)
            return Color(0.8, 0.8, 1.0) * (0.5 + dy * 0.5)
        } else {
            //return Color(10.0, 10.0, 100.0)
            return Color(0.5, 0.4, 0.2) * (0.5 - dy * 0.5)
        }
        */
    }
}
