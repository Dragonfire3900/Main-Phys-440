//
//  ExpSimView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/11/22.
//

import SwiftUI

struct ExpSimView: View {
    let pointArr: [ColorPoint]
    
    var body: some View {
        ZStack {
            Rectangle() //Background
                .fill(Color.white)
            
            ForEach(pointArr) { point in
                Circle()
                    .fill(point.col)
                    .offset(x: point.x, y: point.y)
                    .frame(width: 4.0, height: 4.0)
            }
        }
    }
}

struct ExpSimView_Previews: PreviewProvider {
    static var previews: some View {
        ExpSimView(pointArr: [])
    }
}
