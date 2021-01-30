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
            TextField("Radius", text: $radius, onCommit: {updateCalculations()})
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)
            

            //Sphere Spot
            Text("Sphere Area")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("", text: $sphereArea)
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)

            Text("Sphere Volume")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("", text: $sphereVolume)
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)


            //Bounding Box Spot
            Text("Bounding Box Area")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("", text: $bbArea)
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
            Button("Calculate", action: {updateCalculations()})
                .padding(.bottom)
                .padding()
        }
    }

    func updateCalculations() {
        //These are the calculations which need to be done every time a new radius is added
            //Sphere
            sphereArea = 4.0 * Double.pi * pow(Double(radius), 2) //4 * pi * r^2
            sphereVolume = 4.0 / 3.0 * Double.pi * pow(Double(radius), 3) // 4/3 * pi * r^3

            //Bounding Box
            //Note: 2 * radius = bounding box side length
            bbArea = 6 * pow(2 * Double(radius), 2) // 6 * (bounding box side length)^2
            bbVolume = pow(2 * Double(radius), 3) // (bounding box side length)^3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
