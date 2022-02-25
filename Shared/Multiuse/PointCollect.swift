//
//  PointCollect.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/24/22.
//

import Foundation

class PointCollect<T>: ObservableObject {
    @Published internal var pointArr: [T]
    
    var count: Int {
        get {
            return self.pointArr.count
        }
    }
    
    init() {
        self.pointArr = []
    }
    
    init(initArr: [T]) {
        self.pointArr = initArr
    }
    
    //Mutators
    
    /// Appends a point to the collection
    /// - Parameter newElement: The new element of the collection
    func append(newElement: T) {
        self.pointArr.append(newElement)
    }
    
    func removeAll() {
        self.removeAll()
    }
    
    /// Groups the point indexes into groups so that they can be processed asyncronously
    /// - Returns: An array of two integers showing what point to begin on and what point to end on. Upper end exclusive
    func groupPoints(processorCount: Int) -> [[Int]] {
        var ptGroup: [[Int]] = []
        
        if (self.count > 0) {
            let actProccess = min(processorCount, ProcessInfo.processInfo.processorCount)
            
            let countDiv = self.count / actProccess
            
            for i in 0..<actProccess {
                ptGroup.append([i * countDiv, (i+1) * countDiv])
            }
            
            ptGroup[ptGroup.count - 1][1] = self.count
        }
        
        return ptGroup
    }
    
    /// Applies an asyncronous function to all of the points in the point collection
    /// - Parameter fun: The function you want to apply to all of the points
    func applyFunc(fun: (T) async -> Void, proccessorCount: Int) async {
        let ptGroups = self.groupPoints(processorCount: proccessorCount)
        
        await withTaskGroup(of: Void.self) { group in
            for i in 0..<ptGroups.count {
                
            }
        }
    }
}
