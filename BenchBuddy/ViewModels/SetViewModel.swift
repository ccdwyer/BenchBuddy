//
//  SetModalViewModel.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import Foundation
import Combine

class SetViewModel: ObservableObject {
    @Published var set: ExerciseSet?
    @Published var exercise: Exercise?
    @Published var unit: WeightUnit?
    @Published var selectedSet: UUID? {
        didSet {
            self.update()
        }
    }
    var stateSubscription: AnyCancellable?
    
    init(forSetWithId setId: UUID?) {
        self.selectedSet = setId
        
        stateSubscription = Store.global.$state.sink(receiveValue: {
            [weak self] state in
            self?.update(withState: state)
        })
    }
    
    func update(withState state: Store.State = Store.global.state) {
        guard let setId = selectedSet else { return }
        guard let set = Store.getSet(withId: setId, fromState: state) else { return }
        guard let exercise = Store.getExercise(withId: set.exerciseId, fromState: state) else { return }
        self.set = set
        self.exercise = exercise
    }
    
    func completeSet() {
        guard let setId = selectedSet else { return }
        Store.global.completeSet(withId: setId)
    }
}
