//  Defines the ErrorAssessor class which compares two numerical methods of doing something
//
//  ErrorAssessor.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/5/21.
//

import Foundation
import SwiftUI
import CorePlot

class ErrorAssessor: NSObject, ObservableObject {
    @Published var plotData = [plotDataType]()
    @Published var plotParameters: ChangingPlotParameters = ChangingPlotParameters()
    @Published var calculatedText = ""

    @Published var pointNumber = 0.0

    
}