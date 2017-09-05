#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import SweetAppleCore
import LinearAlgebra

public class ImageWriter {
    // write as BMP
    static public func writeBMP(filepath:String, width:Int32, height:Int32, data:Array<Color>, gamma:Double = 2.2) -> Bool {
        
        // little endian put
        func put16(_ a:Int32, _ f:UnsafeMutablePointer<FILE>!) {
            fputc(a & 0xff, f);
            fputc((a >> 8) & 0xff, f);
        }
        func put32(_ a:Int32, _ f:UnsafeMutablePointer<FILE>!) {
            fputc(a & 0xff, f);
            fputc((a >> 8) & 0xff, f);
            fputc((a >> 16) & 0xff, f);
            fputc((a >> 24) & 0xff, f);
        }
        
        //
        func packU8(_ x:Double) -> Int32 {
            var c = x
            if c < 0.0 {
                c = 0.0
            }
            if c > 1.0 {
                c = 1.0
            }
            return Int32(pow(c, 1.0/gamma) * 255 + 0.5)
        }
        
        // open file
        if let f = fopen(filepath, "wb") {
            
            // file header
            // signature
            fputs("BM", f)
            // total length (RGB + file header + image header)
            put32(width * height * 3 + 14 + 40, f)
            // reserved 16 bytes * 2
            put32(0, f)
            // offset to data
            put32(14 + 40, f)
            
            // image
            // header size
            put32(40, f)
            // image size
            put32(width, f)
            put32(height, f)
            // bit lanes
            put16(1, f)
            // color bits
            put16(24, f)
            // compression (0:none)
            put32(0, f)
            // data length
            put32(width * height * 3, f)
            // dot per meter (72dpi)
            put32(2835, f)
            put32(2835, f)
            // CLUT infos
            put32(0, f)
            put32(0, f)
            
            // data
            for rgb in data {
                // write as BGR
                fputc(packU8(rgb.b), f);
                fputc(packU8(rgb.g), f);
                fputc(packU8(rgb.r), f);
            }
            
            fclose(f)
            print("BMP saved: \(filepath)")
            
            return true
        }
        
        print("output file couldn't open: \(filepath)")
        return false;
    }
}


