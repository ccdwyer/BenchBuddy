//
//  ExercisesViewModel.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/31/21.
//

import Foundation
import Combine

class ExercisesViewModel: ObservableObject {
    enum ExerciseType: String, Equatable, CaseIterable {
        case weightBased = "Weight Based"
        case cardio = "Cardio"
        case calisthenic = "Calisthenic"
    }
    
    @Published var exercises: [Exercise] = []
    @Published var settings: Settings = Settings(unit: .pounds)
    
    // Add modal
    @Published var displayAddModal = false
    @Published var addModalName = ""
    @Published var addModalExerciseType: ExercisesViewModel.ExerciseType = .calisthenic
    @Published var addModalOneRepMaximum = (100.0 / Store.global.state.settings.weightIncrement).rounded(.down) * Store.global.state.settings.weightIncrement
    
    // Update modal
    @Published var selectedExercise: Exercise? {
        didSet {
            guard let exercise = self.selectedExercise else { return }
            
            self.updateModalName = exercise.name
            
            switch exercise.type {
            case .repetition(max: let max):
                self.updateModalOneRepMaximum = max
                self.updateModalExerciseType = .weightBased
            case .cardio:
                self.updateModalExerciseType = .cardio
            case .calisthenic:
                self.updateModalExerciseType = .calisthenic
            }
        }
    }
    @Published var updateModalName = ""
    @Published var updateModalExerciseType: ExercisesViewModel.ExerciseType = .calisthenic
    @Published var updateModalOneRepMaximum = (100.0 / Store.global.state.settings.weightIncrement).rounded(.down) * Store.global.state.settings.weightIncrement

    var subscription: AnyCancellable?
    
    init() {
        self.subscription = Store.global.$state.sink(receiveValue: { [weak self] state in
            self?.update(withState: state)
        })
    }
    
    func update(withState state: Store.State = Store.global.state) {
        self.exercises = state.exercises
        self.settings = state.settings
    }
    
    func exitAddModal() {
        self.displayAddModal = false
        self.addModalName = ""
        self.addModalExerciseType = .calisthenic
        self.addModalOneRepMaximum = (100.0 / Store.global.state.settings.weightIncrement).rounded(.down) * Store.global.state.settings.weightIncrement
    }
    
    func exitUpdateModal() {
        self.selectedExercise = nil
    }
    
    func addExercise() {
        var type: Exercise.ExerciseType
        
        switch addModalExerciseType {
        case .weightBased:
            type = .repetition(max: self.addModalOneRepMaximum)
        case .cardio:
            type = .cardio
        case .calisthenic:
            type = .calisthenic
        }
        
        Store.global.add(Exercise(name: self.addModalName, tags: [], type: type))
        exitAddModal()
    }
    
    func updateExercise() {
        guard let exercise = selectedExercise else { return }
        switch exercise.type {
        case .repetition:
            Store.global.update(Exercise(id: exercise.id, name: self.updateModalName, tags: exercise.tags, type: .repetition(max: updateModalOneRepMaximum)))
        case .cardio:
            Store.global.update(Exercise(id: exercise.id, name: self.updateModalName, tags: exercise.tags, type: .cardio))
        case .calisthenic:
            Store.global.update(Exercise(id: exercise.id, name: self.updateModalName, tags: exercise.tags, type: .calisthenic))
        }
        exitUpdateModal()
    }
    
    func select(_ exercise: Exercise) {
        self.selectedExercise = exercise
    }
}
