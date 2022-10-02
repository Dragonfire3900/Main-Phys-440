//
//  diffProtos.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 9/21/22.
//

import Foundation

protocol genericMap: AnyObject {
    typealias T = Double
    var currVal: [T] { get set }
    var params: [String: T] { get }
    var size: Int { get }
    
    init(currVal: [Double], params: [String: Double])
    
    func getKeys() -> [String]
    func next(time: Float) -> [T]
    
    func makeIterator(iterNum: Int, reset: Bool) -> genIter
}

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

struct genIter: Sequence, IteratorProtocol {
    typealias Element = [genericMap.T]
    
    let mapRef: any genericMap
    let iterNum: Int
    let reset: Bool
    let initVal: [genericMap.T]
    let stepSize: Float
    var curIdx: Int
    
    init(mapRef: any genericMap, iterNum: Int, stepSize: Float = 1.0, reset: Bool = true) {
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
