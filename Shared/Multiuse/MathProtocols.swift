//
//  MathProtocols.swift
//  Main Phys 440 (iOS)
//
//  Created by Joel Kelsey on 2/25/22.
//

import Foundation

/// A type of math function which is only defined on a specific domain
protocol funcDomRestriction: Sequence {
    var domain: funcDomain { get }
    
    func makeIterator() -> funcDomainIterator
}

/// A type of math function which maps a bunch of values to a single value
protocol Projector {
    /// Evaulate the function at some coordinates
    /// - Returns: The value of this mathematical function at that point
    func Eval(val: Double) -> Double?
}

/// A type of math function which is recurssive in nature
protocol MathRecursive: Sequence {
    /// The initial point which this recursive function has information about
    var initPt: Double { get }
    
    /// The initial value at that particular point
    var initVal: Double { get }
}

/// A type of function which stores its values along the way and has some form of interpolation if needed
protocol StoredFunc {
    var storedVals: [Double] { get set }
    
    func Interp(xVal: Double) -> Double
    
    func Interp(befInd: Int, xVal: Double) -> Double
}


//The protocols we actually use
protocol RestrictProject: Projector, funcDomRestriction {}
