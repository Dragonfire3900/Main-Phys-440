//
//  point.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import Foundation

enum PointError: Error {
    case OutOfBounds(i: Int)
}

class Point {
    private var pos: (x: Double, y: Double, z: Double)
    
    public var x: Double {
        get {
            return self.pos.x
        }
    }
    
    public var y: Double {
        get {
            return self.pos.y
        }
    }
    
    public var z: Double {
        get {
            return self.pos.z
        }
    }
    
    subscript(index: Int) -> Double {
        get {
            switch index {
            case 0:
                return self.pos.x
            case 1:
                return self.pos.y
            case 2:
                return self.pos.z
            default:
                throw PointError.OutOfBounds(i: index)
            }
        }
    }
    
    init() {
        self.pos = (0.0, 0.0, 0.0)
    }
    
    init(x: Double, y: Double, z: Double) {
        self.pos = (x, y, z)
    }
    
    /**
     Moves a coordinate point without taking the initial position into account
     */
    public func absMove(x: Double, y: Double, z: Double) {
        self.pos = (x, y, z)
    }
    
    /**
    Moves a coordinate point relative to the initial point
     */
    public func move(x: Double, y: Double, z: Double) {
        self.pos = (self.pos.x + x, self.pos.y + y, self.pos.z + z)
    }
    
    public func getXY() -> CGPoint {
        return CGPoint(x: self.pos.x, y: self.pos.y)
    }
    
    public func getYZ() -> CGPoint {
        return CGPoint(x: self.pos.y, y: self.pos.z)
    }
    
    public func getXZ() -> CGPoint {
        return CGPoint(x: self.pos.x, y: self.pos.z)
    }
}
