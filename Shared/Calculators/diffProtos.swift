// A series of protocols for describing a recurrent map. Very useful for describing chaos and approximations
//
//  diffProtos.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 9/21/22.
//

import Foundation

// A generic reccurrent map. This does not have any history so previous values could get lost and assumes no historesis
protocol genericMap: AnyObject {
    typealias T = Double //What type is the data stored as
    var currVal: [T] { get set } //The current state of the map
    var params: [String: T] { get } //A datastore for the parameters in the reccurrent map
    var size: Int { get } //A calculated property for the number of values used to describe the map
    
    init(currVal: [Double], params: [String: Double])
    
    func getKeys() -> [String] //Returns all of the parameter keys in the map
    func next(time: T) -> [T] //Where the reccurrence happens
    
    func makeIterator(iterNum: Int, reset: Bool, stepSize: Double) -> genIter //Makes an iterator for the recurrent map.
}

//Giving implementation to the default functions of a generic map
extension genericMap {
    var size: Int {
        get {
            return currVal.count
        }
    }
    
    func getKeys() -> [String] {
        return Array(params.keys)
    }
}

//An iterator for the generic map
struct genIter: Sequence, IteratorProtocol {
    typealias Element = [genericMap.T]
    
    let mapRef: any genericMap //A reference to the map
    let iterNum: Int //How many iterations should be done
    let reset: Bool //If the initial state of the map should be restored upon completion
    let initVal: [genericMap.T] //The initial value ofthe map
    let stepSize: genericMap.T //The step size of the map (mainly used for continuous maps)
    var curIdx: Int //Where the iterator currently is
    
    init(mapRef: any genericMap, iterNum: Int, stepSize: genericMap.T = 1.0, reset: Bool = true) {
        self.mapRef = mapRef
        
        if iterNum < 0 {
            self.iterNum = 0
        } else {
            self.iterNum = iterNum
        }
        self.initVal = self.mapRef.currVal
        self.stepSize = stepSize
        self.curIdx = 0
        self.reset = reset
    }
    
    mutating func next() -> [genericMap.T]? {
        guard curIdx < iterNum else {
            if reset { mapRef.currVal = self.initVal }
            return nil
        }
        
        if self.curIdx == 0 {
            curIdx += 1
            return self.initVal
        }
        
        curIdx += 1
        return mapRef.next(time: self.stepSize)
    }
}
