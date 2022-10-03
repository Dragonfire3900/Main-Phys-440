// A simulator for the continuous systems. Really focuses on implementing a pendulum
//
//  ContuousSim.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 10/2/22.
//

import SwiftUI

struct ContuousSim: View {
    @ObservedObject var plotDataModel: PlotDataClass = PlotDataClass(fromLine: true) //Plot for position
//    @ObservedObject var phaseDataModel: PlotDataClass = PlotDataClass(fromLine: true) //Plot for the phase space
    
    @ObservedObject private var calculator = CalculatePlotData() //Calculator for everything
    
    @State var mapSelect: ShroeMaps = ShroeMaps.box
    @State var map: any shroeMap //The map which is used for the continuous setup
    
    @State var params: [String: Double] = [:] //All of the parameters for all maps
    @State private var start = 1.0 //Where the
    @State private var timeS = 0.5 //What the time step size is
    @State private var pts = 100.0 //The number of points to predict
    
    var body: some View {
        HStack {
            VStack {
                Picker("Schroedinger Selection", $mapSelect)
                    .onChange(of: mapSelect) {
                        self.map = mapSelect.actMap
                    }
                
                ForEach(map.getKeys(), id: \.self) { (key) in
                    DynamSlider(lowLim: 0, upLim: 1, stepSize: 0.1, name: key.capitalized, valBind: getBinding(key: key))
                }
                
                HStack {
                    Button("Calc Wavefunction", action: {self.calcTrajectory(map: self.map, start: [start], params: self.params, pts: Int(pts), timeStep: timeS)})
                    
                    Text("Time Step:")
                    DoubleTextField(dVal: $timeS)
                    
                    Text("Point Num:")
                    DoubleTextField(dVal: $pts)
                }
            }
            
            CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                .setPlotPadding(left: 1)
                .setPlotPadding(right: 1)
                .setPlotPadding(top: 1)
                .setPlotPadding(bottom: 1)
                .padding(5)
        }
    }
    
    func getBinding(key: String) -> Binding<Double> {
        return Binding(get: { return self.params[key, default: 0.1] },
            set: { newVal in self.params[key] = newVal}
        )
    }
    
    func calcTrajectory(map: any genericMap, start: [Double], params: [String: Double], pts: Int, timeStep: Double) {
        //set the Plot Parameters
        plotDataModel.changingPlotParameters.yMax = 10
        plotDataModel.changingPlotParameters.yMin = -3.0
        plotDataModel.changingPlotParameters.xMax = 10.0
        plotDataModel.changingPlotParameters.xMin = -3.0
        plotDataModel.changingPlotParameters.xLabel = "Iteration Number"
        plotDataModel.changingPlotParameters.yLabel = "Pendulum Angle"
        plotDataModel.changingPlotParameters.lineColor = .blue()
        plotDataModel.changingPlotParameters.title = "Pendulum Position"
        
        if plotDataModel.pointNumber != Double(pts) {
            plotDataModel.reserveData(pointNum: pts)
        }
        
        let tmpMap = type(of: map).init(currVal: start, params: params)
        
        for (idx, res) in tmpMap.makeIterator(iterNum: pts, reset: true, stepSize: timeStep).enumerated() {
            plotDataModel.insertData(idx: idx, dataPoint: [.X: Double(idx) * timeStep, .Y: res[0]])
        }
    }
}

struct ContuousSim_Previews: PreviewProvider {
    static var previews: some View {
        ContuousSim(map: boxShroe(currVal: [], params: [:]))
    }
}
