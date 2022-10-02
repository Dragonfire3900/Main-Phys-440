//
//  DoubleTextField.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 9/29/22.
//

import SwiftUI

struct DoubleTextField: View {
    @Binding var dVal: Double
    var onCommit: () -> Void = {}
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        TextField("Enter a lower Limit",
            value: $dVal,
            formatter: formatter,
        onCommit: onCommit)
        .fixedSize()
    }
}

struct DoubleTextField_Previews: PreviewProvider {
    static var previews: some View {
        DoubleTextField(dVal: .constant(20.5))
    }
}
