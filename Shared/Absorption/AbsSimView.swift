//
//  SimView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import SwiftUI

struct AbsSimView: View {
    var pointArr: [Particle]
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
                partView(part: point)
            }
        }
    }
}

struct partView: View {
    @ObservedObject var part: Particle
    let radius: Double = 4.0
    
    var body: some View {
        Circle()
            .fill(part.col)
            .offset(x: part.x, y: part.y)
            .frame(width: radius, height: radius)
    }
}

struct AbsSimView_Previews: PreviewProvider {
    static var previews: some View {
        AbsSimView(pointArr: [], detectBox: Box(newDims: [10.0, 10.0], newCen: [0.0, 0.0]))
    }
}
