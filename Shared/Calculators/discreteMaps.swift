//
//  ActualMaps.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 9/27/22.
//

import Foundation

enum DiscMaps: String, CaseIterable, Identifiable {
    case log, ecology, gaussian, tent, quartic
    var id: Self { self }
}

extension DiscMaps {
    var actMap: any genericMap {
        switch self {
        case .log: return logMap(firstVal: 1.0, mu: 0.1)
        case .ecology: return ecoMap(currVal: [1.0], params: ["mu": 0.1])
        case .gaussian: return gaussMap(firstVal: 1.0, mu: 0.1, b: 0.1)
        case .tent: return tentMap(currVal: [1.0], params: ["mu": 0.1])
        case .quartic: return quartMap(currVal: [1.0], params: ["mu": 0.1])
        }
    }
}

//A logistic reccurrent map. Has only one parameter: mu
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
    
    func next(time: T) -> [T] {
        currVal[0] = (params["mu", default: 1.0]) * currVal[0] * (1.0 - currVal[0])
        return currVal
    }
    
    func makeIterator(iterNum: Int, reset: Bool = true, stepSize: Double) -> genIter {
        return genIter(mapRef: self, iterNum: iterNum, reset: reset)
    }
}

//A gaussian reccurrent map with two parameters: b and mu
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
    
    func next(time: T) -> [T] {
        currVal[0] = currVal[0] * exp(params["b"]! * pow(currVal[0], 2)) + params["mu"]!
        return currVal
    }
    
    func makeIterator(iterNum: Int, reset: Bool = true, stepSize: Double) -> genIter {
        return genIter(mapRef: self, iterNum: iterNum, reset: reset)
    }
}

//An ecological recurrent map with parameter: mu
class ecoMap: genericMap {
    var currVal: [T]
    var params: [String : T] = [:]
    
    required init(currVal: [Double], params: [String : Double]) {
        if currVal.count >= 1 {
            self.currVal = [currVal[0]]
        } else {
            self.currVal = [1.0]
        }
        
        self.params["mu"] = params["mu", default: 0.1]
    }
    
    func next(time: T) -> [T] {
        currVal[0] = currVal[0] * exp(params["mu", default: 0.1] * (1 - currVal[0]))
        return currVal
    }
    
    func makeIterator(iterNum: Int, reset: Bool, stepSize: Double) -> genIter {
        return genIter(mapRef: self, iterNum: iterNum, reset: reset)
    }
}

//A tent recurrent map with parameter: mu
class tentMap: genericMap {
    var currVal: [T]
    var params: [String : T] = [:]
    
    required init(currVal: [Double], params: [String : Double]) {
        if currVal.count >= 1 {
            self.currVal = [currVal[0]]
        } else {
            self.currVal = [1.0]
        }
        
        self.params["mu"] = params["mu", default: 0.1]
    }
    
    func next(time: T) -> [T] {
        currVal[0] = params["mu", default: 0.1] * (1 - 2 * abs(currVal[0] - 0.5))
        return currVal
    }
    
    func makeIterator(iterNum: Int, reset: Bool, stepSize: Double) -> genIter {
        return genIter(mapRef: self, iterNum: iterNum, reset: reset)
    }
}

//A quartic map with parameter: mu
class quartMap: genericMap {
    var currVal: [T]
    var params: [String : T] = [:]
    
    required init(currVal: [Double], params: [String : Double]) {
        if currVal.count >= 1 {
            self.currVal = [currVal[0]]
        } else {
            self.currVal = [1.0]
        }
        
        self.params["mu"] = params["mu", default: 0.1]
    }
    
    func next(time: T) -> [T] {
        currVal[0] = params["mu", default: 0.1] * (1 - pow(2 * currVal[0] - 1, 4))
        return currVal
    }
    
    func makeIterator(iterNum: Int, reset: Bool, stepSize: Double) -> genIter {
        return genIter(mapRef: self, iterNum: iterNum, reset: reset)
    }
}
