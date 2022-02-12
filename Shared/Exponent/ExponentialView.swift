//
//  ExponentialView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import SwiftUI

struct ExponentialView: View {
    @State var pointArr: [ColorPoint] = []
    var CountBelow: Int = 0
    var ptNum: Int = 1000
    let xSimFrameSize: Double = 300.0
    let ySimFrameSize: Double = 300.0
    
    var body: some View {
        VStack {
            Text("I do the exponentials")
            
            ExpSimView(pointArr: pointArr)
                .frame(width: xSimFrameSize, height: ySimFrameSize)
            
            Button("Add Random Point", action: {
                for _ in 1...ptNum {
                    self.genPoint(heightFunc: negexp, xRang: 0.0...1.0, yRang: 0.0...1.0)
                }
            })
        }
    }
    
    func negexp(input: Double) -> Double {
        return exp(-1 * input)
    }
    
    func genPoint(heightFunc: (Double) -> Double, xRang: ClosedRange<Double>, yRang: ClosedRange<Double>) {
        let x = Double.random(in: xRang)
        let y = Double.random(in: yRang)
        
        var col: Color
        
        if (y <= heightFunc(x)) {
            col = Color.red
            CountBelow = CountBelow + 1
        } else { col = Color.blue }

        let transX = (xSimFrameSize) / (xRang.upperBound - xRang.lowerBound) * x - xSimFrameSize / 2.0
        let transY = -1 * ((ySimFrameSize) / (yRang.upperBound - yRang.lowerBound) * (y) - ySimFrameSize / 2.0)
        
//        print("(\(x),\(y)): \(heightFunc(x)) \(col)")
        
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
