//
//  FolderClass.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/22/21.
//

import Foundation

class Store: ObservableObject {
    struct State: Codable {
        var nodes: [FolderNode]
        var exercises: [Exercise]
        var settings: Settings
    }
    static var global = Store()
    static var RootNodeUUID = UUID(uuidString: "F5D34A5D-17D9-4C28-8533-589C832C94B8")!
    
    @Published var state = Store.State(
        nodes: [
            FolderNode(
                id: RootNodeUUID,
                node: .folder(
                    data: Folder(
                        title: "My Program",
                        children: []
                    )
                )
            )
        ],
        exercises: [
            Exercise(name: "Bench Press", tags: [], type: .repetition(max: 100)),
            Exercise(name: "Overhead Press", tags: [], type: .repetition(max: 100)),
            Exercise(name: "Squat", tags: [], type: .repetition(max: 100)),
            Exercise(name: "Deadlift", tags: [], type: .repetition(max: 100)),
            Exercise(name: "Running", tags: [], type: .cardio),
            Exercise(name: "Push Ups", tags: [], type: .calisthenic),
        ],
        settings: Settings(unit: .pounds, weightIncrement: 5.0, timeIncrement: 15)
    ) {
        didSet {
            print(self.state)
        }
    }
}
