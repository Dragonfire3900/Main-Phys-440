//
//  Schroe.swift
//  Main Phys 440
//
//  Created by Joel Kelsey on 2/25/22.
//

import Foundation

//General strategy for this problem
// 1) Start out with the initial points
//   a) Be given a potential function (interpolate or strict eval)
//   b) Be given an interval to evaluate on
//   c) Be given the initial value at one of the boundaries
//   d) Be given the initial energy of the wave function
// 2) Evaluate the derivative over that defined interval
//   a) Use the Shroedinger eq to evaluate the second derivative to approximate the first
//   b) Use the same potential function and energy to evaluate over the interval starting at the initial point
//   c) Interpolate between the points using a preset method
// 3) Evaluate the actual function over that defined interval
//   a) Interpolate between the points if needed

