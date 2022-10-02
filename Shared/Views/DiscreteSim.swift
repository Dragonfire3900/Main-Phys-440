//
//  ContentView.swift
//  Shared
//
//  Created by Joel Kelsey on 1/28/21.
//

import SwiftUI
import CorePlot

typealias plotDataType = [CPTScatterPlotField : Double]

struct DiscreteSim: View {
    @EnvironmentObject var plotDataModel: PlotDataClass
    @ObservedObject private var calculator = CalculatePlotData()
    @State var mapSelect: DiscMaps = DiscMaps.log
    @State var map: any genericMap
    
    @State var bifScan: [Double] = [0.0, 4.0]
    @State var bifInit: [Double] = [0.0, 1.0]
    @State var scanNum: Double = 100
    
    @State var randInit: Bool = true
    
    @ObservedObject private var bifCalc = CalculatePlotData()
    @ObservedObject var bifDataModel: PlotDataClass = PlotDataClass(fromLine: false)
    
    @State var params: [String: Double] = [:]
    @State private var start = 1.0

    var body: some View {
        HStack{
            VStack{
                Picker("Selected Map", selection: $mapSelect) {
                    ForEach(DiscMaps.allCases) { mapType in
                        Text("\(mapType.rawValue.capitalized) Map")
                    }
                }
                .onChange(of: mapSelect) { sel in
                    map = sel.actMap
                }
                .padding(7)
                
                DynamSlider(lowLim: 0, upLim: 1.0, stepSize: 0.2, name: "Start Value", valBind: $start)
                
                ForEach(map.getKeys(), id: \.self) { (key) in
                    DynamSlider(lowLim: 0, upLim: 1, stepSize: 0.1, name: key.capitalized, valBind: getBinding(key: key))
                }
                
                HStack {
                    Button("Calc Track", action: {self.calculate()} )
                    .padding(2)
                    
                    Text("Low Mu:")
                    DoubleTextField(dVal: $bifScan[0])
                    
                    Text("Up Mu:")
                    DoubleTextField(dVal: $bifScan[1])
                }
                
                HStack {
                    Text("Initial Low")
                    DoubleTextField(dVal: $bifInit[0])
                    
                    Text("Initial High")
                    DoubleTextField(dVal: $bifInit[1])
                }
                
                HStack {
                    Button("Calc Bifurcation", action: {self.calcBifurcation()})
                        .padding(2)
                    Text("Sim Number:")
                    DoubleTextField(dVal: $scanNum)
                    
                    Toggle("Random Init", isOn: $randInit)
                }
            }
            
            CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                .setPlotPadding(left: 1)
                .setPlotPadding(right: 1)
                .setPlotPadding(top: 1)
                .setPlotPadding(bottom: 1)
                .padding(5)
            
            CorePlot(dataForPlot: $bifDataModel.plotData, changingPlotParameters: $bifDataModel.changingPlotParameters)
                .setPlotPadding(left: 1)
                .setPlotPadding(right: 1)
                .setPlotPadding(top: 1)
                .setPlotPadding(bottom: 1)
                .padding(5)
        }
    }
    
    /// calculate
    /// Function accepts the command to start the calculation from the GUI
    func calculate(){
        //pass the plotDataModel to the cosCalculator
        calculator.plotDataModel = self.plotDataModel
        
        //Calculate the new plotting data and place in the plotDataModel
//        calculator.plotLogMap(start: start, mu: self.params["mu", default: 0.1], pts: 10)
        calculator.plotMap(map: self.map, start: [start], params: self.params, pts: 10)
    }
    
    func calcBifurcation() {
        bifCalc.plotDataModel = self.bifDataModel
        
        bifCalc.plotBif(map: self.map, start: bifInit, params: self.params, muRange: self.bifScan, pts: Int(scanNum), genLength: 100)
    }
    
    func getBinding(key: String) -> Binding<Double> {
        return Binding(get: { return self.params[key, default: 0.1] },
            set: { newVal in self.params[key] = newVal}
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscreteSim(map: logMap(firstVal: 1.0, mu: 0.1))
            .environmentObject(PlotDataClass(fromLine: true))
    }
}
