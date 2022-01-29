//
//  QuadView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 1/28/22.
//

import Foundation
import SwiftUI
import CorePlot

struct QuadView: View {
    //Plot Parameters
    @EnvironmentObject var dataPlots: PlotDataClass
    
    //States used for user input into the gui
    @State var a: String = ""
    @State var b: String = ""
    @State var c: String = ""
    
    //States for the calculated roots stored as a structe
    struct rootBundle {
        //Created a small structe to make managing strings easier :)
        var roots: (Double, Double)
        
        var PosRoot: String {
            get {
                return "\(roots.0)"
            }
            
            //TODO: TEST THIS BECAUSE IT'S SPOOKY
//            set {roots.0 = Double(newValue) ?? 0.0}
            
            set {
                // In Swift, non-optional String can never get nil.
                if newValue.isEmpty {
                    fatalError("invalid value for lastName")
                } else {
                    self.PosRoot = "error"
                }
            }
        }
        
        var NegRoot: String {
            get {
                return "\(roots.1)"
            }
            
            //TODO: TEST THIS BECAUSE IT'S SPOOKY
//            set {roots.1 = Double(newValue) ?? 0.0}
            
            set {
                // In Swift, non-optional String can never get nil.
                if newValue.isEmpty {
                    fatalError("invalid value for lastName")
                } else {
                    self.NegRoot = "error"
                }
            }
        }
        
        init(initialRoots: (Double, Double)) {
            self.roots = initialRoots
            self.PosRoot = "\(self.roots.0)"
            self.NegRoot = "\(self.roots.1)"
        }
    }
    
    @State var normRoot = rootBundle(initialRoots: (0.0, 0.0))
    @State var altRoot = rootBundle(initialRoots: (0.0, 0.0))
    
    var body: some View {
        VStack {
            CorePlot(dataForPlot: $dataPlots.plotData,
                     changingPlotParameters: $dataPlots.changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
            
            HStack {
                VStack(alignment: .center) {
                    Text("Parameter a")
                        .font(.callout)
                        .bold()
                    TextField("Enter a double", text: $a)
                        .padding()
                    
                    Text("Parameter b")
                        .font(.callout)
                        .bold()
                    TextField("Enter a double", text: $b)
                        .padding()
                    
                    Text("Parameter c")
                        .font(.callout)
                        .bold()
                    TextField("Enter a double", text: $c)
                        .padding()
                }
                
                VStack(alignment: .center) {
                    HStack {
                        Text(normRoot.PosRoot)
                            .font(.callout)
                            .bold()
                    }
                }
            }
        }
    }
    
    
}
