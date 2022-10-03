//
//  Main_Phys_440App.swift
//  Shared
//
//  Created by Joel Kelsey on 1/28/21.
//

import SwiftUI

@main
struct Main_Phys_440App: App {
    
    @StateObject var plotDataModel = PlotDataClass(fromLine: true)

    var body: some Scene {
        WindowGroup {
            TabView {
                ContuousSim(map: pendulumMap(currVal: [1.0, 1.0], params: ["w": 0.1, "a": 0.1, "f":0.1]))
                    .tabItem {
                        Text("Continuous Sim")
                    }
                
                TextView()
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Text")
                    }
            }
        }
    }
}
