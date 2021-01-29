//
//  ContentView.swift
//  Shared
//
//  Created by Joel Kelsey on 1/28/21.
//

import SwiftUI

struct ContentView: View {

    @State var radiusStr = "1.0"
    @ObservedObject private var sphereModel = Sphere()

    var body: some View {
        VStack{
            //Radius Spot
            Text("Radius")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("Radius", text: $radiusStr, onCommit: {sphereModel.setRadius(Radius: radiusStr)})
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)
            

            //Sphere Spot
            Text("Sphere Area")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("", text: $sphereModel.surfaceAreaStr)
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)

            Text("Sphere Volume")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("", text: $sphereModel.volumeStr)
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)


            //Bounding Box Spot
            Text("Bounding Box Area")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("", text: $sphereModel.bbSurfaceAreaStr)
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)

            Text("Bounding Box Volume")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("", text: $sphereModel.bbVolumeStr)
                .padding(.horizontal)
                .frame(width: 200)
                .padding(.top, 0)
                .padding(.bottom, 50)
        }
        
        VStack {
            //Calculate button area
            Button("Calculate", action: {sphereModel.setRadius(Radius: radiusStr)})
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
