//
//  Record.swift
//  VisionExample
//
//  Created by Scarlet on 31/7/2022.
//  Copyright © 2022 Google Inc. All rights reserved.
//

import UIKit

struct Record {
    var timestamp: Date
    var mealType: String
    var foodType: String
    var mouthDistance: Double
    var mouthMovement: Bool
    var leftShoulderCoordinate: CGPoint
    var leftWristCoordinate: CGPoint
    var leftElbowCoordinate: CGPoint
    var leftHandMovement: Bool
    var rightShoulderCoordinate: CGPoint
    var rightWristCoordinate: CGPoint
    var rightElbowCoordinate: CGPoint
    var rightHandMovement: Bool
}

extension TimeInterval {
    func asMinutes() -> Double { return self / (60.0) }
    func asHours()   -> Double { return self / (60.0 * 60.0) }
    func asDays()    -> Double { return self / (60.0 * 60.0 * 24.0) }
    func asWeeks()   -> Double { return self / (60.0 * 60.0 * 24.0 * 7.0) }
    func asMonths()  -> Double { return self / (60.0 * 60.0 * 24.0 * 30.4369) }
    func asYears()   -> Double { return self / (60.0 * 60.0 * 24.0 * 365.2422) }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
