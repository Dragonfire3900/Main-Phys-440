//
//  CalculatePlotData.swift
//  SwiftUICorePlotExample
//
//  Created by Jeff Terry on 12/22/20.
//

import Foundation
import SwiftUI
import CorePlot

class CalculatePlotData: ObservableObject {
    
    var plotDataModel: PlotDataClass? = nil
    

    func plotYEqualsX()
    {
        
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = " y = x"
        
        plotDataModel!.zeroData()
        var plotData :[plotDataType] =  []
        
        
        for i in 0 ..< 120 {

            //create x values here

            let x = -2.0 + Double(i) * 0.2

            //create y values here

            let y = x


            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
            
            plotDataModel!.calculatedText += "\(x)\t\(y)\n"
        
        }
        
        plotDataModel!.appendData(dataPoint: plotData)
        
        
    }
    
    
    func ploteToTheMinusX()
    {
        
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10
        plotDataModel!.changingPlotParameters.yMin = -3.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -3.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y = exp(-x)"
        plotDataModel!.changingPlotParameters.lineColor = .blue()
        plotDataModel!.changingPlotParameters.title = "exp(-x)"

        plotDataModel!.zeroData()
        var plotData :[plotDataType] =  []
        for i in 0 ..< 60 {

            //create x values here

            let x = -2.0 + Double(i) * 0.2

        //create y values here

        let y = exp(-x)
            
            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
            
            plotDataModel!.calculatedText += "\(x)\t\(y)\n"
            
        }
        
        plotDataModel!.appendData(dataPoint: plotData)
        
        return
    }
 
    func plotLogMap(start: Double, mu: Double, pts: Int) {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10
        plotDataModel!.changingPlotParameters.yMin = -3.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -3.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "log map value"
        plotDataModel!.changingPlotParameters.lineColor = .blue()
        plotDataModel!.changingPlotParameters.title = "Log Map Plot"

        if plotDataModel!.pointNumber != Double(pts) {
            plotDataModel!.reserveData(pointNum: pts)
        }
        
        let logMap = logMap(firstVal: start, mu: mu)
        
        for (idx, res) in logMap.makeIterator(iterNum: pts).enumerated() {

            plotDataModel!.insertData(idx: idx, dataPoint: [.X: Double(idx), .Y: res[0]])
            
        }
    }
    
    func plotMap(map: genericMap, start: [Double], params: [String: Double], pts: Int) {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10
        plotDataModel!.changingPlotParameters.yMin = -3.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -3.0
        plotDataModel!.changingPlotParameters.xLabel = "Iteration Number"
        plotDataModel!.changingPlotParameters.yLabel = "Map value"
        plotDataModel!.changingPlotParameters.lineColor = .blue()
        plotDataModel!.changingPlotParameters.title = "Log Map Plot"

        if plotDataModel!.pointNumber != Double(pts) {
            plotDataModel!.reserveData(pointNum: pts)
        }
        
        let tmpMap = type(of: map).init(currVal: start, params: params)
        
        for (idx, res) in tmpMap.makeIterator(iterNum: pts, reset: true).enumerated() {
            plotDataModel!.insertData(idx: idx, dataPoint: [.X: Double(idx), .Y: res[0]])
        }
    }
    
    func plotBif(map: genericMap, start: Double, params: [String: Double], muRange: [Double], pts: Int, genLength: Int) {
        plotDataModel!.changingPlotParameters.xMax = muRange[1] + 0.1
        plotDataModel!.changingPlotParameters.xMin = muRange[0] - 0.1
        plotDataModel!.changingPlotParameters.xLabel = "Mu"
        plotDataModel!.changingPlotParameters.yLabel = "Stable map value"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = "Map Bifurcation"
        plotDataModel!.changingPlotParameters.symSize = 2.0
        plotDataModel!.changingPlotParameters.lineWidth = 0.0
        
        let transGen = 200
        
        if plotDataModel!.pointNumber != Double(pts * genLength) {
            plotDataModel!.reserveData(pointNum: pts * genLength)
        }
        
        guard muRange.count == 2 else {
            return
        }
        
        var valMax = start
        var valMin = start
        
        for idx in 0..<pts {
            let mu = muRange[0] + (muRange[1] - muRange[0]) / Double(pts) * Double(idx)
            
            var newParams = params
            newParams["mu"] = mu
            
            let tmpMap = type(of: map).init(currVal: [start], params: newParams)
            
            for (iter, res) in tmpMap.makeIterator(iterNum: genLength + transGen, reset: false).enumerated() {
                if iter >= transGen {
                    plotDataModel!.insertData(idx: idx * genLength + iter - transGen, dataPoint: [.X: mu, .Y: res[0]])
                    
                    if valMax < res[0] {
                        valMax = res[0]
                    }
                    
                    if valMin > res[0] {
                        valMin = res[0]
                    }
                }
            }
            
            plotDataModel!.changingPlotParameters.yMax = valMax
            plotDataModel!.changingPlotParameters.yMin = valMin
        }
    }
    
    func plotBif(map: genericMap, start: [Double], params: [String: Double], muRange: [Double], pts: Int, genLength: Int) {
        guard start.count == 2 else {
            return
        }
        
        plotBif(map: map, start: Double.random(in: start[0]...start[1]), params: params, muRange: muRange, pts: pts, genLength: genLength)
    }
}
