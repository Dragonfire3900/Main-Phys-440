//
//  AbsorptionView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import SwiftUI



struct AbsorptionView: View {
    @State var totPartNum: Int = 0
    @State var pointArr: [Particle] = []
    @State var addPart: String = ""
    @State var subEnergy: Double = 10.0
    
    let dispBox = Box(newDims: [700.0, 700.0], newCen: [0.0, 0.0])
    let scaleBox = Box(newDims: [15.0, 15.0], newCen: [0.0, 0.0])
    let detectBox = Box(newDims: [10.0, 10.0], newCen: [0.0, 0.0])
    
    //Represents where the beam is initially generated
    var beam = Box(newDims: [1.0, 2 * Double.pi], newCen: [-5, 0])
    
    //A "box" in spherical coordinates in order to help generate the random directions of the particle
    var parDir = Box(newDims: [5.0, Double.pi], newCen: [2.5, -Double.pi / 2.0])
    
    var body: some View {
        //Simulation configuration pieces
        HStack {
            VStack {
                Text("Number of Particles: \(totPartNum)")
                HStack {
                    TextField("Number of particles to add", text: $addPart)
                    Button("Add particles", action: {
                        for _ in 0..<(Int(addPart) ?? 0) {
                            addParticle()
                        }
                    })
                    
                    Button("Clear particles", action: {
                        pointArr.removeAll()
                        totPartNum = 0
                    })
                }
                
                Button("Iterate Once", action: iterParticles)
            }
            
            //Simulation window
            AbsSimView(pointArr: pointArr, detectBox: detectBox)
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
        
        pointArr.append(Particle(oPt: dispBox.squishPt(pt: pt, bBox: scaleBox, inPlace: true, mods: [1.0, -1.0]), col: Color.red))
        
        totPartNum += 1
    }
    
    func iterParticles() {
        for i in 0..<pointArr.count {
            if (pointArr[i].is_moving) {
                let rngPt = parDir.getPoint()
                
                do {
                    try rngPt.absMove(nPt: [rngPt.x * cos(rngPt.y), rngPt.x * sin(rngPt.y)])
                } catch {
                    print("Failed to convert")
                }
                
                pointArr[i].subEnergy(eng: subEnergy)
                pointArr[i].move(pt: dispBox.squishPt(pt: rngPt, bBox: scaleBox, inPlace: true))
                
                if (!pointArr[i].is_moving) {
                    pointArr[i].col = Color.blue
                }
            }
        }
    }
    
    func taskifyFunc() {
        
    }
}

struct AbsorptionView_Previews: PreviewProvider {
    static var previews: some View {
        AbsorptionView()
    }
}
