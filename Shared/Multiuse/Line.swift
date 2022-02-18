//
//  Line.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/18/22.
//

import Foundation
import SwiftUI

struct Line: Identifiable {
    var p1: ColorPoint
    var p2: ColorPoint
    var col: Color
    var weight: Double
    
    let id = UUID()
    
    func getBetween(perc: Double) -> ColorPoint{
        let dims: [Double] = (0..<min(p1.count, p2.count)).map { perc * p1[$0] + (1 - perc) * p2[$0]} //Doing a weighted average between the two points
        return ColorPoint(dimArr: dims, col: self.col)
    }
    
    
    /// Gets a point along the line but some perpendicular distance away from the line
    /// - Parameters:
    ///   - perc: The percentage distance between the two points
    ///   - dist: The perpendicular distance away from the line
    ///   - above: If the point should be above or below the line
    /// - Returns: A point with the desired coordinates
    func getPara(perc: Double, dist: Double, above: Bool) -> ColorPoint {
        let diff: [Double] = (0..<min(p1.count, p2.count)).map { p2[$0] - p1[$0] } //Getting the normal
        let mag: Double = sqrt(diff.reduce(0, { x, y in
            x + pow(y, 2)
        })) //Getting the magnitude of that normal
        
        let pt = self.getBetween(perc: perc)
        
        if above {
            let dims: [Double] = (0..<pt.count).map { pt[$0] + dist * diff[$0] / mag }
            return ColorPoint(dimArr: dims, col: self.col)
        } else {
            let dims: [Double] = (0..<pt.count).map { pt[$0] - dist * diff[$0] / mag }
            return ColorPoint(dimArr: dims, col: self.col)
        }
    }
}
