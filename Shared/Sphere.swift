//
//  Sphere.swift
//  Shared
//
//  Created by Joel Kelsey on 1/29/21.
//

import SwiftUI

class Sphere: Ellipsoid {
    //Class variables
        //Published
        @Published var radius: Double = 1.0
        @Published var radiusStr: String = ""
    
    //Setting Functions
        ///setRadius
        ///  Sets the radius of the sphere
        ///  - Parameters:
        ///    - Radius: The radius of the sphere
        func setRadius(Radius: Double) -> Bool {
            //The radius must be positive
            if (Radius < 0.0) {
                return false
            }

            self.radius = Radius
            self.radiusStr = String(format: "%7.5f", self.radius)
            self.setAxis(firstAxis: Radius, secondAxis: Radius, thirdAxis: Radius)
            return true
        }

        ///setRadius
        ///  Sets the radius of the sphere given a string
        ///  - Parameters:
        ///    - Radius: A string representing the radius
        func setRadius(Radius: String) -> Bool {
            return self.setRadius(Radius: Double(Radius)!)
        }


    //Calculation Functions
        ///calculateSSurfaceArea
        ///  Calculates the surface area of the sphere
        override func calculateSSurfaceArea() {
            // Surface Area = 4 * pi * r ^ 2
            self.setSSurfaceArea(calcSA: 4.0 * Double.pi * pow(self.radius, 2.0))
        }
}
