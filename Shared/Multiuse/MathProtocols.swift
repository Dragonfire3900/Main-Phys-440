//
//  MathProtocols.swift
//  Main Phys 440 (iOS)
//
//  Created by Joel Kelsey on 2/25/22.
//

import Foundation

/// A type of math function which is only defined on a specific domain
protocol RestrictedFunc {
    
}

/// A type of math function which maps a bunch of values to a single value
protocol Projector {
    /// Evaulate the function at some x-coordinate
    /// - Returns: The value of this mathematical function at that point
    func Eval(vals: [Double]) -> Double
}

/// A type of math function which is recurssive in nature
protocol MathRecursive: Sequence, IteratorProtocol {
    /// The initial point which this recursive function has information about
    let initPt: [Double]
    
    /// The initial value at that particular point
    let initVal: Double
}
