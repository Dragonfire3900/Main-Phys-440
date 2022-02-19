//
//  SnowView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/17/22.
//

import SwiftUI

struct SnowView: View {
    let defaultLines = [Line(p1: ColorPoint(x: 0.0, y: 200.0, col: .blue), p2: ColorPoint(x: 400.0, y: 200.0, col: .blue), col: .red, weight: 2.0)]
    
    @State var lineArray: [Line] = [Line(p1: ColorPoint(x: 0.0, y: 200.0, col: .blue), p2: ColorPoint(x: 400.0, y: 200.0, col: .blue), col: .red, weight: 2.0)]
    @State var iter: Int = 0
    @State var perc: Double = 0.5
    @State var percWidth: Double = 0.2
    @State var dist: Double = 25.0
    
    let procNum = ProcessInfo.processInfo.processorCount
    
    var body: some View {
        VStack {
            Text("I create the top half of the Koch fractal!")
            
            HStack {
                VStack {
                    Text("Number of Iterations: \(iter)")
                    
                    Text("Percentage between ends: \(perc)")
                    Slider(value: $perc, in: 0...1)
                    
                    Text("Percentage width of triangle: \(percWidth)")
                    Slider(value: $percWidth, in: 0...0.99)
                    
                    Text("Distance from line: \(dist)")
                    Slider(value: $dist, in: 1...200)
                    
                    HStack {
                        Button("Calculate", action: {
                            var lineList: [Line] = []
                        
                            for line in lineArray {
                                lineList.append(contentsOf: calcLine(iniLine: line))
                            }
                            
                            iter += 1
                        
                            self.lineArray.removeAll()
                            self.lineArray.append(contentsOf: lineList)
                        })
                        
                        Button("Reset", action: {
                            self.lineArray.removeAll()
                            lineArray = defaultLines
                            iter = 0
                        })
                    }
                }
                
                Spacer()
                
                SnowSimView(lineArray: lineArray)
                    .frame(width: 400, height: 400)
            }
        }
    }
    
    func calcLine(iniLine: Line) -> [Line] {
        
        //Various conditions
        if (perc - percWidth / 2.0 < 0.0) { //If it's below the left point
            let peakPt = iniLine.getPara(perc: 1.0, dist: dist * pow(perc, Double(iter)), above: false)
            let rhtPt = iniLine.getBetween(perc: perc - percWidth / 2.0)
            
            return [
                Line(p1: iniLine.p1, p2: peakPt, col: iniLine.col, weight: iniLine.weight),
                Line(p1: peakPt, p2: rhtPt, col: iniLine.col, weight: iniLine.weight),
                Line(p1: rhtPt, p2: iniLine.p2, col: iniLine.col, weight: iniLine.weight)
            ]
        } else if (perc + percWidth / 2 > 1.0) { //If it's above the right point
            let peakPt = iniLine.getPara(perc: 1.0, dist: dist * pow(perc, Double(iter)), above: false)
            let lhtPt = iniLine.getBetween(perc: perc + percWidth / 2.0)
            
            return [
                Line(p1: iniLine.p1, p2: lhtPt, col: iniLine.col, weight: iniLine.weight),
                Line(p1: lhtPt, p2: peakPt, col: iniLine.col, weight: iniLine.weight),
                Line(p1: peakPt, p2: iniLine.p2, col: iniLine.col, weight: iniLine.weight)
            ]
        } else {
            let peakPt = iniLine.getPara(perc: perc, dist: dist * pow(perc, Double(iter)), above: false)
            let rhtPt = iniLine.getBetween(perc: perc + percWidth / 2.0)
            let lhtPt = iniLine.getBetween(perc: perc - percWidth / 2.0)
            
            return [
                Line(p1: iniLine.p1, p2: lhtPt, col: iniLine.col, weight: iniLine.weight),
                Line(p1: lhtPt, p2: peakPt, col: iniLine.col, weight: iniLine.weight),
                Line(p1: peakPt, p2: rhtPt, col: iniLine.col, weight: iniLine.weight),
                Line(p1: rhtPt, p2: iniLine.p2, col: iniLine.col, weight: iniLine.weight)
            ]
        }
    }
}

struct SnowView_Previews: PreviewProvider {
    static var previews: some View {
        SnowView()
    }
}
