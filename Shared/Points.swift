//  Describes the points class and the points collection class for operating on a series of points
//
//  Points.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/19/21.
//

import Foundation

class PointCollection {
    //Variables
    public var pointData: Array<Array<CGFloat>>
    
    //Constructors
    init() {
        //This is the designed constructor for the point collection
        self.pointData = Array(Array())
    }
    
    convenience init(initData: Array<Array<CGFloat>>) {
        self.init()
        let _ = self.setData(newData: initData)
    }
    
    
    
    //Getters
    public func getData() -> Array<Array<CGFloat>> {
        return self.pointData
    }
    
    public func getSize() -> Int {
        return self.pointData.count
    }
    
    public func getDimNum() -> Int {
        return self.pointData[0].count
    }
    
    //Setters
    public func setData(newData: Array<Array<CGFloat>>) -> Bool {
        /*
         Sets the entire dataset for the point collection
        
         Parameters
         ----------
         newData: Array<Array<CGFloat>>
            The new Data to set the point collection to which must have the same number of columns
        */
        let dim = newData[0].count
        
        for point in newData {
            if (point.count != dim) {
                return false
            }
        }
        
        self.pointData = newData
        
        return true
    }
    
    public func addPoint(newPoint: Array<CGFloat>) -> Bool {
        /*
         Add a new point to the collection
         
         Parameters
         ----------
         newPoint: Array<CGFloat>
            An array which describes the new point to append to the collection
         */
        if (self.getDimNum() != newPoint.count) {
            return false
        }
        
        self.pointData.append(newPoint)
        
        return true
    }
    
    //Calculators
    
    //Operators
    
}
