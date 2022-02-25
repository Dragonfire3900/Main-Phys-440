//
//  Box.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import Foundation

/// A general box class which represents an n-dimensional box
class Box {
    var dims: [Double]
    var center: [Double]
    
    public var count: Int {
        get {
            return self.dims.count
        }
    }
    
    init() {
        self.dims = [0.0]
        self.center = [0.0]
    }
    
    /// An initializer for the box given the length of its sides and the center of the box
    /// - Parameters:
    ///   - newDims: The lengths of the sides of the box with 0 as the first dimension
    ///   - newCen: Where the center of the box is
    init(newDims: [Double], newCen: [Double]) {
        if (newDims.count != newCen.count || newDims.count == 0 || newCen.count == 0) {
            self.dims = [0.0]
            self.center = [0.0]
        } else {
            self.dims = newDims
            self.center = newCen
        }
    }
    
    
    /// Gives the length of the box for dimension number
    /// - Parameter dimNum: Which dimension you want the length of
    /// - Returns: The length of the box in that specific dimension
    public func getLength(dimNum: Int) -> Double {
        return self.dims[dimNum]
    }
    
    public func getCenter() -> [Double] {
        return self.center
    }
    
    public func getCenter(dimNum: Int) -> Double {
        return self.center[dimNum]
    }
    
    /// Gets the left side of the nth dimension of the box
    /// - Parameter dimNum: The dimension number
    /// - Returns: Where the left side of the box is in dimension n
    public func getLeftSide(dimNum: Int) -> Double {
        return self.center[dimNum] - self.dims[dimNum] / 2.0
    }
    
    /// Gets the right side of the nth dimension of the box
    /// - Parameter dimNum: The dimension number
    /// - Returns: Where the right side of the box is in dimension n
    public func getRightSide(dimNum: Int) -> Double {
        return self.center[dimNum] + self.dims[dimNum] / 2.0
    }
    
    /// A function returning if the given point is inside the box
    /// - Parameter testpt: The point to test if it's inside the box
    /// - Returns: A boolean telling if the point is inside the box
    public func isInside(testpt: Point) -> Bool {
        for i in 0..<min(self.dims.count, testpt.count) {
            if (!(testpt[i] >= self.getLeftSide(dimNum: i) || self.getRightSide(dimNum: i) <= testpt[i])) {
                return false
            }
        }
        return true
    }
    
    
    /// Creates a single random point within the bounding box inclusive of the boxes border
    /// - Returns: A point within this box
    public func getPoint() -> Point {
        var rndPt: [Double] = []
        
        for i in 0..<self.dims.count {
            rndPt.append(Double.random(in: 0...self.dims[i]) + self.center[i] - self.dims[i] / 2.0)
        }
        
        return Point(dimArr: rndPt)
    }
    
    /// Creates a single random point within the length of the box but does not account for the offset of the center of the box
    /// - Returns: A point within the length of the box but not shifted to be inside the box itself
    public func getCentralPoint() -> Point {
        let rndPt = (0..<self.dims.count).map({ Double.random(in: 0...self.dims[$0])})
        
        return Point(dimArr: rndPt)
    }
    
    public func getArea() -> Double {
        var a = 1.0
        for i in 0..<self.count {
            a *= self.dims[i]
        }
        
        return a
    }
    
    
    /// Squishes a point into this box given another box as the original limits
    /// - Parameters:
    ///   - pt: The point to squish
    ///   - bBox: The original bounding box
    ///   - inPlace: If the original point should be moved or if a new point should be created
    public func squishPt(pt: Point, bBox: Box, inPlace: Bool) -> Point {
        if (self.count != bBox.count) {
            print("The dimensions of this box and the bounding box did not match")
            return pt
        }
        
        if (pt.count != self.count) {
            print("The number of dimensions of the point and this box do not match")
            return pt
        }
        
        if inPlace {
            for i in 0..<self.count {
                pt.absMove(index: i,
                           nPt: self.getLength(dimNum: i) / bBox.getLength(dimNum: i) * (pt[i] - bBox.getCenter(dimNum: i)) + self.getCenter(dimNum: i))
            }
            return pt
        } else {
            var mv: [Double] = []
            
            for i in 0..<self.count {
                mv.append(
                    self.getLength(dimNum: i) / bBox.getLength(dimNum: i) * (pt[i] - bBox.getCenter(dimNum: i)) + self.getCenter(dimNum: i)
                )
            }
            
            return Point(dimArr: mv)
        }
    }
    
    /// Squishes a box into relative coordinates to each other. Effectively scales the two boxes to make it easier to display
    /// - Parameters:
    ///   - oBox: The other box to squish into this one
    ///   - scaleBox: The box which is used as a scale
    ///   - inPlace: If the other box should be modified or if a new box should be found
    /// - Returns: Returns a box which is the squished version
    public func squishBox(oBox: Box, scaleBox: Box, inPlace: Bool) -> Box {
        if (self.count != oBox.count && self.count != scaleBox.count) {
            print("The boxes your trying to squish are in different dimensions")
            return oBox
        }
        
        let scales = (0..<self.count).map({ self.dims[$0] / scaleBox.dims[$0] })
        
        if (inPlace) {
            for i in 0..<self.count {
                oBox.dims[i] = oBox.dims[i] * scales[i]
                oBox.center[i] = self.center[i] + scales[i] * (oBox.center[i] - scaleBox.center[i])
            }
            
            return oBox
        } else {
            let dims = (0..<self.count).map({
                scales[$0] * oBox.dims[$0]
            })
            
            let cen = (0..<self.count).map({
                self.center[$0] + scales[$0] * (oBox.center[$0] - scaleBox.center[$0])
            })

            return Box(newDims: dims, newCen: cen)
        }
    }
    
    public func squishPt(pt: Point, bBox: Box, inPlace: Bool, mods: [Double]) -> Point {
        if (self.count != bBox.count) {
            print("The dimensions of this box and the bounding box did not match")
            return pt
        }
        
        if (pt.count != self.count) {
            print("The number of dimensions of the point and this box do not match")
            return pt
        }
        
        if (mods.count != self.count) {
            print("The number of modifiers does not match this point")
            return pt
        }
        
        if inPlace {
            for i in 0..<self.count {
                pt.absMove(index: i,
                           nPt: self.getLength(dimNum: i) / bBox.getLength(dimNum: i) * ((pt[i] - bBox.getCenter(dimNum: i)) * mods[i]) + self.getCenter(dimNum: i))
            }
            return pt
        } else {
            var mv: [Double] = []
            
            for i in 0..<self.count {
                mv.append(
                    self.getLength(dimNum: i) / bBox.getLength(dimNum: i) * ((pt[i] - bBox.getCenter(dimNum: i)) * mods[i]) + self.getCenter(dimNum: i)
                )
            }
            
            return Point(dimArr: mv)
        }
    }
}
