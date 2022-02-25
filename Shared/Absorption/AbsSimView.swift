//
//  SimView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import SwiftUI

struct AbsSimView: View {
    let pointArr: [ColorPoint]
    let detectBox: Box
    
    var body: some View {
        ZStack {
            Rectangle() //Background
                .fill(Color.white)
            
            Rectangle() //The detector box
                .stroke(Color.black)
                .offset(x: detectBox.getCenter(dimNum: 0), y: detectBox.getCenter(dimNum: 1))
                .frame(width: detectBox.getLength(dimNum: 0), height: detectBox.getLength(dimNum: 1))
            
            ForEach(pointArr) { point in
                Circle()
                    .fill(point.col)
                    .offset(x: point.x, y: point.y)
                    .frame(width: 4.0, height: 4.0)
            }
        }
    }
}

struct AbsSimView_Previews: PreviewProvider {
    static var previews: some View {
        AbsSimView(pointArr: [], detectBox: Box(newDims: [10.0, 10.0], newCen: [0.0, 0.0]))
    }
}
