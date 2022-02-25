//
//  point.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import Foundation
import SwiftUI

enum PointError: Error {
    case OutOfBounds(i: Int)
    case IncorrectDimensions(expected: Int, got: Int)
}

class Point: Identifiable, Hashable, ObservableObject, CustomStringConvertible {
    @Published internal var dims: [Double]
    
    public var description: String {
        get {
            return dims.reduce("(", { jStr, dim in
                jStr + "\(dim), "
            }).dropLast(2) + ")"
        }
    }
    
    public var count: Int {
        get {
            return self.dims.count
        }
    }
    
    public var x: Double {
        get {
            return self.dims[0]
        }
    }
    
    public var y: Double {
        get {
            return self.dims[1]
        }
    }
    
    public var z: Double {
        get {
            return self.dims[2]
        }
    }
    
    init() {
        self.dims = []
    }
    
    init(x: Double) {
        self.dims = [x]
    }
    
    init(x: Double, y: Double) {
        self.dims = [x, y]
    }
    
    init(x: Double, y: Double, z: Double) {
        self.dims = [x, y, z]
    }
    
    init(dimArr: [Double]) {
        self.dims = dimArr
    }
    
    init(pt: Point) {
        self.dims = pt.dims
    }
    
    subscript(index: Int) -> Double {
        get {
            return self.dims[index]
        }
        
        set(newValue) {
            self.dims[index] = newValue
        }
    }
    
    static func == (lhs: Point, rhs: Point) -> Bool {
        if (lhs.count != rhs.count) {
            return false
        }
        
        for index in 0..<lhs.count {
            if (lhs[index] != rhs[index]) { return false }
        }
        
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        for index in 0..<self.count {
            hasher.combine(self.dims[index])
        }
    }
    
    func move(nPt: [Double]) throws {
        if (self.count != nPt.count) {
            throw PointError.IncorrectDimensions(expected: self.count, got: nPt.count)
        }
        
        for i in 0..<self.count {
            self.dims[i] += nPt[i]
        }
    }
    
    func move(pt: Point) {
        for i in 0..<min(self.count, pt.count) {
            self.dims[i] += pt.dims[i]
        }
    }
    
    func move(index: Int, nPt: Double) {
        self.dims[index] += nPt
    }
    
    func absMove(nPt: [Double]) throws {
        if (self.count != nPt.count) {
            throw PointError.IncorrectDimensions(expected: self.count, got: nPt.count)
        }
        
        self.dims = nPt
    }
    
    func absMove(index: Int, nPt: Double) {
        self.dims[index] = nPt
    }
}

class ColorPoint: Point {
    public var col: Color
    
    override init() {
        self.col = Color.white
        super.init()
    }
    
    init(x: Double, col: Color) {
        self.col = col
        super.init(x: x)
    }
    
    init(x: Double, y: Double, col: Color) {
        self.col = col
        super.init(x: x, y: y)
    }
    
    init(x: Double, y: Double, z: Double, col: Color) {
        self.col = col
        super.init(x: x, y: y, z: z)
    }
    
    init(dimArr: [Double], col: Color) {
        self.col = col
        super.init(dimArr: dimArr)
    }
    
    init(oPt: Point, col: Color) {
        self.col = col
        super.init(pt: oPt)
    }
}
