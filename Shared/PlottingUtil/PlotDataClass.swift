//
//  PlotDataClass.swift
//  SwiftUICorePlotExample
//  Shared
//
//  Created by Jeff Terry on 12/16/20.
//

import Foundation
import SwiftUI
import CorePlot

class PlotDataClass: NSObject, ObservableObject {
    
    @Published var plotData = [plotDataType]()
    @Published var changingPlotParameters: ChangingPlotParameters = ChangingPlotParameters()
    @Published var calculatedText = ""
    //In case you want to plot vs point number
    @Published var pointNumber = 1.0
    
    init(fromLine line: Bool) {
        
        
        //Must call super init before initializing plot
        super.init()
       
        
        //Intitialize the first plot
        self.plotBlank()
        
       }
    
    
    
    func plotBlank()
    {
        plotData = []
        
        //set the Plot Parameters
        changingPlotParameters.yMax = 4.0
        changingPlotParameters.yMin = -1.0
        changingPlotParameters.xMax = 4.0
        changingPlotParameters.xMin = -1.0
        changingPlotParameters.xLabel = "x"
        changingPlotParameters.yLabel = "y"
        changingPlotParameters.lineColor = .red()
        changingPlotParameters.title = " y = x"
        
    }
    
    func zeroData() {
        plotData = []
        pointNumber = 1.0
    }
    
    func reserveData(pointNum: Int) {
        plotData = []
        
        for _ in 0..<pointNum {
            plotData.append(contentsOf: [[.X: 0.0, .Y: 0.0]])
            
        }
        
        pointNumber = Double(pointNum)
    }
        
    func appendData(dataPoint: [plotDataType]) {
        plotData.append(contentsOf: dataPoint)
        pointNumber += 1.0
    }
    
    func insertData(idx: Int, dataPoint: plotDataType) {
        if idx < Int(pointNumber) {
            plotData[idx] = dataPoint
        }
    }
}


