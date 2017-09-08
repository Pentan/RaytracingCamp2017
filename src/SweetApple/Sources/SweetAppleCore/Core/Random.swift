#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

/*
 rng routine
 http://xoroshiro.di.unimi.it/xoroshiro128plus.c
 initializer
 http://xoroshiro.di.unimi.it/splitmix64.c
 double conversion
 https://github.com/MersenneTwister-Lab/XSadd/blob/master/xsadd.h
*/

public class Random {
    static private let kDoubleMultiply0:Double = 1.0 / 9007199254740992.0
    static private let kDoubleMultiply1:Double = 1.0 / 9007199254740991.0
    
    private var s = Array<UInt64>(repeating: 0, count: 2)
    
    //
    public init() {
        setSeed(1234567890)
    }
    
    public init(_ seed:UInt64) {
        setSeed(seed)
    }
    
    public func setSeed(_ seed:UInt64) {
        // splitmix64
        var x:UInt64 = seed
        let LOOP:Int = 10
        for i in 0..<(LOOP + 2) {
            x = x &+ 0x9E3779B97F4A7C15
            
            if i >= LOOP {
                var z:UInt64 = x
                z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
                z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
                s[i - LOOP] = z ^ (z >> 31)
            }
        }
    }
    
    public func next() -> UInt64 {
        let s0 = s[0]
        var s1 = s[1]
        var result = s0 &+ s1
        
        func rotl(_ x:UInt64, _ k:UInt64) -> UInt64 {
            return (x << k) | (x >> (64 &- k))
        }
        
        s1 ^= s0
        s[0] = rotl(s0, 55) ^ s1 ^ (s1 << 14); // a, b
        s[1] = rotl(s1, 36); // c
        
        return result;
    }
    
    // [0,1)
    public func nextDouble() -> Double {
        return Double(next() >> 11) * Random.kDoubleMultiply0
    }
    
    // [0,1]
    public func nextDouble01() -> Double {
        return Double(next() >> 11) * Random.kDoubleMultiply1
    }
    
    // (-1,1)
    public func nextDouble11() -> Double {
        return (nextDouble() * 2.0 + Random.kDoubleMultiply0) - 1.0
    }
    
    public func jump() {
        let JUMP:[UInt64] = [0xbeac0467eba5facb, 0xd86b048b86aa9922]
        
        var s0:UInt64 = 0
        var s1:UInt64 = 0
        for i in 0..<JUMP.count {
            for b in 0..<64 {
                if (JUMP[i] & 1 << UInt64(b)) != 0 {
                    s0 ^= s[0]
                    s1 ^= s[1]
                }
                _ = next()
            }
        }
        s[0] = s0
        s[1] = s1
    }
    
}
