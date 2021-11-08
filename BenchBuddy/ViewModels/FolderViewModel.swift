//
//  FolderViewModel.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/23/21.
//

import Foundation
import Combine

class FolderViewModel: ObservableObject {
    let folderId: UUID
    @Published var children: [FolderNode] = []
    @Published var folder: Folder?
    @Published var selectedSet: UUID?
    var stateSubscription: AnyCancellable?
    
    init(folderId: UUID) {
        self.folderId = folderId
        stateSubscription = Store.global.$state.sink(receiveValue: {
            [weak self] state in
            self?.update(withState: state)
        })
    }
    
    func update(withState state: Store.State = Store.global.state) {
        let children = Store.getChildren(for: folderId, withState: state)
        guard let folder = Store.getFolder(withId: folderId, fromState: state) else { return }
        self.folder = folder
        self.children = children
    }
    
    func deleteNodes(withIndexes indexes: IndexSet) {
        indexes.forEach { Store.global.deleteNode(withId: children[$0].id) }
    }
    
    func moveNodes(withIndexes indexes: IndexSet, to destination: Int) {
        Store.global.moveNodes(under: folderId, from: indexes, to: destination)
    }
}
