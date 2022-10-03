// A File for all of the different continuous reccurrent maps that I need
//
//  contMaps.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 10/2/22.
//

import Foundation

// A class representing a pendulum as a recurrent map using runga-kutta 4
class pendulumMap: genericMap {
    var currVal: [T]
    var params: [String : T] = [:]
    var time: T = 0.0
    
    required init(currVal: [Double], params: [String : Double]) {
        if currVal.count >= 2 {
            self.currVal = [currVal[0], currVal[1]]
        } else {
            self.currVal = [0.1, 0.1]
        }
        
        self.params["natural frequency"] = params["natural frequency", default: 0.1]
        self.params["Air resistence coef."] = params["Air resistence coef.", default: 0.1]
        self.params["Driving force"] = params["Driving force", default: 0.1]
        self.params["Driving force frequency"] = params["Driving force frequency", default: 0.1]
    }
    
    //This is where the rk4 algorithm is implemented. Can be done by representing the pendulum as two
    //dependent differential equations
    func next(time: T) -> [T] {
        var tmpVal = currVal
        let k0 = time * firstDeriv(val: tmpVal, time: self.time)
        let l0 = time * secondDeriv(val: tmpVal, time: self.time)
        
        tmpVal = [currVal[0] + k0 * 0.5, currVal[1] + l0 * 0.5]
        let k1 = time * firstDeriv(val: tmpVal, time: self.time + time * 0.5)
        let l1 = time * secondDeriv(val: tmpVal, time: self.time + time * 0.5)
        
        tmpVal = [currVal[0] + k1 * 0.5, currVal[1] + l1 * 0.5]
        let k2 = time * firstDeriv(val: tmpVal, time: self.time + time * 0.5)
        let l2 = time * secondDeriv(val: tmpVal, time: self.time + time * 0.5)
        
        tmpVal = [currVal[0] + k2 * 0.5, currVal[1] + l2 * 0.5]
        let k3 = time * firstDeriv(val: tmpVal, time: self.time + time)
        let l3 = time * secondDeriv(val: tmpVal, time: self.time + time)
        
        currVal[0] = currVal[0] + (1.0 / 6.0) * (k0 + 2*k1 + 2*k2 + k3)
        currVal[1] = currVal[1] + (1.0 / 6.0) * (l0 + 2*l1 + 2*l2 + l3)
        
        self.time += time
        
        return currVal
    }
    
    func makeIterator(iterNum: Int, reset: Bool, stepSize: Double) -> genIter {
        return genIter(mapRef: self, iterNum: iterNum, stepSize: stepSize, reset: reset)
    }
    
    //The first derivative is just returns the velocity (derivative of position)
    func firstDeriv(val: [Double], time: Double) -> Double {
        return val[1]
    }
    
    //The second derivative returns how the velocity changes over time
    func secondDeriv(val: [Double], time: Double) -> Double {
        return -1.0 * pow(params["natural frequency", default: 0.1], 2) * sin(val[0]) - params["Air resistence coef.", default: 0.1] * val[1] + params["Driving force", default: 0.1] * cos(params["Driving force frequency", default: 0.1] * time)
    }
}
