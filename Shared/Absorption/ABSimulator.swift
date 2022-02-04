//
//  ABSimulator.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/4/22.
//

import Foundation

class ABSimulator {
    public var partNum: Int
    private var boundBox: Box
    
    init(particleNum: Int) {
        if (particleNum > 0) {
            self.partNum = particleNum
        } else {
            self.partNum = 1
        }
    }
}
