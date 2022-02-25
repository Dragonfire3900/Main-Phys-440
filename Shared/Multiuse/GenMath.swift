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
    
    func index(of: Double) -> Int? {
        let potIndex = Int(round((of - self.start) / self.stepSize))
        
        guard (potIndex > self.count) else {
            return nil
        }
        
        return potIndex
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
