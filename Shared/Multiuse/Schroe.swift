//
//  Schroe.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/25/22.
//

import Foundation

//General strategy for this problem
// 1) Start out with the initial points
//   a) Be given a potential function (interpolate or strict eval)
//   b) Be given an interval to evaluate on
//   c) Be given the initial value at one of the boundaries
//   d) Be given the initial energy of the wave function
// 2) Evaluate the derivative over that defined interval
//   a) Use the Shroedinger eq to evaluate the second derivative to approximate the first
//   b) Use the same potential function and energy to evaluate over the interval starting at the initial point
//   c) Interpolate between the points using a preset method
// 3) Evaluate the actual function over that defined interval
//   a) Interpolate between the points if needed

class SchroeDeriv: RestrictProject, MathRecursive {
    //Static constants
    internal static let DEF_PT: Double = 0.0
    internal static let DEF_VAL: Double = 0.0
    internal static let DEF_ENG: Double = 0.0
    internal static let DEF_START: Double = 0.0
    internal static let DEF_END: Double = 1.0
    internal static let DEF_STEP: Double = 0.5
    internal static let DEF_MASS: Double = 1.0
    
    //Instance Variables
    let initPt: Double
    let initVal: Double
    var domain: funcDomain
    var engLvl: Double
    var mass: Double
    
    @Published var storedVals: [Double]
    internal var builtFlag: Bool = false
    private var pot: genPotential
    
    init() {
        //Setting up the equation constants
        self.initPt = SchroeDeriv.DEF_PT
        self.initVal = SchroeDeriv.DEF_VAL
        self.domain = funcDomain(
            nStart: SchroeDeriv.DEF_START,
            nEnd: SchroeDeriv.DEF_END,
            nStepSize: SchroeDeriv.DEF_STEP)
        self.engLvl = SchroeDeriv.DEF_ENG
        self.mass = SchroeDeriv.DEF_MASS
        
        //Setting up the potentials and building the function
        self.storedVals = []
        self.pot = genPotential(start: <#T##Double#>, end: <#T##Double#>, step: <#T##Double#>, energy: <#T##Double#>, pFunc: <#T##(Double) -> Double#>)
    }
    
    init(start: Double, end: Double, step: Double, potential: genPotential, energy: Double) {
        
    }
    
    func Eval(val: Double) -> Double? {
        return 0.0
    }
    
    func makeIterator() -> funcDomainIterator {
        return self.domain.makeIterator()
    }
}
