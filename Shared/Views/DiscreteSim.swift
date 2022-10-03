// A simulator view for discrete reccurrent maps. Mainly for showing Chaos
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
    @ObservedObject var plotDataModel: PlotDataClass //The main plot for tracking a single set of values
    @ObservedObject private var calculator = CalculatePlotData() //The calculator for single tracks
    @State var mapSelect: DiscMaps = DiscMaps.log //An enum describing which map has been selected (used for the picker)
    @State var map: any genericMap //The generic map instance which was selected
    
    @State var bifScan: [Double] = [0.0, 4.0] //Where to scan along the parameter mu for the bifurcation diagram
    @State var bifInit: [Double] = [0.0, 1.0] //The range for the initial values for the bifurcation scan
    @State var scanNum: Double = 100 //The number of initial values to use
    
    @State var randInit: Bool = true //If a random initialization should be used for the bifurcation scan
    
    @ObservedObject private var bifCalc = CalculatePlotData()
    @ObservedObject var bifDataModel: PlotDataClass = PlotDataClass(fromLine: false) //The datamodel for plotting the bifurcation
    
    @State var params: [String: Double] = [:] //All of the parameters for all of the possible maps
    @State private var start = 1.0 //Where the recurrent map should start

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
        calculator.plotMap(map: self.map, start: [start], params: self.params, pts: 10)
    }
    
    //Calculation for the bifurcation diagram
    func calcBifurcation() {
        bifCalc.plotDataModel = self.bifDataModel
        
        //Calculate the data and place it in the data model
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
        DiscreteSim(plotDataModel: PlotDataClass(fromLine: true), map: logMap(firstVal: 1.0, mu: 0.1))
    }
}
