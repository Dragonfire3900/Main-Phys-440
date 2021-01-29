//
//  Sphere.swift
//  Shared
//
//  Created by Joel Kelsey on 1/29/21.
//

import SwiftUI

class Circle: Ellipse {
    //Class variables
        //Published
        @Published var radius: Double
        @Published var radiusStr: String

    //Initialization Functions
        ///Init
        ///  The Default initialization function
        func init() {
            self.setRadius(1.0)
        }

        ///Init
        ///  The initialization of a sphere of arbitrary radius
        ///  - Parameters:
        ///    - Radius: The radius of the sphere
        func init(Radius: Double) {
            self.setRadius(Radius: Radius)
        }

    
    //Setting Functions
        ///setRadius
        ///  Sets the radius of the sphere
        ///  - Parameters:
        ///    - Radius: The radius of the sphere
        func setRadius(Radius: Double) -> Bool {
            //The radius must be positive
            if (!self.setAxis(firstAxis: Radius, secondAxis: Radius, thirdAxis: Radius)) {
                return false
            }

            self.radius = Radius
            self.radiusStr = String(format: "%7.5f", self.radius)
            return true
        }

        ///setRadius
        ///  Sets the radius of the sphere given a string
        ///  - Parameters:
        ///    - Radius: A string representing the radius
        func setRadius(Radius: String) -> Bool {
            return self.setRadius(Radius: Double(Radius))
        }


    //Calculation Functions
        ///calculateSSurfaceArea
        ///  Calculates the surface area of the sphere
        override func calculateSSurfaceArea() {
            // Surface Area = 4 * pi * r ^ 2
            self.setSSurfaceArea(4 * Double.pi * pow(self.radius, 2))
        }
}