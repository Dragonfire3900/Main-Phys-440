//
//  SimView.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import SwiftUI

struct AbsSimView: View {
    let pointArr: [ColorPoint]
//    let lineArr:
    
    var body: some View {
        Rectangle() //Background
            .fill(Color.white)
    }
}

struct AbsSimView_Previews: PreviewProvider {
    static var previews: some View {
        AbsSimView(pointArr: [])
    }
}
