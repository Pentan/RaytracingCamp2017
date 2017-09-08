#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import LinearAlgebra

public class SceneDataHand {
    static let data:[Vector3] = [
Vector3(-0.7651085257530212,1.0130493640899658,1.6653817892074585),
Vector3(-0.6853781342506409,1.0130493640899658,1.6653817892074585),
Vector3(-0.6056477427482605,1.092779517173767,1.665381908416748),
Vector3(-0.5259174704551697,1.092779517173767,1.665381908416748),
Vector3(-0.6056477427482605,1.0130492448806763,1.665381908416748),
Vector3(-0.5259174704551697,1.0130492448806763,1.665381908416748),
Vector3(-0.8448387980461121,1.0927796363830566,1.7451120615005493),
Vector3(-0.8448387980461121,1.0927793979644775,1.8248423337936401),
Vector3(-0.9245689511299133,1.0130491256713867,1.7451120615005493),
Vector3(-0.8448387980461121,1.0130491256713867,1.7451120615005493),
Vector3(-0.9245689511299133,1.0130493640899658,1.8248423337936401),
Vector3(-0.8448387980461121,1.0130493640899658,1.8248423337936401),
Vector3(-0.9245691895484924,1.0130493640899658,1.90457284450531),
Vector3(-0.8448389172554016,1.0130493640899658,1.90457284450531),
Vector3(-0.9245691895484924,1.0130491256713867,1.9843031167984009),
Vector3(-0.8448389172554016,1.0130491256713867,1.9843031167984009),
Vector3(-0.7651085257530212,1.0927796363830566,1.7451120615005493),
Vector3(-0.6853781342506409,1.0927796363830566,1.7451120615005493),
Vector3(-0.7651085257530212,1.0927793979644775,1.8248423337936401),
Vector3(-0.6853781342506409,1.0927793979644775,1.8248423337936401),
Vector3(-0.7651085257530212,1.0130491256713867,1.7451120615005493),
Vector3(-0.6853781342506409,1.0130491256713867,1.7451120615005493),
Vector3(-0.7651085257530212,1.0130493640899658,1.8248423337936401),
Vector3(-0.6056477427482605,1.092779517173767,1.7451121807098389),
Vector3(-0.5259174704551697,1.092779517173767,1.7451121807098389),
Vector3(-0.6056477427482605,1.0927793979644775,1.8248423337936401),
Vector3(-0.5259174704551697,1.0927793979644775,1.8248423337936401),
Vector3(-0.6056477427482605,1.0130492448806763,1.7451121807098389),
Vector3(-0.7651085257530212,1.0927793979644775,1.90457284450531),
Vector3(-0.6853781342506409,1.0927793979644775,1.90457284450531),
Vector3(-0.7651087641716003,1.0130493640899658,1.90457284450531),
Vector3(-0.6853782534599304,1.0130493640899658,1.90457284450531),
Vector3(-0.7651087641716003,1.0130491256713867,1.9843031167984009),
Vector3(-0.6853782534599304,1.0130491256713867,1.9843031167984009),
Vector3(-0.6056477427482605,1.092779517173767,1.9045729637145996),
Vector3(-0.5259174704551697,1.092779517173767,1.9045729637145996),
Vector3(-0.6056477427482605,1.092779517173767,1.9843032360076904),
Vector3(-0.5259174704551697,1.092779517173767,1.9843032360076904),
Vector3(-0.60564786195755,1.0130492448806763,1.9045729637145996),
Vector3(-0.60564786195755,1.0130492448806763,1.9843032360076904),
Vector3(-0.5259175896644592,1.0130492448806763,1.9843032360076904),
Vector3(-0.7651085257530212,0.9333188533782959,1.6653817892074585),
Vector3(-0.6853781342506409,0.9333188533782959,1.6653817892074585),
Vector3(-0.7651085257530212,0.853588342666626,1.6653817892074585),
Vector3(-0.6853781342506409,0.853588342666626,1.6653817892074585),
Vector3(-0.6056477427482605,0.9333189725875854,1.665381908416748),
Vector3(-0.5259174704551697,0.9333189725875854,1.665381908416748),
Vector3(-0.6056477427482605,0.8535884618759155,1.665381908416748),
Vector3(-0.5259174704551697,0.8535884618759155,1.665381908416748),
Vector3(-0.9245689511299133,0.933319091796875,1.7451120615005493),
Vector3(-0.8448387980461121,0.933319091796875,1.7451120615005493),
Vector3(-0.9245691895484924,0.9333188533782959,1.8248423337936401),
Vector3(-0.9245691895484924,0.8535885810852051,1.7451120615005493),
Vector3(-0.8448389172554016,0.8535885810852051,1.7451120615005493),
Vector3(-0.9245691895484924,0.853588342666626,1.8248423337936401),
Vector3(-0.8448389172554016,0.853588342666626,1.8248423337936401),
Vector3(-0.9245691895484924,0.9333188533782959,1.90457284450531),
Vector3(-0.8448389172554016,0.9333188533782959,1.90457284450531),
Vector3(-0.9245691895484924,0.9333188533782959,1.9843031167984009),
Vector3(-0.8448389172554016,0.9333188533782959,1.9843031167984009),
Vector3(-0.9245691895484924,0.853588342666626,1.90457284450531),
Vector3(-0.8448389172554016,0.853588342666626,1.90457284450531),
Vector3(-0.8448389172554016,0.853588342666626,1.9843031167984009),
Vector3(-0.8448389172554016,0.7738580703735352,1.7451119422912598),
Vector3(-0.8448389172554016,0.7738583087921143,1.8248422145843506),
Vector3(-0.8448389172554016,0.7738583087921143,1.9045727252960205),
Vector3(-0.8448389172554016,0.7738580703735352,1.9843029975891113),
Vector3(-0.7651085257530212,0.933319091796875,1.7451120615005493),
Vector3(-0.7651087641716003,0.8535885810852051,1.7451120615005493),
Vector3(-0.6853782534599304,0.8535885810852051,1.7451120615005493),
Vector3(-0.60564786195755,0.8535884618759155,1.7451121807098389),
Vector3(-0.5259175896644592,0.8535884618759155,1.7451121807098389),
Vector3(-0.5259175896644592,0.853588342666626,1.8248423337936401),
Vector3(-0.7651087641716003,0.9333188533782959,1.9843031167984009),
Vector3(-0.6853782534599304,0.9333188533782959,1.9843032360076904),
Vector3(-0.6853782534599304,0.853588342666626,1.9045729637145996),
Vector3(-0.7651087641716003,0.853588342666626,1.9843031167984009),
Vector3(-0.6853782534599304,0.853588342666626,1.9843032360076904),
Vector3(-0.60564786195755,0.9333189725875854,1.9843032360076904),
Vector3(-0.5259175896644592,0.9333187341690063,1.9843032360076904),
Vector3(-0.60564786195755,0.8535884618759155,1.9045729637145996),
Vector3(-0.5259175896644592,0.8535882234573364,1.9045729637145996),
Vector3(-0.60564786195755,0.8535884618759155,1.9843032360076904),
Vector3(-0.5259175896644592,0.8535882234573364,1.9843032360076904),
Vector3(-0.7651087641716003,0.7738580703735352,1.7451119422912598),
Vector3(-0.6853782534599304,0.7738580703735352,1.7451119422912598),
Vector3(-0.7651087641716003,0.7738580703735352,1.8248422145843506),
Vector3(-0.6853782534599304,0.7738580703735352,1.8248422145843506),
Vector3(-0.60564786195755,0.7738581895828247,1.7451120615005493),
Vector3(-0.5259175896644592,0.7738581895828247,1.7451120615005493),
Vector3(-0.60564786195755,0.7738580703735352,1.8248422145843506),
Vector3(-0.5259175896644592,0.7738580703735352,1.8248422145843506),
Vector3(-0.7651087641716003,0.7738580703735352,1.9045727252960205),
Vector3(-0.6853782534599304,0.7738580703735352,1.9045727252960205),
Vector3(-0.7651087641716003,0.7738580703735352,1.9843029975891113),
Vector3(-0.6853782534599304,0.7738580703735352,1.9843029975891113),
Vector3(-0.60564786195755,0.7738581895828247,1.9045729637145996),
Vector3(-0.5259175896644592,0.7738581895828247,1.9045729637145996),
Vector3(-0.36645668745040894,1.172509789466858,1.665381908416748),
Vector3(-0.2867264747619629,1.172509789466858,1.665381908416748),
Vector3(-0.2069959044456482,1.172509789466858,1.665381908416748),
Vector3(-0.44618695974349976,1.092779278755188,1.665381908416748),
Vector3(-0.36645668745040894,1.092779278755188,1.665381908416748),
Vector3(-0.44618695974349976,1.0130492448806763,1.665381908416748),
Vector3(-0.36645668745040894,1.0130492448806763,1.665381908416748),
Vector3(-0.2867264747619629,1.092779278755188,1.665381908416748),
Vector3(-0.2069959044456482,1.092779278755188,1.665381908416748),
Vector3(-0.28672653436660767,1.0130492448806763,1.665381908416748),
Vector3(-0.20699596405029297,1.0130492448806763,1.665381908416748),
Vector3(-0.04753535985946655,1.2522401809692383,1.6653820276260376),
Vector3(-0.1272655725479126,1.172509789466858,1.665381908416748),
Vector3(-0.04753535985946655,1.1725096702575684,1.6653820276260376),
Vector3(0.03219515085220337,1.2522401809692383,1.6653820276260376),
Vector3(0.11192542314529419,1.2522401809692383,1.6653820276260376),
Vector3(0.11192542314529419,1.1725096702575684,1.6653820276260376),
Vector3(-0.1272655725479126,1.092779278755188,1.665381908416748),
Vector3(-0.04753535985946655,1.0927791595458984,1.6653820276260376),
Vector3(-0.12726569175720215,1.0130492448806763,1.665381908416748),
Vector3(-0.047535479068756104,1.0130491256713867,1.6653820276260376),
Vector3(-0.44618695974349976,1.172510027885437,1.7451121807098389),
Vector3(-0.36645668745040894,1.172510027885437,1.7451121807098389),
Vector3(-0.44618695974349976,1.1725099086761475,1.8248423337936401),
Vector3(-0.36645668745040894,1.1725099086761475,1.8248423337936401),
Vector3(-0.2867264747619629,1.172510027885437,1.7451121807098389),
Vector3(-0.2069959044456482,1.172510027885437,1.7451121807098389),
Vector3(-0.2867264747619629,1.1725099086761475,1.8248423337936401),
Vector3(-0.2069959044456482,1.1725099086761475,1.8248423337936401),
Vector3(-0.36645668745040894,1.172509789466858,1.9045729637145996),
Vector3(-0.28672653436660767,1.172509789466858,1.9045729637145996),
Vector3(-0.20699596405029297,1.172509789466858,1.9045729637145996),
Vector3(-0.44618695974349976,1.092779517173767,1.7451121807098389),
Vector3(-0.36645668745040894,1.092779517173767,1.7451121807098389),
Vector3(-0.44618695974349976,1.0927793979644775,1.8248423337936401),
Vector3(-0.36645668745040894,1.0927793979644775,1.8248423337936401),
Vector3(-0.44618695974349976,1.092779278755188,1.9045729637145996),
Vector3(-0.36645668745040894,1.092779278755188,1.9045729637145996),
Vector3(-0.44618695974349976,1.092779517173767,1.9843032360076904),
Vector3(-0.36645668745040894,1.092779517173767,1.9843032360076904),
Vector3(-0.44618695974349976,1.0130490064620972,1.9843032360076904),
Vector3(-0.36645668745040894,1.0130490064620972,1.9843032360076904),
Vector3(-0.28672653436660767,1.092779278755188,1.9045729637145996),
Vector3(-0.20699596405029297,1.092779278755188,1.9045729637145996),
Vector3(-0.28672653436660767,1.092779517173767,1.9843032360076904),
Vector3(-0.20699596405029297,1.092779517173767,1.9843032360076904),
Vector3(-0.28672653436660767,1.0130490064620972,1.9843032360076904),
Vector3(-0.20699596405029297,1.0130490064620972,1.9843032360076904),
Vector3(-0.04753535985946655,1.2522401809692383,1.7451122999191284),
Vector3(-0.04753535985946655,1.2522403001785278,1.8248424530029297),
Vector3(-0.1272655725479126,1.172509789466858,1.7451121807098389),
Vector3(-0.04753535985946655,1.1725099086761475,1.7451122999191284),
Vector3(-0.1272655725479126,1.1725099086761475,1.8248423337936401),
Vector3(-0.04753535985946655,1.172509789466858,1.8248424530029297),
Vector3(0.03219515085220337,1.2522401809692383,1.7451122999191284),
Vector3(0.11192542314529419,1.2522401809692383,1.7451122999191284),
Vector3(0.03219515085220337,1.2522403001785278,1.8248424530029297),
Vector3(0.11192542314529419,1.2522403001785278,1.8248424530029297),
Vector3(0.11192542314529419,1.1725099086761475,1.7451122999191284),
Vector3(0.03219515085220337,1.172509789466858,1.8248424530029297),
Vector3(0.11192542314529419,1.172509789466858,1.8248424530029297),
Vector3(-0.12726569175720215,1.172509789466858,1.9045729637145996),
Vector3(-0.047535479068756104,1.1725096702575684,1.9045730829238892),
Vector3(0.032195091247558594,1.1725096702575684,1.9045730829238892),
Vector3(0.11192542314529419,1.1725096702575684,1.9045730829238892),
Vector3(0.11192542314529419,1.092779278755188,1.8248424530029297),
Vector3(0.11192542314529419,1.0130488872528076,1.7451122999191284),
Vector3(0.11192536354064941,1.0130490064620972,1.8248424530029297),
Vector3(-0.12726569175720215,1.092779278755188,1.9045729637145996),
Vector3(-0.047535479068756104,1.0927791595458984,1.9045730829238892),
Vector3(-0.12726569175720215,1.092779278755188,1.9843032360076904),
Vector3(-0.047535479068756104,1.092779278755188,1.9843032360076904),
Vector3(-0.12726569175720215,1.0130492448806763,1.9045729637145996),
Vector3(-0.047535479068756104,1.0130491256713867,1.9045730829238892),
Vector3(-0.12726569175720215,1.0130490064620972,1.9843032360076904),
Vector3(-0.047535479068756104,1.0130490064620972,1.9843032360076904),
Vector3(0.032195091247558594,1.0927791595458984,1.9045730829238892),
Vector3(0.11192536354064941,1.0927791595458984,1.9045730829238892),
Vector3(0.032195091247558594,1.0130491256713867,1.9045730829238892),
Vector3(0.11192536354064941,1.0130491256713867,1.9045730829238892),
Vector3(-0.44618695974349976,0.9333187341690063,1.665381908416748),
Vector3(-0.36645668745040894,0.9333187341690063,1.665381908416748),
Vector3(-0.44618695974349976,0.8535882234573364,1.665381908416748),
Vector3(-0.36645668745040894,0.8535882234573364,1.665381908416748),
Vector3(-0.28672653436660767,0.9333187341690063,1.665381908416748),
Vector3(-0.20699596405029297,0.9333187341690063,1.665381908416748),
Vector3(-0.28672653436660767,0.8535882234573364,1.665381908416748),
Vector3(-0.12726569175720215,0.9333187341690063,1.665381908416748),
Vector3(-0.047535479068756104,0.9333188533782959,1.6653820276260376),
Vector3(0.032195091247558594,0.9333188533782959,1.6653820276260376),
Vector3(0.11192536354064941,0.9333188533782959,1.6653820276260376),
Vector3(-0.44618695974349976,0.8535884618759155,1.7451121807098389),
Vector3(-0.36645668745040894,0.8535884618759155,1.7451121807098389),
Vector3(-0.44618695974349976,0.853588342666626,1.8248423337936401),
Vector3(-0.36645668745040894,0.853588342666626,1.8248423337936401),
Vector3(-0.28672653436660767,0.9333189725875854,1.7451121807098389),
Vector3(-0.20699596405029297,0.9333189725875854,1.7451121807098389),
Vector3(-0.28672653436660767,0.8535884618759155,1.7451121807098389),
Vector3(-0.20699596405029297,0.8535884618759155,1.7451121807098389),
Vector3(-0.28672653436660767,0.853588342666626,1.8248423337936401),
Vector3(-0.20699596405029297,0.853588342666626,1.8248423337936401),
Vector3(-0.36645668745040894,0.9333187341690063,1.9045729637145996),
Vector3(-0.44618695974349976,0.9333187341690063,1.9843032360076904),
Vector3(-0.36645668745040894,0.9333187341690063,1.9843032360076904),
Vector3(-0.44618695974349976,0.8535882234573364,1.9045729637145996),
Vector3(-0.36645668745040894,0.8535882234573364,1.9045729637145996),
Vector3(-0.4461870789527893,0.8535882234573364,1.9843032360076904),
Vector3(-0.3664568066596985,0.8535882234573364,1.9843032360076904),
Vector3(-0.28672653436660767,0.9333187341690063,1.9045729637145996),
Vector3(-0.20699596405029297,0.9333187341690063,1.9045729637145996),
Vector3(-0.28672653436660767,0.9333187341690063,1.9843032360076904),
Vector3(-0.20699596405029297,0.9333187341690063,1.9843032360076904),
Vector3(-0.28672653436660767,0.8535882234573364,1.9045729637145996),
Vector3(-0.20699596405029297,0.8535882234573364,1.9045729637145996),
Vector3(-0.12726569175720215,0.9333189725875854,1.7451121807098389),
Vector3(-0.047535479068756104,0.9333188533782959,1.7451122999191284),
Vector3(-0.12726569175720215,0.9333188533782959,1.8248423337936401),
Vector3(-0.047535479068756104,0.9333187341690063,1.8248424530029297),
Vector3(-0.12726569175720215,0.8535884618759155,1.7451121807098389),
Vector3(-0.12726569175720215,0.853588342666626,1.8248423337936401),
Vector3(0.032195091247558594,0.9333188533782959,1.7451122999191284),
Vector3(0.11192536354064941,0.9333188533782959,1.7451122999191284),
Vector3(0.032195091247558594,0.9333187341690063,1.8248424530029297),
Vector3(0.11192536354064941,0.9333187341690063,1.8248424530029297),
Vector3(-0.12726569175720215,0.9333187341690063,1.9045729637145996),
Vector3(-0.047535479068756104,0.9333188533782959,1.9045730829238892),
Vector3(-0.12726569175720215,0.9333187341690063,1.9843032360076904),
Vector3(-0.12726569175720215,0.8535882234573364,1.9045729637145996),
Vector3(0.032195091247558594,0.9333188533782959,1.9045730829238892),
Vector3(0.11192536354064941,0.9333186149597168,1.9045730829238892),
Vector3(0.19165581464767456,1.2522401809692383,1.6653820276260376),
Vector3(0.19165581464767456,1.1725096702575684,1.6653820276260376),
Vector3(0.27138620615005493,1.1725096702575684,1.6653820276260376),
Vector3(0.19165578484535217,1.0927791595458984,1.6653820276260376),
Vector3(0.27138617634773254,1.0927791595458984,1.6653820276260376),
Vector3(0.19165578484535217,1.0130491256713867,1.6653820276260376),
Vector3(0.27138617634773254,1.0130491256713867,1.6653820276260376),
Vector3(0.19165581464767456,1.1725099086761475,1.7451122999191284),
Vector3(0.19165578484535217,1.172509789466858,1.8248424530029297),
Vector3(0.19165578484535217,1.0927793979644775,1.7451122999191284),
Vector3(0.19165578484535217,1.092779278755188,1.8248424530029297),
Vector3(0.19165578484535217,1.0130488872528076,1.7451122999191284),
Vector3(0.19165575504302979,1.0130490064620972,1.8248424530029297),
Vector3(0.19165575504302979,1.0927791595458984,1.9045730829238892),
Vector3(0.19165575504302979,1.0130491256713867,1.9045730829238892),
Vector3(0.19165575504302979,0.9333186149597168,1.6653820276260376),
Vector3(0.19165575504302979,0.9333188533782959,1.7451122999191284),
Vector3(-0.7651087641716003,0.4549367427825928,1.665381669998169),
Vector3(-0.6853782534599304,0.4549367427825928,1.665381669998169),
Vector3(-0.7651087641716003,0.37520623207092285,1.665381669998169),
Vector3(-0.6853782534599304,0.37520623207092285,1.665381669998169),
Vector3(-0.60564786195755,0.4549368619918823,1.665381908416748),
Vector3(-0.5259175896644592,0.4549368619918823,1.665381908416748),
Vector3(-0.60564786195755,0.3752063512802124,1.665381908416748),
Vector3(-0.5259175896644592,0.3752063512802124,1.665381908416748),
Vector3(-0.8448389172554016,0.5346670150756836,1.7451119422912598),
Vector3(-0.8448389172554016,0.5346672534942627,1.8248422145843506),
Vector3(-0.8448389172554016,0.5346672534942627,1.9045727252960205),
Vector3(-0.8448389172554016,0.5346670150756836,1.9843029975891113),
Vector3(-0.9245691895484924,0.4549369812011719,1.7451119422912598),
Vector3(-0.8448389172554016,0.4549369812011719,1.7451119422912598),
Vector3(-0.9245691895484924,0.4549367427825928,1.8248422145843506),
Vector3(-0.8448389172554016,0.4549367427825928,1.8248422145843506),
Vector3(-0.9245691895484924,0.37520647048950195,1.7451119422912598),
Vector3(-0.8448389172554016,0.37520647048950195,1.7451119422912598),
Vector3(-0.9245691895484924,0.37520623207092285,1.8248422145843506),
Vector3(-0.9245691895484924,0.4549367427825928,1.9045727252960205),
Vector3(-0.8448389172554016,0.4549367427825928,1.9045727252960205),
Vector3(-0.8448389172554016,0.4549367427825928,1.9843029975891113),
Vector3(-0.9245691895484924,0.37520623207092285,1.9045727252960205),
Vector3(-0.8448389172554016,0.37520623207092285,1.9045727252960205),
Vector3(-0.9245691895484924,0.37520623207092285,1.9843029975891113),
Vector3(-0.8448389172554016,0.37520623207092285,1.9843029975891113),
Vector3(-0.7651087641716003,0.5346670150756836,1.7451119422912598),
Vector3(-0.6853782534599304,0.5346670150756836,1.7451119422912598),
Vector3(-0.7651087641716003,0.5346672534942627,1.8248422145843506),
Vector3(-0.6853782534599304,0.5346670150756836,1.8248422145843506),
Vector3(-0.60564786195755,0.5346671342849731,1.7451121807098389),
Vector3(-0.5259175896644592,0.5346671342849731,1.7451121807098389),
Vector3(-0.60564786195755,0.5346670150756836,1.8248422145843506),
Vector3(-0.5259175896644592,0.5346670150756836,1.8248422145843506),
Vector3(-0.7651087641716003,0.5346672534942627,1.9045727252960205),
Vector3(-0.6853782534599304,0.5346670150756836,1.9045727252960205),
Vector3(-0.7651087641716003,0.5346670150756836,1.9843029975891113),
Vector3(-0.6853782534599304,0.5346670150756836,1.9843029975891113),
Vector3(-0.60564786195755,0.5346671342849731,1.9045729637145996),
Vector3(-0.5259175896644592,0.5346671342849731,1.9045729637145996),
Vector3(-0.7651087641716003,0.4549369812011719,1.7451119422912598),
Vector3(-0.6853782534599304,0.4549367427825928,1.7451119422912598),
Vector3(-0.7651087641716003,0.37520623207092285,1.7451119422912598),
Vector3(-0.60564786195755,0.4549368619918823,1.7451121807098389),
Vector3(-0.5259175896644592,0.4549368619918823,1.7451121807098389),
Vector3(-0.5259175896644592,0.4549367427825928,1.8248422145843506),
Vector3(-0.6853782534599304,0.4549367427825928,1.9045727252960205),
Vector3(-0.7651087641716003,0.4549367427825928,1.9843029975891113),
Vector3(-0.6853782534599304,0.4549367427825928,1.9843029975891113),
Vector3(-0.7651087641716003,0.37520623207092285,1.9843029975891113),
Vector3(-0.6853782534599304,0.37520623207092285,1.9843029975891113),
Vector3(-0.60564786195755,0.4549368619918823,1.9045729637145996),
Vector3(-0.5259175896644592,0.4549366235733032,1.90457284450531),
Vector3(-0.60564786195755,0.4549368619918823,1.9843032360076904),
Vector3(-0.5259175896644592,0.4549368619918823,1.9843031167984009),
Vector3(-0.60564786195755,0.3752063512802124,1.9843032360076904),
Vector3(-0.5259175896644592,0.3752063512802124,1.9843031167984009),
Vector3(-0.7651087641716003,0.29547595977783203,1.665381669998169),
Vector3(-0.6853782534599304,0.29547595977783203,1.665381669998169),
Vector3(-0.60564786195755,0.29547595977783203,1.6653817892074585),
Vector3(-0.5259175896644592,0.29547595977783203,1.6653817892074585),
Vector3(-0.60564786195755,0.21574580669403076,1.665381908416748),
Vector3(-0.5259175896644592,0.21574580669403076,1.665381908416748),
Vector3(-0.9245691895484924,0.29547595977783203,1.7451119422912598),
Vector3(-0.8448389172554016,0.29547595977783203,1.7451119422912598),
Vector3(-0.9245691895484924,0.29547595977783203,1.8248422145843506),
Vector3(-0.8448389172554016,0.29547595977783203,1.8248422145843506),
Vector3(-0.8448389172554016,0.21574580669403076,1.7451119422912598),
Vector3(-0.8448390364646912,0.2157456874847412,1.8248422145843506),
Vector3(-0.924569308757782,0.29547595977783203,1.9045727252960205),
Vector3(-0.8448390364646912,0.29547595977783203,1.9045727252960205),
Vector3(-0.924569308757782,0.29547595977783203,1.9843029975891113),
Vector3(-0.8448390364646912,0.29547595977783203,1.9843029975891113),
Vector3(-0.7651087641716003,0.29547595977783203,1.7451119422912598),
Vector3(-0.6853782534599304,0.29547595977783203,1.7451119422912598),
Vector3(-0.7651087641716003,0.29547595977783203,1.8248422145843506),
Vector3(-0.7651087641716003,0.21574580669403076,1.7451119422912598),
Vector3(-0.6853782534599304,0.21574580669403076,1.7451119422912598),
Vector3(-0.7651088833808899,0.2157456874847412,1.8248422145843506),
Vector3(-0.68537837266922,0.2157456874847412,1.8248422145843506),
Vector3(-0.60564786195755,0.2954760789871216,1.7451120615005493),
Vector3(-0.60564786195755,0.2157456874847412,1.7451121807098389),
Vector3(-0.5259175896644592,0.2157456874847412,1.7451121807098389),
Vector3(-0.6056479811668396,0.2157456874847412,1.8248422145843506),
Vector3(-0.5259178280830383,0.2157456874847412,1.8248422145843506),
Vector3(-0.7651088833808899,0.29547595977783203,1.9045727252960205),
Vector3(-0.68537837266922,0.29547595977783203,1.9045727252960205),
Vector3(-0.7651088833808899,0.29547595977783203,1.9843029975891113),
Vector3(-0.68537837266922,0.29547595977783203,1.9843029975891113),
Vector3(-0.7651088833808899,0.2157456874847412,1.9045727252960205),
Vector3(-0.68537837266922,0.2157456874847412,1.9045727252960205),
Vector3(-0.6056479811668396,0.2954760789871216,1.90457284450531),
Vector3(-0.6056479811668396,0.2954758405685425,1.9843031167984009),
Vector3(-0.5259178280830383,0.2954758405685425,1.9843031167984009),
Vector3(-0.6056479811668396,0.21574580669403076,1.9045729637145996),
Vector3(-0.5259178280830383,0.21574580669403076,1.9045729637145996),
Vector3(-0.6056479811668396,0.21574580669403076,1.9843032360076904),
Vector3(-0.5259178280830383,0.21574580669403076,1.9843032360076904),
Vector3(-0.4461870789527893,0.4549368619918823,1.6653817892074585),
Vector3(-0.3664568066596985,0.4549368619918823,1.6653817892074585),
Vector3(-0.4461870789527893,0.3752063512802124,1.6653817892074585),
Vector3(-0.3664568066596985,0.3752063512802124,1.6653817892074585),
Vector3(-0.28672659397125244,0.4549366235733032,1.6653817892074585),
Vector3(-0.28672659397125244,0.3752063512802124,1.6653817892074585),
Vector3(-0.20699602365493774,0.3752061128616333,1.6653817892074585),
Vector3(-0.12726575136184692,0.3752061128616333,1.6653817892074585),
Vector3(-0.04753553867340088,0.37520623207092285,1.665381908416748),
Vector3(0.03219503164291382,0.37520623207092285,1.665381908416748),
Vector3(0.11192524433135986,0.37520623207092285,1.665381908416748),
Vector3(-0.4461870789527893,0.4549368619918823,1.7451120615005493),
Vector3(-0.3664568066596985,0.4549368619918823,1.7451120615005493),
Vector3(-0.4461870789527893,0.4549367427825928,1.8248422145843506),
Vector3(-0.3664568066596985,0.4549367427825928,1.8248422145843506),
Vector3(-0.28672659397125244,0.4549368619918823,1.7451120615005493),
Vector3(-0.20699602365493774,0.4549368619918823,1.7451120615005493),
Vector3(-0.28672659397125244,0.4549367427825928,1.8248422145843506),
Vector3(-0.20699602365493774,0.4549367427825928,1.8248422145843506),
Vector3(-0.2867266535758972,0.3752063512802124,1.7451120615005493),
Vector3(-0.20699608325958252,0.3752063512802124,1.7451120615005493),
Vector3(-0.44618719816207886,0.4549366235733032,1.90457284450531),
Vector3(-0.36645692586898804,0.4549366235733032,1.90457284450531),
Vector3(-0.44618719816207886,0.4549366235733032,1.9843031167984009),
Vector3(-0.36645692586898804,0.4549366235733032,1.9843031167984009),
Vector3(-0.36645692586898804,0.3752061128616333,1.90457284450531),
Vector3(-0.44618719816207886,0.3752063512802124,1.9843031167984009),
Vector3(-0.36645692586898804,0.3752063512802124,1.9843031167984009),
Vector3(-0.2867266535758972,0.4549366235733032,1.90457284450531),
Vector3(-0.20699608325958252,0.4549366235733032,1.90457284450531),
Vector3(-0.2867266535758972,0.3752061128616333,1.90457284450531),
Vector3(-0.20699608325958252,0.3752061128616333,1.90457284450531),
Vector3(-0.2867266535758972,0.3752061128616333,1.9843031167984009),
Vector3(-0.20699608325958252,0.3752061128616333,1.9843031167984009),
Vector3(-0.12726575136184692,0.4549368619918823,1.7451120615005493),
Vector3(-0.12726575136184692,0.4549367427825928,1.8248422145843506),
Vector3(-0.1272658109664917,0.3752061128616333,1.7451120615005493),
Vector3(-0.047535598278045654,0.37520623207092285,1.7451121807098389),
Vector3(-0.1272658109664917,0.37520623207092285,1.8248422145843506),
Vector3(-0.047535598278045654,0.3752061128616333,1.8248422145843506),
Vector3(0.03219497203826904,0.37520623207092285,1.7451121807098389),
Vector3(0.11192524433135986,0.37520623207092285,1.7451121807098389),
Vector3(0.03219497203826904,0.3752061128616333,1.8248422145843506),
Vector3(0.11192524433135986,0.3752061128616333,1.8248423337936401),
Vector3(-0.1272658109664917,0.4549366235733032,1.90457284450531),
Vector3(-0.1272658109664917,0.3752061128616333,1.90457284450531),
Vector3(-0.047535598278045654,0.37520623207092285,1.9045729637145996),
Vector3(-0.1272658109664917,0.3752061128616333,1.9843031167984009),
Vector3(0.03219497203826904,0.37520623207092285,1.9045729637145996),
Vector3(0.11192524433135986,0.37520599365234375,1.9045729637145996),
Vector3(-0.44618719816207886,0.29547595977783203,1.6653817892074585),
Vector3(-0.36645692586898804,0.29547595977783203,1.6653817892074585),
Vector3(-0.44618719816207886,0.2157456874847412,1.6653817892074585),
Vector3(-0.36645692586898804,0.2157456874847412,1.6653817892074585),
Vector3(-0.2867266535758972,0.29547595977783203,1.6653817892074585),
Vector3(-0.20699608325958252,0.29547595977783203,1.6653817892074585),
Vector3(-0.2867266535758972,0.2157456874847412,1.6653817892074585),
Vector3(-0.20699608325958252,0.2157456874847412,1.6653817892074585),
Vector3(-0.36645692586898804,0.1360151767730713,1.6653817892074585),
Vector3(-0.2867266535758972,0.1360151767730713,1.6653817892074585),
Vector3(-0.20699608325958252,0.1360151767730713,1.6653817892074585),
Vector3(-0.1272658109664917,0.2954758405685425,1.665381669998169),
Vector3(-0.047535598278045654,0.29547595977783203,1.665381908416748),
Vector3(-0.1272658109664917,0.2157456874847412,1.6653817892074585),
Vector3(-0.047535598278045654,0.2157456874847412,1.665381908416748),
Vector3(-0.1272658109664917,0.13601505756378174,1.665381669998169),
Vector3(-0.047535598278045654,0.1360151767730713,1.665381908416748),
Vector3(-0.047535598278045654,0.05628478527069092,1.665381908416748),
Vector3(0.11192524433135986,0.13601505756378174,1.665381908416748),
Vector3(0.03219497203826904,0.05628478527069092,1.665381908416748),
Vector3(0.11192518472671509,0.05628478527069092,1.665381908416748),
Vector3(-0.44618719816207886,0.2157456874847412,1.7451120615005493),
Vector3(-0.36645692586898804,0.2157456874847412,1.7451120615005493),
Vector3(-0.44618719816207886,0.2157456874847412,1.8248422145843506),
Vector3(-0.36645692586898804,0.2157456874847412,1.8248422145843506),
Vector3(-0.44618719816207886,0.2954758405685425,1.9843031167984009),
Vector3(-0.36645692586898804,0.2954758405685425,1.9843031167984009),
Vector3(-0.44618719816207886,0.21574556827545166,1.90457284450531),
Vector3(-0.36645692586898804,0.21574556827545166,1.90457284450531),
Vector3(-0.44618719816207886,0.21574580669403076,1.9843031167984009),
Vector3(-0.36645692586898804,0.21574580669403076,1.9843031167984009),
Vector3(-0.2867266535758972,0.2954758405685425,1.9843031167984009),
Vector3(-0.20699608325958252,0.2954758405685425,1.9843031167984009),
Vector3(-0.2867266535758972,0.21574556827545166,1.90457284450531),
Vector3(-0.20699608325958252,0.21574556827545166,1.90457284450531),
Vector3(-0.2867266535758972,0.21574556827545166,1.9843031167984009),
Vector3(-0.20699608325958252,0.21574556827545166,1.9843031167984009),
Vector3(-0.44618719816207886,0.1360151767730713,1.7451120615005493),
Vector3(-0.36645692586898804,0.1360151767730713,1.7451120615005493),
Vector3(-0.44618719816207886,0.1360151767730713,1.8248422145843506),
Vector3(-0.36645692586898804,0.1360151767730713,1.8248422145843506),
Vector3(-0.2867266535758972,0.1360151767730713,1.7451120615005493),
Vector3(-0.20699608325958252,0.1360151767730713,1.7451120615005493),
Vector3(-0.2867266535758972,0.1360151767730713,1.8248422145843506),
Vector3(-0.20699608325958252,0.1360151767730713,1.8248422145843506),
Vector3(-0.36645692586898804,0.13601505756378174,1.90457284450531),
Vector3(-0.2867266535758972,0.13601505756378174,1.90457284450531),
Vector3(-0.20699608325958252,0.13601505756378174,1.90457284450531),
Vector3(0.11192524433135986,0.29547595977783203,1.7451121807098389),
Vector3(0.11192524433135986,0.2954758405685425,1.8248423337936401),
Vector3(0.11192524433135986,0.21574556827545166,1.8248423337936401),
Vector3(-0.1272658109664917,0.2954758405685425,1.9045727252960205),
Vector3(-0.047535598278045654,0.29547595977783203,1.9045729637145996),
Vector3(-0.1272658109664917,0.2954758405685425,1.9843029975891113),
Vector3(-0.047535598278045654,0.2954758405685425,1.9843029975891113),
Vector3(-0.1272658109664917,0.21574556827545166,1.90457284450531),
Vector3(-0.047535598278045654,0.2157456874847412,1.9045729637145996),
Vector3(-0.1272658109664917,0.21574556827545166,1.9843031167984009),
Vector3(-0.047535598278045654,0.21574556827545166,1.9843031167984009),
Vector3(0.03219497203826904,0.29547595977783203,1.9045729637145996),
Vector3(0.11192524433135986,0.29547595977783203,1.9045729637145996),
Vector3(0.03219497203826904,0.2157456874847412,1.9045729637145996),
Vector3(0.11192518472671509,0.2157454490661621,1.9045729637145996),
Vector3(-0.1272658109664917,0.13601505756378174,1.7451119422912598),
Vector3(-0.047535598278045654,0.13601505756378174,1.7451121807098389),
Vector3(-0.1272658109664917,0.13601505756378174,1.8248422145843506),
Vector3(-0.047535598278045654,0.13601505756378174,1.8248422145843506),
Vector3(-0.047535598278045654,0.05628478527069092,1.7451121807098389),
Vector3(-0.04753565788269043,0.05628478527069092,1.8248422145843506),
Vector3(0.11192524433135986,0.13601505756378174,1.7451121807098389),
Vector3(0.03219497203826904,0.13601505756378174,1.8248422145843506),
Vector3(0.11192518472671509,0.13601505756378174,1.8248423337936401),
Vector3(0.03219497203826904,0.05628478527069092,1.7451121807098389),
Vector3(0.11192518472671509,0.05628478527069092,1.7451121807098389),
Vector3(0.03219491243362427,0.05628478527069092,1.8248422145843506),
Vector3(0.11192518472671509,0.05628478527069092,1.8248422145843506),
Vector3(-0.1272658109664917,0.13601505756378174,1.9045727252960205),
Vector3(-0.047535598278045654,0.1360151767730713,1.9045729637145996),
Vector3(0.03219497203826904,0.1360151767730713,1.9045729637145996),
Vector3(0.11192518472671509,0.1360149383544922,1.9045729637145996),
Vector3(0.19165563583374023,0.37520623207092285,1.665381908416748),
Vector3(0.19165563583374023,0.37520623207092285,1.7451121807098389),
Vector3(0.19165563583374023,0.2954758405685425,1.665381908416748),
Vector3(0.2713860273361206,0.2954758405685425,1.665381908416748),
Vector3(0.19165560603141785,0.21574556827545166,1.665381908416748),
Vector3(0.2713859975337982,0.21574556827545166,1.665381908416748),
Vector3(0.19165560603141785,0.13601505756378174,1.665381908416748),
Vector3(0.2713859975337982,0.13601505756378174,1.665381908416748),
Vector3(0.19165557622909546,0.05628478527069092,1.665381908416748),
Vector3(0.19165563583374023,0.29547595977783203,1.7451121807098389),
Vector3(0.19165560603141785,0.2954758405685425,1.8248423337936401),
Vector3(0.19165560603141785,0.21574556827545166,1.7451121807098389),
Vector3(0.19165560603141785,0.21574556827545166,1.8248423337936401),
Vector3(0.19165560603141785,0.29547595977783203,1.9045729637145996),
Vector3(0.19165557622909546,0.2157454490661621,1.9045729637145996),
Vector3(0.19165560603141785,0.13601505756378174,1.7451121807098389),
Vector3(0.19165557622909546,0.13601505756378174,1.8248423337936401)
    ]
}