//
//  DynamSlider.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 9/29/22.
//

import SwiftUI

struct DynamSlider: View {
    @State var lowLim: Double = 0.0
    
    @State var upLim: Double = 100.0 {
        didSet(oldVal) {
            if upLim < lowLim {
                upLim = oldVal
            }
        }
    }
    
    @State var stepSize: Double = 5.0
    @State var name: String
    
    var space = 10.0
    
    @Binding var valBind: Double
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        HStack {
            Spacer(minLength: space)
            
            TextField("Enter a lower limit",
                      value: Binding(
                        get: { return self.lowLim },
                        set: { (newVal) in
                            if newVal < upLim {
                                self.lowLim = newVal
                            }
                        }),
                      formatter: formatter)
            .fixedSize()
            
            VStack {
                Text("\(name): \(valBind)")
                    .fontWeight(Font.Weight.heavy)
                Slider(
                    value: Binding(get: { return valBind}, set: { self.valBind = $0 }),
                    in: lowLim...upLim,
                    step: stepSize)
                HStack {
                    Text("Step Size:")
                    
                    TextField("Enter a step size",
                              value: Binding(
                                get: { return self.stepSize },
                                set: { (newVal) in
                                    if newVal > 0 && (upLim - lowLim) > newVal {
                                        self.stepSize = newVal
                                    }
                                }),
                              formatter: formatter)
                    .fixedSize()
                }
            }
            
            TextField("Enter an upper limit",
                      value: Binding(
                        get: { return self.upLim },
                        set: { (newVal) in
                            if newVal > lowLim {
                                self.upLim = newVal
                            }
                        }),
                      formatter: formatter)
            .fixedSize()
            
            Spacer(minLength: space)
        }
    }
}

struct DynamSlider_Previews: PreviewProvider {
    static var previews: some View {
        DynamSlider(
            name: "Mu",
            space: 15,
            valBind: .constant(10.0))
    }
}
