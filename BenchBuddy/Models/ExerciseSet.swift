//
//  Set.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/4/21.
//

import Foundation

struct ExerciseSet: Codable {
    var completed: Bool
    var exerciseId: UUID
    var type: SetType
}

extension ExerciseSet {
    enum SetType: Codable {
        case fixedWeight(weight: Double, repetitions: Int)
        case percentageMax(percentage: Double, repetitions: Int)
        case cardio(durationInSeconds: Int)
        case calisthenic(repetitions: Int)
    }
}

extension ExerciseSet {
    enum SetDetails: Codable {
        case cardio(exerciseName: String, durationInSeconds: Double)
        case weightReps(exerciseName: String, repetitions: Int, weight: Double)
        case calisthenic(exerciseName: String, repetitions: Int)
        case unknown
    }
    
//    var setDetails: SetDetails {
//        switch exercise.type {
//        case .repetition(max: let max):
//            return buildRepetitionSetDetails(withMax: max)
//        case .cardio:
//            return buildCardioSetDetails()
//        case .calisthenic:
//            return buildCalisthenicSetDetails()
//        }
//    }
//
//    private func buildRepetitionSetDetails(withMax max: Double) -> SetDetails {
//        switch type {
//        case .fixedWeight(weight: let weight, repetitions: let repetitions):
//            return .weightReps(exerciseName: exercise.name, repetitions: repetitions, weight: weight)
//        case .percentageMax(percentage: let percentage, repetitions: let repetitions):
//            return .weightReps(exerciseName: exercise.name, repetitions: repetitions, weight: percentage / 100 * max)
//        case .cardio(durationInSeconds: _):
//            return .unknown
//        case .calisthenic(repetitions: _):
//            return .unknown
//        }
//    }
//
//    private func buildCardioSetDetails() -> SetDetails {
//        switch type {
//        case .fixedWeight(weight: _, repetitions: _):
//            return .unknown
//        case .percentageMax(percentage: _, repetitions: _):
//            return .unknown
//        case .cardio(durationInSeconds: let durationInSeconds):
//            return .cardio(exerciseName: exercise.name, durationInSeconds: durationInSeconds)
//        case .calisthenic(repetitions: _):
//            return .unknown
//        }
//    }
//
//    private func buildCalisthenicSetDetails() -> SetDetails {
//        switch type {
//        case .fixedWeight(weight: _, repetitions: _):
//            return .unknown
//        case .percentageMax(percentage: _, repetitions: _):
//            return .unknown
//        case .cardio(durationInSeconds: _):
//            return .unknown
//        case .calisthenic(repetitions: let repetitions):
//            return .calisthenic(exerciseName: exercise.name, repetitions: repetitions)
//        }
//    }
}
