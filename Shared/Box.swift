//  Describes the m-dimensional box class which is used in many different situations
//
//  Box.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/19/21.
//

import Foundation

//Possible Box Errors
enum BoxErrors: Error {
    case IncorrectDims //When the number of sides
}

class Box {
    //Variables
    private var cor1: Array<CGFloat> = [CGFloat]() //Needs to have the same count as c2
    private var cor2: Array<CGFloat> = [CGFloat]()
    
    //Constructors
    init(newCor1: Array<CGFloat>, newCor2: Array<CGFloat>) throws {
        //The designed constructor of this class
        if (newCor1.count == newCor2.count) {
            self.cor1 = newCor1
            self.cor2 = newCor2
        } else {
            throw BoxErrors.IncorrectDims
        }
    }
    
    //Setters
    
    //Getters
    
    //Calculators
    
    //Operators
}
