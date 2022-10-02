//
//  ActualMaps.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 9/27/22.
//

import Foundation

enum DiscMaps: String, CaseIterable, Identifiable {
    case log, gauss
    var id: Self { self }
}

extension DiscMaps {
    var actMap: any genericMap {
        switch self {
        case .log: return logMap(firstVal: 1.0, mu: 0.1)
        case .gauss: return gaussMap(firstVal: 1.0, mu: 0.1, b: 0.1)
        }
    }
}

class logMap: genericMap {
    var currVal: [T]
    var params: [String : T] = [:]
    
    required init(currVal: [T], params: [String: T]) {
        if currVal.count > 0 {
            self.currVal = [currVal[0]]
        } else {
            self.currVal = [0.1]
        }
        
        self.params["mu"] = params["mu", default: 0.1]
    }
    
    init(firstVal: T, mu: T) {
        currVal = [firstVal]
        params["mu"] = mu
    }
    
    convenience init(firstVal: T) {
        self.init(firstVal: firstVal, mu: 0.1)
    }
    
    func next(time: Float) -> [T] {
        currVal[0] = (params["mu", default: 1.0]) * currVal[0] * (1.0 - currVal[0])
        return currVal
    }
    
    func makeIterator(iterNum: Int, reset: Bool = true) -> genIter {
        return genIter(mapRef: self, iterNum: iterNum, reset: reset)
    }
}

class gaussMap: genericMap {
    var currVal: [T]
    var params: [String : T] = [:]
    
    required init(currVal: [Double], params: [String : Double]) {
        if currVal.count > 0 {
            self.currVal = [currVal[0]]
        } else {
            self.currVal = [0.1]
        }
        
        self.params["mu"] = params["mu", default: 0.1]
        self.params["b"] = params["b", default: 0.1]
    }
    
    init(firstVal: T, mu: T, b: T) {
        self.currVal = [firstVal]
        self.params["mu"] = mu
        self.params["b"] = b
    }
    
    convenience init(firstVal: T) {
        self.init(firstVal: firstVal, mu: 0.1, b: 0.1)
    }
    
    func next(time: Float) -> [T] {
        currVal[0] = currVal[0] * exp(params["b"]! * pow(currVal[0], 2)) + params["mu"]!
        return currVal
    }
    
    func makeIterator(iterNum: Int, reset: Bool = true) -> genIter {
        return genIter(mapRef: self, iterNum: iterNum, reset: reset)
    }
}
