//
//  ContentView.swift
//  Shared
//
//  Created by Joel Kelsey on 1/28/21.
//

import SwiftUI

struct ContentView: View {

    @State var radius = "1.0"
    @State var sphereArea = ""
    @State var sphereVolume = ""

    @State var bbArea = ""
    @State var bbVolume = ""

    var body: some View {
        VStack{
            //Radius Spot
            Text("Radius")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("Radius", text: $radius, onCommit: {
                //Sphere
                sphereArea = 4.0 * Double.pi * Double(radius) * Double(radius)
                sphereVolume = 4.0 / 3.0 * Double.pi * Double(radius) * Double(radius) * Double(radius)

                //Bounding Box
                bbArea = 6 * (2 * Double(radius)) * (2 * Double(radius))
                bbVolume = (2 * Double(radius)) * (2 * Double(radius)) * (2 * Double(radius))
            })
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)
            

            //Area Spot
            Text("Sphere Area")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("", text: $sphereArea)
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)

            Text("Bounding Box Area")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("", text: $bbArea)
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)

            //Volume Spot
            Text("Sphere Volume")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("", text: $sphereVolume)
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)

            Text("Bounding Box Volume")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("", text: $bbVolume)
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)
        }

        VStack {
            //Calculate button area
            Button("Calculate", action: {
                //Sphere
                sphereArea = 4.0 * Double.pi * Double(radius) * Double(radius)
                sphereVolume = 4.0 / 3.0 * Double.pi * Double(radius) * Double(radius) * Double(radius)

                //Bounding Box
                bbArea = 6 * (2 * Double(radius)) * (2 * Double(radius))
                bbVolume = (2 * Double(radius)) * (2 * Double(radius)) * (2 * Double(radius))
            })
                .padding(.bottom)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
