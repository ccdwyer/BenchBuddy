//
//  Store+Actions.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/23/21.
//

import Foundation

extension Store {
    func deleteNode(withId id: UUID) {
        guard let foundNode = self.state.nodes.first(where: { $0.id == id }) else { return }
        
        switch foundNode.node {
        case .folder(data: let data):
            data.children.forEach {
                deleteNode(withId: $0)
            }
        case .set:
            break
        }
        
        self.state.nodes = self.state.nodes.filter {
            $0.id != id
        }
    }
    
    func add(_ folder: Folder, to destinationNodeId: UUID) {
        let uuid = UUID()
        var nodes = state.nodes
        nodes.append(FolderNode(id: uuid, node: .folder(data: folder)))
        nodes = nodes.map {
            node in
            guard node.id == destinationNodeId else { return node }
            switch node.node {
            case .folder(data: let data):
                var newFolder = data
                newFolder.children.append(uuid)
                return FolderNode(id: node.id, node: .folder(data: newFolder))
            case .set:
                return node
            }
        }
        
        state.nodes = nodes
    }
    
    func add(_ set: ExerciseSet, to destinationNodeId: UUID) {
        let uuid = UUID()
        var nodes = state.nodes
        nodes.append(FolderNode(id: uuid, node: .set(data: set)))
        nodes = nodes.map {
            node in
            guard destinationNodeId == node.id else { return node }
            switch node.node {
            case .folder(data: let data):
                var newFolder = data
                newFolder.children.append(uuid)
                return FolderNode(id: node.id, node: .folder(data: newFolder))
            case .set:
                return node
            }
        }
        
        state.nodes = nodes
    }
    
    func reset() {
        state.nodes = state.nodes.map {
            node in
            switch node.node {
            case .folder:
                return node
            case .set(data: let data):
                var set = data
                set.completed = false
                return FolderNode(id: node.id, node: .set(data: set))
            }
        }
    }
    
    func toggleSet(withId id: UUID) {
        state.nodes = state.nodes.map {
            node in
            if node.id != id {
                return node
            }
            
            switch node.node {
            case .folder:
                return node
            case .set(data: let data):
                var set = data
                set.completed.toggle()
                return FolderNode(id: node.id, node: .set(data: set))
            }
        }
    }
    
    func updateTitle(to newName: String, forId id: UUID) {
        state.nodes = state.nodes.map {
            node in
            switch node.node {
            case .folder(data: let data):
                var folder = data
                folder.title = newName
                return FolderNode(id: node.id, node: .folder(data: folder))
            case .set:
                return node
            }
        }
    }
    
    func moveNodes(under parentNode: UUID, from indexes: IndexSet, to destination: Int) {
        state.nodes = state.nodes.map { node in
            guard node.id == parentNode else { return node }
            switch node.node {
            case .folder(data: var folder):
                folder.children.move(fromOffsets: indexes, toOffset: destination)
                return FolderNode(id: node.id, node: .folder(data: folder))
            case .set:
                return node
            }
        }
    }
    
    func completeSet(withId id: UUID) {
        state.nodes = state.nodes.map { node in
            guard node.id == id else { return node }
            
            switch node.node {
            case .folder:
                return node
            case .set(data: var set):
                set.completed.toggle()
                return FolderNode(id: node.id, node: .set(data: set))
            }
        }
    }
}
