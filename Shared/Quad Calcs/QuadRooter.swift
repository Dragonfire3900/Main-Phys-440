//  A series of small functions which calculate the roots of a quadratic equation. Used to demonstraight subtractive cancelling
//
//  QuadRooter.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 1/28/22.
//

import Foundation

/**
 Uses the "normal" form of the quadratic equation in order to solve for the roots.
 
 - Authors:
    Joel Kelsey
 
 - Parameters:
    - a: The first constant in front of the x squared
    - b: The second constant in front of the x
    - c: The third constant which is stand alone
 
 - Returns: A tuple of length 2 which is the positive and negative root respectively
 
        The "normal" equation
                    __________
                 | / 2
         - b +-  |/ b   -  4ac
         ----------------------
                 2a
 */
func solveQuadEq(a: Double, b: Double, c: Double) -> (Double, Double) {
    return ( (-b + sqrt(pow(b, 2) - 4 * a * c)) / (2 * a),
             (-b - sqrt(pow(b, 2) - 4 * a * c)) / (2 * a))
}

/**
 Uses an alternative equation to solve for quadratic roots.
 
 - Authors:
    - Joel Kelsey
 
 - Parameters:
    - a: The first constant in front of the x squared
    - b: The second constant in front of the x
    - c: The third constant which is stand alone
 
 - Returns: A tuple of length 2 which is the positive and negative root respectively
 
 The "alternative" equation for the solution
 
                - 2c
         -------------------
                __________
             | / 2
       b +-  |/ b   -  4ac
 */
func solveQuadAltEq(a: Double, b: Double, c: Double) -> (Double, Double) {
    return ( (-2 * c) / (b + sqrt(pow(b, 2) - 4 * a * c)),
             (-2 * c) / (b - sqrt(pow(b, 2) - 4 * a * c)))
}
