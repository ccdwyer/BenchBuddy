//
//  Exercise.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/20/21.
//

import Foundation

struct Exercise: Identifiable, Codable, Equatable, Hashable {
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var name: String
    var tags: [Tags]
    var type: Exercise.ExerciseType
    
    enum ExerciseType: Codable, Hashable {
        case repetition(max: Double)
        case cardio
        case calisthenic
    }
    
    enum Tags: Codable {
        case push, pull, cardio, legs, fivebyfive, compound
    }
}

extension Exercise {
    static var benchUUID = UUID(uuidString: "E40F20AF-2115-4CBF-BE01-9B63A39BC5B5")!
    static var runningUUID = UUID(uuidString: "AB846D54-1D49-4144-8B27-5F7DE3C2C0D5")!
    static var pushUpUUID = UUID(uuidString: "AA1BEA7F-7BA4-4078-B2C2-E9EE2D8BC0C6")!
    static var ohpUUID = UUID(uuidString: "27710288-8D87-45AE-9927-942CF30D1598")!
    
    static var data = [
        Exercise(id: benchUUID, name: "Bench Press", tags: [.push], type: .repetition(max: 200)),
        Exercise(id: ohpUUID, name: "Overhead Press", tags: [.push], type: .repetition(max: 200)),
        Exercise(id: runningUUID, name: "Running", tags: [.legs], type: .cardio),
        Exercise(id: pushUpUUID, name: "Push Ups", tags: [.push], type: .calisthenic)
    ]
}
