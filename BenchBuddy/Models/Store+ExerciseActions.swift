//
//  Store+ExerciseActions.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 11/1/21.
//

import Foundation

extension Store {
    func add(_ exercise: Exercise) {
        self.state.exercises.append(exercise)
    }
    
    func update(_ updatedExercise: Exercise) {
        self.state.exercises = self.state.exercises.map { exercise in
            guard exercise.id == updatedExercise.id else { return exercise }
            return updatedExercise
        }
    }
    
    func deleteExercises(atOffsets offsets: IndexSet) {
        self.state.exercises.remove(atOffsets: offsets)
        self.state.nodes = self.state.nodes.filter { node in
            switch node.node {
            case .folder:
                return true
            case .set(data: let set):
                if self.state.exercises.first(where: { $0.id == set.exerciseId }) != nil {
                    return true
                }
                return false
            }
        }
    }
    
    func moveExercises(fromOffsets offsets: IndexSet, toOffset destination: Int) {
        self.state.exercises.move(fromOffsets: offsets, toOffset: destination)
    }
}
