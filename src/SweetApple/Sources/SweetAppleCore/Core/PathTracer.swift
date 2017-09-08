#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class PathTracer: Integrator {
    
    public override init(_ scn:Scene, _ cam:Camera, _ conf:Renderer.Config) {
        super.init(scn, cam, conf)
    }
    
    public override func preprocess() {
        // noop
    }
    
    public override func radiance(_ firstray:Ray, _ rng:Random) -> (color:Color, depth:Int) {
        
        //Random *crnd = &cntx->random;
        
        //std::vector<Ray> *currays = &cntx->rayVector1;
        //std::vector<Ray> *nextrays = &cntx->rayVector2;
        //std::vector<Ray> *tmprays = &cntx->workVector;
        //tmprays->clear();
        
        // init radiance
        var radiance = Color(0.0, 0.0, 0.0)
        
        // sky
        let skymat:SkyMaterial? = scene.skyMaterial
        
        // trace start
        var insidentRays:[Ray] = []
        //var emittedRays:[Ray] = []
        var outgoingRays:[Ray] = []
        
        insidentRays.append(firstray)
        var depth:Int = 0
        
        // trace
        let minDepth = config.minDepth
        let depthLimit = config.maxDepth
        
        while(insidentRays.count > 0) {
            
            for inray in insidentRays {
                let intersect = Intersection()
                
                // not intersected. pick background
                if !scene.intersect(inray, intersect) {
                    let bgcol = skymat?.skyColor(inray) ?? Color(1.0, 0.0, 0.0)
                    radiance += Color.mul(bgcol, inray.weight)
                    continue
                }
                
                // hit!
                let hitobject = scene.getObject(intersect.objectId)
                
                // from hit face info
                let hitmat = hitobject.getMaterialById(intersect.materialId)
                intersect.shadingNormal = hitmat.shadingNormal(intersect)
                
                // add emittance
                let emittance = hitmat.emittance(intersect)
                radiance += Color.mul(emittance, inray.weight)
                
                //+++++
                // for debugging
                /* * /
                // normal
                //radiance += intersect.shadingNormal * 0.5 + Vector3(0.5, 0.5, 0.5)
                //radiance += intersect.hitNormal * 0.5 + Vector3(0.5, 0.5, 0.5)
                radiance += intersect.geometryNormal * 0.5 + Vector3(0.5, 0.5, 0.5)
                continue;
                / * * /
                // is hit
                radiance += Vector3(1.0, 1.0, 1.0)
                continue
                / * */
                //+++++
                
                // trace next
                var russianprob = hitmat.terminationProbability(intersect)
                
                if(depth < minDepth) {
                    russianprob = 1.0;
                } else {
                    let weightmax = Double.minimum(1.0, abs(inray.weight.maxMagnitude()))
                    russianprob = Double.minimum(1.0, russianprob * weightmax) // how about this?
                    
                    if(depth > depthLimit) {
                        russianprob *= pow(0.5, Double(depth - depthLimit))
                    }
                    if rng.nextDouble() >= russianprob {
                        // russian roulette kill
                        continue;
                    }
                }
                
                hitmat.nextSampleRays(inray, intersect, rng, depth, &outgoingRays)
                
                // fix weight
                for eray in outgoingRays {
                    var tmpweight = eray.weight / russianprob
                    tmpweight = Vector3.mul(tmpweight, inray.weight)
                    eray.weight = tmpweight
                }
            }
            
            swap(&insidentRays, &outgoingRays)
            outgoingRays.removeAll()
            
            depth += 1
        }
        
        return (radiance, depth)
        //return Color(rng.nextDouble(), rng.nextDouble(), rng.nextDouble())
    }
}

