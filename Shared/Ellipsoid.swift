//
//  Ellipsoid.swift
//  Shared
//
//  Created by Joel Kelsey on 1/29/21.
//

import SwiftUI

class Ellipsoid: NSObject, ObservableObject {

    //Class variables
        //Internal variables
        internal var firstAxisLength: Double
        internal var secondAxisLength: Double
        internal var thirdAxisLength: Double

        //Published
        @Published var volume: Double
        @Published var surfaceArea: Double
        @Published var volumeStr: String
        @Published var surfaceAreaStr: String

        @Published var bbVolume: Double
        @Published var bbSurfaceArea: Double
        @Published var bbVolumeStr: String
        @Published var bbSurfaceAreaStr: String
    
    //Initialization Functions
        ///init
        ///  Default initialization for an ellipsoid
        func init() {
            self.setAxis(firstAxis: 1.0, secondAxis: 1.0, thirdAxis: 1.0)

            //TODO: Implement actual SA calculation
            self.setSSurfaceArea(calcSA: 1.0)
        }

        ///init
        ///  Initialization function for an ellipsoid
        func init(firstAxis: Double, secondAxis: Double, thirdAxis: Double) {
            self.setAxis(firstAxis: firstAxis, secondAxis: secondAxis, thirdAxis: thirdAxis)

            self.setSSurfaceArea(calcSA: 1.0)
        }


    //Setting Functions
        ///setAxis
        ///  Sets the length of the axis and does some error checking. Also updates the volume and surface area of ellipsoid
        ///  - Parameters:
        ///    - firstAxis: The length of the first axis
        ///    - secondAxis: The length of the second axis
        ///    - thirdAxis: The length of the third axis
        func setAxis(firstAxis: Double, secondAxis: Double, thirdAxis: Double) -> Bool {
            if (!self.setAxis(firstAxis: firstAxis)) {
                return false
            }

            if (!self.setAxis(secondAxis: secondAxis)) {
                return false
            }

            if (!self.setAxis(thirdAxis: thirdAxis)) {
                return false
            }

            self.calculateVolume()
            self.calculateSurfaceArea()

            return true
        }

        ///setAxis
        ///  Sets the length of the first axis and does some error checking
        ///  - Parameters:
        ///    - firstAxis: The length of the first axis
        func setAxis(firstAxis: Double) -> Bool {
            //Length cannot be less than zero
            if (firstAxis < 0) {
                return false
            }

            self.firstAxisLength = firstAxis
            return true
        }

        ///setAxis
        ///  Sets the length of the second axis and does some error checking
        ///  - Parameters:
        ///    - secondAxis: The length of the second axis
        func setAxis(secondAxis: Double) -> Bool {
            //Length cannot be less than zero
            if (secondAxis < 0) {
                return false
            }

            self.secondAxisLength = secondAxis
            return true
        }

        ///setAxis
        ///  Sets the length of the third axis and does some error checking
        ///  - Parameters:
        ///    - thirdAxis: The length of the third axis
        func setAxis(thirdAxis: Double) -> Bool {
            //Length cannot be less than zero
            if (thirdAxis < 0) {
                return false
            }

            self.thirdAxisLength = thirdAxis
            return true
        }

        ///setSVolume
        ///  Sets the volume of the ellipsoid and in turn updates the volume string
        ///  - Parameters:
        ///    - calcVolume: The calculated volume of the ellipsoid
        internal func setSVolume(calcVolume: Double) -> Bool {
            //Volume cannot be negative
            if (calcVolume < 0) {
                return false
            }

            self.volume = calcVolume
            self.volumeStr = String(format: "%7.5f", self.volume)
            return true
        }

        ///setbbVolume
        ///  Sets the volume of the bounding box and in turn updates the bb volume string
        ///  - Parameters:
        ///    - calcbbVolume: The calculated volume of the bounding box
        internal func setbbVolume(calcbbVolume: Double) -> Bool {
            if (calcbbVolume < 0) {
                return false
            }

            self.bbVolume = calcbbVolume
            self.bbVolumeStr = String(format: "%7.5f", self.volume)
            return true
        }

        ///setSSurfaceArea
        ///  Sets the surface area of the ellipsoid and in turn updates the SA string
        ///  - Parameters:
        ///    - calcSA: The calculated surface area of the ellipsoid
        internal func setSSurfaceArea(calcSA: Double) -> Bool {
            //Surface area cannot be negative
            if (calcSA < 0) {
                return false
            }

            self.surfaceArea = calcSA
            self.surfaceAreaStr = String(format: "%7.5f", self.surfaceArea)
            return true
        }

        ///setbbSurfaceArea
        ///  Sets the surface area of the bounding box and in turn updates the bounding box SA string
        ///  - Parameters:
        ///    - calcSA: The calculated surface area of the bounding box
        internal func setbbSurfaceArea(calcbbSA: Double) -> Bool {
            //Surface area cannot be negative
            if (calcbbSA < 0) {
                return false
            }

            self.bbSurfaceArea = calcbbSA
            self.bbSurfaceAreaStr = String(format: "%7.5f", self.bbsurfaceArea)
            return true
        }


    //Calculating Functions
        ///calculateVolume
        ///  Calculates the volume of the bounding box and Ellipsoid
        func calculateVolume() {
            self.calculateSVolume()
            self.calculatebbVolume()
        }

        ///calculateSVolume
        ///  Calculates the volume of the previously set Ellipsoid
        internal func calculateSVolume() {
            //Volume = 4 / 3 * pi * firstAxis * secondAxis * thirdAxis
            self.setSVolume(calcVolume: (4.0 / 3.0) * Double.pi * self.firstAxisLength * self.secondAxisLength * self.thirdAxisLength)
        }

        ///calculatebbVolume
        ///  Calculates the volume of the bounding box of the Ellipsoid
        internal func calculatebbVolume() {
            //Volume = (2 * firstAxis) * (2 * secondAxis) * (2 * thirdAxis)
            self.setbbVolume(calcbbVolume: 8 * self.firstAxisLength * self.secondAxisLength * self.thirdAxisLength)
        }

        ///calculateSurfaceArea
        ///  Calculates the surface area of the bounding box and the ellipsoid
        func calculateSurfaceArea() {
            self.calculateSSurfaceArea()
            self.calculatebbSurfaceArea()
        }

        //TODO: Finish ellipsoid surface area function
        ///calculateSSurfaceArea
        ///  Calculates the surface area of the ellipsoid
        func calculateSSurfaceArea() {

        }

        ///calculatebbSurfaceArea
        ///  Calculates the surface area of the bounding box
        func calculatebbSurfaceArea() {
            //SurfaceArea = 2 * (firstAxis * secondAxis) + 2 * (firstAxis * thirdAxis) + 2 * (secondAxis * thirdAxis)
            self.setbbSurfaceArea(calcbbSA: 2 * (self.firstAxisLength * self.secondAxisLength + self.firstAxisLength * self.thirdAxisLength + self.secondAxisLength * self.thirdAxisLength))
        }
}