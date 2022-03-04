//
//  GenMath.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/25/22.
//

import Foundation

class funcDomain: Sequence {
    let start: Double
    let end: Double
    let stepSize: Double
    let count: Int
    
    subscript(index: Int) -> Double {
        get {
            //TODO: Guard this
            return self.start + Double(index) * self.stepSize
        }
    }
    
    init(nStart: Double, nEnd: Double, nStepSize: Double) {
        //TODO: Actually guard on this initializer
        self.start = nStart
        self.end = nEnd
        self.stepSize = nStepSize
        
        self.count = Int((self.end - self.start) / self.stepSize)
    }
    
    func makeIterator() -> funcDomainIterator {
        return funcDomainIterator(self)
    }
    
    /// Returns the index right before the double if it's in the range
    /// - Parameter of: the double which you would like the index before of
    /// - Returns: The index right before this double value within the range
    func index(of: Double) -> Int? {
        let potIndex = Int(floor((of - self.start) / self.stepSize))
        
        guard (potIndex > self.count || potIndex < 0) else {
            return nil
        }
        
        return potIndex
    }
    
    /// Returns if the double is within the domain
    /// - Parameter val: The x-value where you would like to test
    /// - Returns: If the test value is within the domain or not
    func isIn(val: Double) -> Bool {
        if (val >= start && val <= end) {
            return true
        }
        return false
    }
}

class funcDomainIterator: IteratorProtocol {
    let domain: funcDomain
    var curIndex: Int = 0
    
    init(_ domain: funcDomain) {
        self.domain = domain
    }
    
    func next() -> Double? {
        let val = domain.start + domain.stepSize * Double(curIndex)
        guard (val >= domain.end) else {
            return nil
        }
        
        curIndex += 1
        return val
    }
}
