//
//  Potentials.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 3/4/22.
//

import Foundation

class genPotential: ObservableObject, RestrictProject, StoredFunc {
    //Static variables which are useful
    internal static let DEF_ENG: Double = 0.0
    internal static let DEF_START: Double = 0.0
    internal static let DEF_END: Double = 1.0
    internal static let DEF_STEP: Double = 0.5
    internal static func DEF_POT(_: Double) -> Double { return 0.0 }
    
    //Instance variables
    @Published var storedVals: [Double]
    let domain: funcDomain
    let engLvl: Double
    private var potFunc: (Double) -> Double
    internal var builtFlag: Bool = false
    
    subscript(index: Int) -> Double {
        get {
            return self.storedVals[index]
        }
        
        set(newValue) {
            self.storedVals[index] = newValue
        }
    }
    
    init() {
        self.storedVals = []
        self.domain = funcDomain(nStart: genPotential.DEF_START, nEnd: genPotential.DEF_END, nStepSize: genPotential.DEF_STEP)
        self.engLvl = genPotential.DEF_ENG
        self.potFunc = genPotential.DEF_POT
    }
    
    init(start: Double, end: Double, step: Double, energy: Double, pFunc: @escaping (Double) -> Double) {
        //TODO: Guard this initializer
        self.storedVals = []
        
        self.domain = funcDomain(nStart: start, nEnd: end, nStepSize: step)
        
        if (energy >= 0.0) {
            self.engLvl = energy
        } else {
            self.engLvl = genPotential.DEF_ENG
        }
        
        self.potFunc = pFunc
    }
    
    //Mutators
    func setPotFun(nPotFunc: @escaping (Double) -> Double) {
        self.storedVals.removeAll()
        self.builtFlag = false
        self.potFunc = nPotFunc
    }
    
    //Calculators
    /// Pre-computes all of the values within the potential's range
    func buildStore() {
        for xval in self.domain {
            self.storedVals.append(self.potFunc(xval))
        }
        self.builtFlag = true
    }
    
    func Interp(xVal: Double) -> Double {
        //TODO: This really shouldn't work like this. Please fix it
        return self.Interp(befInd: self.domain.index(of: xVal) ?? 0, xVal: xVal)
    }
    
    /// Creates a linear interpolation of the a point between the xvalues of the range
    /// - Parameters:
    ///   - befInd: The index before the x-value
    ///   - xVal: The value you would like to interpolate
    /// - Returns: The value of the linear interpolation between the points
    func Interp(befInd: Int, xVal: Double) -> Double {
        //TODO: Guard this function
        let slope = (self.storedVals[befInd + 1] - self.storedVals[befInd]) / (self.domain[befInd + 1] - self.domain[befInd])
        
        return self.storedVals[befInd] + (xVal - self.domain[befInd]) * slope
    }
    
    func Eval(val: Double) -> Double? {
        guard (!self.builtFlag) else {
            return nil
        }
        
        let index = self.domain.index(of: val) ?? -1
        
        if (index != -1) {
            return self.Interp(befInd: index, xVal: val)
        } else {
            return 0.0
        }
    }
    
    func makeIterator() -> funcDomainIterator {
        return self.domain.makeIterator()
    }
}
