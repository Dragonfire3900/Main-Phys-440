//
//  ExponentialView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import SwiftUI

struct ExponentialView: View {
    @State var pointArr: [ColorPoint] = []
    @State var CountBelow: Int = 0
    @State var totalPtNum: Int = 0
    @State var ptNum: Double = 1000.0 //this is a workaround for the slider
    let dispBox: Box = Box(newDims: [400.0, 400.0], newCen: [0.0, 0.0])
    let bBox: Box = Box(newDims: [1.0, 1.0], newCen: [0.5, 0.5])
    
    var body: some View {
        VStack {
            Text("I do the exponentials")
            
            
            ExpSimView(pointArr: pointArr)
                .frame(width: dispBox.getLength(dimNum: 0), height: dispBox.getLength(dimNum: 1))
                .offset(x: dispBox.getCenter(dimNum: 0), y: dispBox.getCenter(dimNum: 1))
            
            Text("Approximate Area \(Double(CountBelow) / (Double(totalPtNum)) * bBox.getArea())")
            
            HStack{
                Button("Add Random Point", action: {
                    for _ in 1...Int(ptNum) {
                        self.genPoint(heightFunc: negexp)
                    }
                })
                
                Button("Clear memory", action: {
                    pointArr.removeAll()
                    CountBelow = 0
                    totalPtNum = 0
                })
            }
            Slider(value: $ptNum, in: 1...100, step: 1)
            
            Text("Number of points to have: \(ptNum)")
        }
    }
    
    func negexp(input: Double) -> Double {
        return exp(-1 * input)
    }
    
    /// Generates a point within the bounding box and then colors it according to the height function. Red means below the height func
    /// - Parameter heightFunc: A function to evaluate the x coordinates on. Determines how points are colored
    func genPoint(heightFunc: (Double) -> Double) {
        let pt: Point = bBox.getPoint()
        
        var col: Color
        
        totalPtNum += 1
        
        if (pt[1] <= heightFunc(pt[0])) {
            col = Color.red
            self.CountBelow += 1
        } else { col = Color.blue }
        
        pointArr.append(ColorPoint(oPt: dispBox.squishPt(pt: pt, bBox: bBox, inPlace: true, mods: [1.0, -1.0]), col: col))
    }
    
    /// Generate a point within a range and then color it according to the height func. Red means below the height func
    /// - Parameters:
    ///   - heightFunc: A function to evaluate the x coordinates on. Determines how points are colored
    ///   - xRang: The range of x values
    ///   - yRang: The range of y values
    func genPoint(heightFunc: (Double) -> Double, xRang: ClosedRange<Double>, yRang: ClosedRange<Double>) {
        let x = Double.random(in: xRang)
        let y = Double.random(in: yRang)
        
        var col: Color
        
        totalPtNum += 1
        
        if (y <= heightFunc(x)) {
            col = Color.red
        } else { col = Color.blue }

        let transX = (dispBox.getLength(dimNum: 0)) / (xRang.upperBound - xRang.lowerBound) * x - dispBox.getCenter(dimNum: 0)
        let transY = -1 * ((dispBox.getLength(dimNum: 1)) / (yRang.upperBound - yRang.lowerBound) * (y) - dispBox.getCenter(dimNum: 1))
        
        pointArr.append(ColorPoint(x: transX, y: transY, col: col))
    }
    
    func resetPoints() {
        pointArr.removeAll()
    }
}

struct ExponentialView_Previews: PreviewProvider {
    static var previews: some View {
        ExponentialView()
    }
}
