//
//  AbsorptionView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import SwiftUI



struct AbsorptionView: View {
    var body: some View {
        //Simulation configuration pieces
        HStack {
            Text("Number of Particles")
        }
        
        
        //Simulation window
        SimView()
            .frame(width: 300, height: 300)
    }
}

struct AbsorptionView_Previews: PreviewProvider {
    static var previews: some View {
        AbsorptionView()
    }
}
