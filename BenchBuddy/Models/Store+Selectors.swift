//
//  Store+Selectors.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/23/21.
//

import Foundation

extension Store {
    static func getFolder(withId id: UUID, fromState state: Store.State) -> Folder? {
        guard let foundNode = state.nodes.first(where: { $0.id == id }) else { return nil }
        switch foundNode.node {
        case .folder(data: let folder):
            return folder
        case .set:
            return nil
        }
    }
    
    static func getChildren(for id: UUID, withState state: Store.State) -> [FolderNode] {
        guard let foundNode = state.nodes.first(where: { $0.id == id }) else { return [] }
        let children = {
            () -> [UUID] in
            switch foundNode.node {
            case .folder(data: let data):
                return data.children
            case .set:
                return []
            }
        }()
        
        let childrenNodes = children.compactMap {
            child in
            return state.nodes.first(where: { $0.id == child})
        }
        
        return childrenNodes
    }
    
    static func getIsComplete(nodeId id: UUID, withState state: Store.State = Store.global.state) -> Bool {
        guard let foundNode = state.nodes.first(where: { $0.id == id }) else { return false }
        
        switch foundNode.node {
        case .folder(data: let folder):
            return folder.children.compactMap {
                child in
                return state.nodes.first(where: { $0.id == child})
            }.reduce(true) {
                acc, child in
                return acc && getIsComplete(nodeId: child.id, withState: state)
            }
        case .set(data: let set):
            return set.completed
        }
    }
    
    static func getSet(withId id: UUID, fromState state: Store.State = Store.global.state) -> ExerciseSet? {
        guard let foundSet = state.nodes.first(where: { $0.id == id }) else { return nil }
        
        switch foundSet.node {
        case .folder:
            return nil
        case .set(data: let set):
            return set
        }
    }
    
    static func getExercise(withId id: UUID, fromState state: Store.State = Store.global.state) -> Exercise? {
        return state.exercises.first(where: { $0.id == id })
    }
    
    static func getSettings(fromState state: Store.State) -> Settings {
        return state.settings
    }
}
