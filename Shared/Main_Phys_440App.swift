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
    
//    var map = gaussMap(firstVal: 1.0, mu: 0.1, b: 0.2)
    var map = logMap(firstVal: 1.0, mu: 0.1)
    
    var body: some Scene {
        WindowGroup {
            TabView {
                DiscreteSim(map: map)
                    .environmentObject(plotDataModel)
                    .tabItem {
                        Text("Discrete Sim")
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
