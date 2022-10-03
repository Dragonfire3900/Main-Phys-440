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
                ContuousSim(map: boxShroe(currVal: [], params: [:]))
                    .tabItem {
                        Text("Schroedinger Sim")
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
