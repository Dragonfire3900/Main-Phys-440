//
//  Box.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import Foundation

class Box {
    private var dims: [Double]
    private var center: [Double]
    
    init() {
        self.dims = [0.0]
        self.center = [0.0]
    }
    
    init(newDims: [Double], newCen: [Double]) {
        if (newDims.count != newCen.count || newDims.count == 0 || newCen.count == 0) {
            self.dims = [0.0]
            self.center = [0.0]
        } else {
            self.dims = newDims
            self.center = newCen
        }
    }
    
    public func isInside(testpt: Point) -> Bool {
        for i in 0...self.dims.count {
            if (self.center[i] + self.dims[i] <= testpt[i] || self.center[i] - self.dims[i] >= testpt[i]) {
                return false
            }
        }
        return true
    }
}
