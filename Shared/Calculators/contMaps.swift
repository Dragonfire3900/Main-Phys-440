// A File for all of the different continuous reccurrent maps that I need
//
//  contMaps.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 10/2/22.
//

import Foundation

protocol shroeMap: genericMap {
    var hBar2: T { get }
    var pos: T { get set }
    
    func makeIterator(iterNum: Int, reset: Bool, stepSize: Double) -> genIter
    
    func engFunc(pos: T) -> T
    
    func firstDeriv(val:[T], pos: T) -> T
    
    func secondDeriv(val: [T], pos: T) -> T
}

extension shroeMap {
    var hBar2: T { return 7.63 }
    
    func next(time: T) -> [T] {
        var tmpVal = currVal
        let k0 = time * firstDeriv(val: tmpVal, pos: self.pos)
        let l0 = time * secondDeriv(val: tmpVal, pos: self.pos)
        
        tmpVal = [currVal[0] + k0 * 0.5, currVal[1] + l0 * 0.5]
        let k1 = time * firstDeriv(val: tmpVal, pos: self.pos + time * 0.5)
        let l1 = time * secondDeriv(val: tmpVal, pos: self.pos + time * 0.5)
        
        tmpVal = [currVal[0] + k1 * 0.5, currVal[1] + l1 * 0.5]
        let k2 = time * firstDeriv(val: tmpVal, pos: self.pos + time * 0.5)
        let l2 = time * secondDeriv(val: tmpVal, pos: self.pos + time * 0.5)
        
        tmpVal = [currVal[0] + k2 * 0.5, currVal[1] + l2 * 0.5]
        let k3 = time * firstDeriv(val: tmpVal, pos: self.pos + time)
        let l3 = time * secondDeriv(val: tmpVal, pos: self.pos + time)
        
        currVal[0] = currVal[0] + (1.0 / 6.0) * (k0 + 2*k1 + 2*k2 + k3)
        currVal[1] = currVal[1] + (1.0 / 6.0) * (l0 + 2*l1 + 2*l2 + l3)
        
        self.pos += time
        
        return currVal
    }
    
    func makeIterator(iterNum: Int, reset: Bool, stepSize: Double) -> genIter {
        return genIter(mapRef: self, iterNum: iterNum, stepSize: stepSize, reset: reset)
    }
    
    func firstDeriv(val:[T], pos: T) -> T {
        return val[1]
    }
    
    func secondDeriv(val: [T], pos: T) -> T {
        let hBar2 = 7.63
        return 2.0 / hBar2 * engFunc(pos: pos) * val[0]
    }
}
