//
//  Settings.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/5/21.
//

import Foundation

struct Settings: Codable, Equatable {
    var unit: WeightUnit
    var weightIncrement: Double = 5.0
    var timeIncrement: Int = 5
}
