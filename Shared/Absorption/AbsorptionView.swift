//
//  AbsorptionView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import SwiftUI

/// A small structure for containing color labels
struct colLabels: Identifiable {
    let id: String
    let color: Color
    let label: String
}

struct AbsorptionView: View {
    @State var totPartNum: Int = 0
    @ObservedObject var particleCollect: PointCollect<Particle> = PointCollect<Particle>()
    @State var addPart: String = ""
    @State var subEnergy: String = "10.0"
    @State var meanPathLen: String = "1.0"
    @State var runUntilActive: Bool = false
    @State var colCounts: [Color: Int] = [:]

    
    let dispBox = Box(newDims: [700.0, 700.0], newCen: [0.0, 0.0])
    let scaleBox = Box(newDims: [15.0, 15.0], newCen: [0.0, 0.0])
    let detectBox = Box(newDims: [10.0, 12.5], newCen: [0.0, 0.0])
    
    let colorDict: [String: Color] = [
        "Active": Color.red,
        "No Energy": Color.blue,
        "Esceped Detector": Color.orange,
        "Escaped Simulation": Color.gray
    ]
    
    //Represents where the beam is initially generated
    var beam = Box(newDims: [1.0, 2 * Double.pi], newCen: [-4.0, 0])
    
    //A "box" in spherical coordinates in order to help generate the random directions of the particle
    var parDir = Box(newDims: [1.0, 1.5 * Double.pi], newCen: [0.5, 0.0])
    
    var body: some View {
        let squishedDetect = dispBox.squishBox(oBox: detectBox, scaleBox: scaleBox, inPlace: false)
        let colorLabelStruc: [colLabels] = colorDict.map({ colLabels(id: "\($0)", color: $1, label: $0) })
        
        //Simulation configuration pieces
        HStack {
            VStack {
                Text("Number of Particles: \(particleCollect.count)")
                HStack {
                    Text("Manage Particles: ")
                    TextField("Number of particles to add", text: $addPart)
                    Button("Add particles", action: {
                        for _ in 0..<(Int(addPart) ?? 0) {
                            addParticle()
                        }
                        
                        colCounts = countTypes()
                    })
                    
                    Button("Clear particles", action: {
                        particleCollect.removeAll()
                        
                        colCounts = [:]
                    })
                }
                
                HStack {
                    Text("Energy percentage cost:")
                    TextField("% of energy lost", text: $subEnergy)
                }
                
                HStack {
                    Text("Mean Path Length: ")
                    TextField("Mean path", text: $meanPathLen, onCommit: {parDir.dims[0] = Double(meanPathLen) ?? 1.0})
                }
                
                HStack {
//                    Button("Iterate Once", action: {Task { await particleCollect.applyFunc(fun: iterParticles(part:), proccessorCount: 3) }})
                    Button("Process Simulation", action: {
                        if (runUntilActive) {
                            while ((countTypes()[colorDict["Active"] ?? Color.black] ?? 0) != 0) {
                                iterParticles(containBox: squishedDetect)
                            }
                        } else {
                            iterParticles(containBox: squishedDetect)
                        }
                        
                        colCounts = countTypes()
                    })
                    Toggle("Run until non-active", isOn: $runUntilActive)
                }
                
                VStack {
                    if (!colCounts.isEmpty) {
                        ForEach(colorLabelStruc) { colType in
                            Text("State: \(colType.label), Count: \(colCounts[colType.color] ?? 0)")
                        }
                    }
                }
            }
            
            //Simulation window
            AbsSimView(pointArr: particleCollect.pointArr, detectBox: squishedDetect)
                .frame(width: dispBox.getLength(dimNum: 0), height: dispBox.getLength(dimNum: 1))
        }
    }
    
    
    /// Adds a single point to the pointArr. Effectively generating a single point
    func addParticle() {
        let pt = beam.getCentralPoint()
        
        do {
            try pt.absMove(nPt: [pt.x * cos(pt.y), pt.x * sin(pt.y)])
            try pt.move(nPt: (0..<beam.count).map({
                beam.getCenter(dimNum: $0)
            }))
        } catch {
            print("Failed to convert")
        }
        
        particleCollect.append(newElement: Particle(oPt: dispBox.squishPt(pt: pt, bBox: scaleBox, inPlace: true, mods: [1.0, -1.0]), col: colorDict["Active"] ?? Color.red))
    }
    
    func iterParticles(containBox: Box) {
        for i in 0..<particleCollect.count {
            if (particleCollect[i].is_moving && containBox.isInside(testpt: particleCollect[i])) {
                let rngPt = parDir.getPoint()

                do {
                    try rngPt.absMove(nPt: [rngPt.x * cos(rngPt.y), rngPt.x * sin(rngPt.y)])
                } catch {
                    print("Failed to convert")
                }

                particleCollect[i].subEnergy(eng: Double(subEnergy) ?? 0.0)
                particleCollect[i].move(pt: dispBox.squishPt(pt: rngPt, bBox: scaleBox, inPlace: true))

                if (!particleCollect[i].is_moving) {
                    particleCollect[i].col = colorDict["No Energy"] ?? Color.black
                }
                
                if (!containBox.isInside(testpt: particleCollect[i])) {
                    particleCollect[i].col = colorDict["Esceped Detector"] ?? Color.black
                }
                
                if (!dispBox.isInside(testpt: particleCollect[i])) {
                    do {
                        try rngPt.absMove(nPt: [-1.0 * rngPt.x, -1.0 * rngPt.y])
                    } catch {
                        print("Failed to reverse the random point")
                    }
                    
                    particleCollect[i].move(pt: rngPt)
                    particleCollect[i].subEnergy(eng: 100.0)
                    particleCollect[i].col = colorDict["Escaped Simulation"] ?? Color.black
                }
            }
        }
    }
    
    func iterParticles(part: Particle) async {
        if (part.is_moving && scaleBox.isInside(testpt: part)) {
            let rngPt = parDir.getPoint()
            
            do {
                try rngPt.absMove(nPt: [rngPt.x * cos(rngPt.y), rngPt.x * sin(rngPt.y)])
            } catch {
                print("Failed to convert")
            }
            
            part.subEnergy(eng: Double(subEnergy) ?? 0.0)
            part.move(pt: dispBox.squishPt(pt: rngPt, bBox: scaleBox, inPlace: true))
            
            if (!part.is_moving) {
                part.col = Color.blue
            }
            
            if (!scaleBox.isInside(testpt: part)) {
                part.col = Color.green
            }
        }
    }
    
    func countTypes() -> Dictionary<Color, Int> {
        let cols = particleCollect.pointArr.map({$0.col})
        
        var colCount: [Color: Int] = [:]
        
        for color in Set(cols) {
            colCount[color] = cols.filter({$0 == color}).count
        }
        
        
        return colCount
    }
}

struct AbsorptionView_Previews: PreviewProvider {
    static var previews: some View {
        AbsorptionView()
    }
}
