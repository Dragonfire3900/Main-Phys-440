//
//  Differential.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 4/1/22.
//

import Foundation

/// Describes a variable parameter in a recursive equation
class Parameter: NSObject, ObservableObject {
    //Static defaults
    internal static let DEF_VAL: Double = 0.0
    internal static let DEF_INIT_VAL: Double = 0.5
    internal static let DEF_START: Double = 0.0
    internal static let DEF_END: Double = 1.0
    internal static let DEF_STEP: Double = 0.5
    
    //Current value of param
    @Published var value: Double
    
    //Slider Params
    let start: Double
    let end: Double
    let step: Double
    let count: Int
    
    //Initial value of param
    let initVal: Double
    
    override init() {
        self.value = Parameter.DEF_VAL
        
        self.initVal = Parameter.DEF_INIT_VAL
        
        self.start = Parameter.DEF_START
        self.end = Parameter.DEF_END
        self.step = Parameter.DEF_STEP
        
        self.count = Int(floor((self.end - self.start) / self.step))
        
        super.init()
    }
    
    init(initVal: Double, slideStart: Double, slideEnd: Double, slideStep: Double) {
        //TODO: Guard this properly
        
        self.value = initVal
        self.initVal = initVal
        
        self.start = slideStart
        self.end = slideEnd
        self.step = slideStep
        
        self.count = Int(floor((self.end - self.start) / self.step))
        
        super.init()
    }
    
    init(initVal: Double, slideStart: Double, slideEnd: Double, slideStepNum: Int) {
        //TODO: Guard this properly
        
        self.value = initVal
        self.initVal = initVal
        
        self.start = slideStart
        self.end = slideEnd
        self.count = slideStepNum
        
        self.step = (self.end - self.start) / Double(self.count)
        
        super.init()
    }
    
    func resetVal() {
        self.value = self.initVal
    }
}

/// A high level class which represents a recurrent differential equation and the entire parameter space. Can be used to build bifrication diagrams and other chaos analysis aspects
class RecurDiff: ObservableObject {
    
    /// An evaluator for the differential equation. Used to thread the generation of bifrication diagrams
    internal class RecurDiffEval: NSObject {
        //Instance variables
        let blockAmount: Int
        
    }
    
    //Instance Variables
    let paramList: [Parameter]
    let recurFun: ([Parameter], [Double]) -> Double
    
    init(params: [Parameter]) {
        
    }
    
    func eval(index: Int) -> Double {
        
    }
}
