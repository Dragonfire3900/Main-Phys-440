//
//  AbsorptionView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import SwiftUI



struct AbsorptionView: View {
    @State var partNum: Int = 100
    @State var pointArr: [ColorPoint] = []
    
    var dispBox = Box(newDims: [400.0, 400.0], newCen: [0.0, 0.0])
    var detectBox = Box(newDims: [10.0, 10.0], newCen: [0.0, 0.0])
    
    //Represents where the beam is initially generated
    var beam = Box()
    
    //A "box" in spherical coordinates in order to generate the initial direction of particles in the beam. Allows the control of beam focus
    var beamDir = Box(newDims: [1.0, Double.pi/6], newCen: [0.5, 0.0])
    
    //A "box" in spherical coordinates in order to help generate the random directions of the particle
    var parDir = Box(newDims: [1.0, Double.pi], newCen: [0.5, Double.pi / 2.0])
    
    var body: some View {
        //Simulation configuration pieces
        VStack {
            HStack {
                Text("Number of Particles")
            }
            
            //Simulation window
            AbsSimView(pointArr: pointArr)
                .frame(width: 300, height: 300)
        }
    }
}

struct AbsorptionView_Previews: PreviewProvider {
    static var previews: some View {
        AbsorptionView()
    }
}
