//
//  SnowSimView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/18/22.
//

import SwiftUI

struct SnowSimView: View {
    let lineArray: [Line]
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
            
            ForEach(lineArray) { lines in
                Path { path in
                    path.move(to: CGPoint(x: lines.p1.x, y: lines.p1.y))
                    path.addLine(to: CGPoint(x: lines.p2.x, y: lines.p2.y))
                }
                .stroke(lines.col, lineWidth: lines.weight)
            }
        }
    }
}

struct SnowSimView_Previews: PreviewProvider {
    static var previews: some View {
        SnowSimView(lineArray: [])
    }
}
