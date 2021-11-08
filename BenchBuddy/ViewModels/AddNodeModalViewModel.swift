//
//  AddNodeModalViewModel.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import Foundation
import Combine
import SwiftUI

class AddNodeModalViewModel: ObservableObject {
    enum NodeType: String, Equatable, CaseIterable {
        case folder = "Folder"
        case set = "Set"
    }
    
    enum SetType: String, Equatable, CaseIterable {
        case fixed = "Fixed"
        case percentageOfMaximum = "% of Maximum"
    }
    
    let folderNodeId: UUID
    let nodeTypeOptions = [
        NodeType.folder,
        NodeType.set
    ]
    let setTypeOptions = [
        SetType.fixed,
        SetType.percentageOfMaximum
    ]
    @Published var displayed = false
    @Published var nodeType: AddNodeModalViewModel.NodeType = .folder
    @Published var exercises: [Exercise] = []
    @Published var exercise: Exercise? = Store.global.state.exercises.first
    @Published var setType: AddNodeModalViewModel.SetType = .fixed
    @Published var repetitions = 1
    @Published var value = (100.0 / Store.global.state.settings.weightIncrement).rounded(.down) * Store.global.state.settings.weightIncrement
    @Published var title = ""
    
    var subscription: AnyCancellable?
    
    init(folderNodeId: UUID) {
        self.folderNodeId = folderNodeId
        self.subscription = Store.global.$state.sink(receiveValue: {
            [weak self] state in
            self?.update(withState: state)
        })
    }
    
    func update(withState state: Store.State = Store.global.state) {
        self.exercises = state.exercises
        self.exercise = state.exercises.first
    }
    
    func reset() {
        self.displayed = false
        self.nodeType = .folder
        self.exercises = []
        self.exercise = Store.global.state.exercises.first
        self.setType = .percentageOfMaximum
        self.repetitions = 1
        self.value = (100.0 / Store.global.state.settings.weightIncrement).rounded(.down) * Store.global.state.settings.weightIncrement
        self.title = ""
    }
    
    func add() {
        if nodeType.rawValue == NodeType.folder.rawValue {
            addFolder()
            return
        }
        addSet()
        reset()
        self.displayed = false
    }
    
    private func addFolder() {
        guard title.trimmingCharacters(in: .whitespacesAndNewlines) != "" else { return }
        Store.global.add(Folder(title: title, children: []), to: folderNodeId)
    }
    
    private func addSet() {
        guard let exercise = self.exercise else { return }
        
        switch exercise.type {
        case .repetition:
            Store.global.add(
                ExerciseSet(
                    completed: false,
                    exerciseId: exercise.id,
                    type: (self.setType == .percentageOfMaximum) ? .percentageMax(percentage: self.value, repetitions: self.repetitions) : .fixedWeight(weight: self.value, repetitions: self.repetitions)
                ),
                to: self.folderNodeId
            )
        case .cardio:
            Store.global.add(
                ExerciseSet(
                    completed: false,
                    exerciseId: exercise.id,
                    type: .cardio(durationInSeconds: Int(self.value))
                ),
                to: self.folderNodeId
            )
        case .calisthenic:
            Store.global.add(
                ExerciseSet(
                    completed: false,
                    exerciseId: exercise.id,
                    type: .calisthenic(repetitions: self.repetitions)
                ),
                to: self.folderNodeId
            )
        }
    }
}
