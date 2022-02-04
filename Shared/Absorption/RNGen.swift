//  A list describing the RNGen protocol and its implementations
//
//  RNGen.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import Foundation

/**
 A protocol which describes how to generate a random number and a random direction (Assumes 2D)
 
 - Authors: Joel Kelsey
 
 - Version: 0.1 which is probably the only version
 */
protocol RNGen {
    /**
     A function which generates a single double which can be used to make some type of decision
     */
    func getRN() -> Double
    func getRN(lower: Double, upper: Double) -> Double
    
    /**
     A function which generates a random 2D direction
     */
    func getRDir() -> (Double, Double)
}
