//
//  FolderNode.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/20/21.
//

import Foundation

struct FolderNode: Codable, Identifiable {
    var id = UUID()
    var node: NodeType
    enum NodeType: Codable {
        case folder(data: Folder)
        case set(data: ExerciseSet)
    }
}

extension FolderNode {
    static var sampleFolder1Id = UUID(uuidString: "F260EBAC-7DFD-4445-A996-684CCC12D167")!
    static var sampleFolder2Id = UUID(uuidString: "701E7D2B-8F2A-4C49-984E-67874F0D955A")!
    static var sampleFolder3Id = UUID(uuidString: "DEF1780F-7E2D-4046-9636-0A57ACE1F89E")!
    static var sampleFolderCompleteId = UUID(uuidString: "524C55D9-70BE-4662-98E8-34DF76C912BE")!
    static var sampleFolderIncompleteId = UUID(uuidString: "E94AB9DE-826D-416B-A4D1-915BA8C476E8")!
    static var completeWeightSetId = UUID(uuidString: "9797C64E-2181-4EB2-907F-C703783C1097")!
    static var incompleteFixedWeightSetId = UUID(uuidString: "543A2C5A-1AF9-4B63-97DB-1AB131FE3CA0")!
    static var incompleteCardioSetId = UUID(uuidString: "AC3F3B77-EFD0-4402-850E-8053434F0F73")!
    static var completeCalisthenicSetId = UUID(uuidString: "D69E0017-96BF-468F-BC74-E888A3A94A46")!
    static var data = [
        FolderNode(id: incompleteFixedWeightSetId, node: .set(data: ExerciseSet(completed: true, exerciseId: Exercise.benchUUID, type: .fixedWeight(weight: 250.0, repetitions: 5)))),
        FolderNode(id: completeWeightSetId, node: .set(data: ExerciseSet(completed: true, exerciseId: Exercise.ohpUUID, type: .percentageMax(percentage: 80.0, repetitions: 4)))),
        FolderNode(id: incompleteCardioSetId, node: .set(data: ExerciseSet(completed: false, exerciseId: Exercise.runningUUID, type: .cardio(durationInSeconds: 360)))),
        FolderNode(id: completeCalisthenicSetId, node: .set(data: ExerciseSet(completed: true, exerciseId: Exercise.pushUpUUID, type: .calisthenic(repetitions: 5)))),
        FolderNode(id: sampleFolderCompleteId, node: .folder(data: Folder(title: "Bench Press Day", children: [
            completeWeightSetId,
            completeCalisthenicSetId
        ]))),
        FolderNode(id: sampleFolderIncompleteId, node: .folder(data: Folder(title: "Overhead Press Day", children: [
            completeWeightSetId,
            completeCalisthenicSetId
        ]))),
        FolderNode(id: sampleFolder1Id, node: .folder(data: Folder(title: "Deadlift Day", children: [
            completeWeightSetId,
            completeCalisthenicSetId
        ]))),
        FolderNode(id: Store.RootNodeUUID, node: .folder(data: Folder(title: "My Program", children: [
            sampleFolderCompleteId,
            sampleFolderIncompleteId,
            sampleFolder1Id,
            completeWeightSetId,
            incompleteCardioSetId,
            completeCalisthenicSetId,
            incompleteFixedWeightSetId
        ])))
    ]
}
