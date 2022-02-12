//
//  Particle.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/19/21.
//

import Foundation

/**
 Describes a single particle
 */
class Particle: Point {
    private var energy: Double = 100
    private var mass: Double = 1.0
    
    public var is_moving: Bool {
        get {
            if (energy >= 0.0) {
                return true
            } else {
                return false
            }
        }
    }
    
    public func subEnergy(eng: Double) {
        self.energy -= eng
    }
}
