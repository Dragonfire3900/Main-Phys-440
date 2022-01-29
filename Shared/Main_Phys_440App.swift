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
    @StateObject var quadDataModel = PlotDataClass(fromLine: true)
    
    var body: some Scene {
        WindowGroup {
            TabView {
                QuadView()
                    .environmentObject(quadDataModel)
                    .tabItem {
                        Text("Quad Root Error Analysis")
                    }
                    
                
//                ContentView()
//                    .environmentObject(plotDataModel)
//                    .tabItem {
//                        Text("Plot")
//                    }
//                TextView()
//                    .environmentObject(plotDataModel)
//                    .tabItem {
//                        Text("Text")
//                    }
//
                            
            }
            
        }
    }
}
