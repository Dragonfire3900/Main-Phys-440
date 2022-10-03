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
    
    func makeIterator(iterNum: Int, reset: Bool, stepSize: Double) -> genIter
    
    func engFunc(pos: T) -> T
    
    func firstDeriv(val:[T], pos: T) -> T
    
    func secondDeriv(val: [T], pos: T) -> T
}

extension shroeMap {
    var hBar2: T { return 7.63 }
    
    func next(time: T) -> [T] {
        
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
