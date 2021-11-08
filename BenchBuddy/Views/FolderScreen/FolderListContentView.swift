//
//  FolderListContentView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import SwiftUI

struct FolderListContentView: View {
    @ObservedObject var viewModel: FolderViewModel
    @EnvironmentObject var setModalViewModel: SetViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.children) { child in
                switch child.node {
                case .folder(data: let folder):
                    NavigationLink(destination: FolderView(viewModel: FolderViewModel(folderId: child.id), addNodeModalViewModel: AddNodeModalViewModel(folderNodeId: child.id))) {
                        FolderListItemView(nodeId: child.id, folder: folder)
                    }
                case .set:
                    Button(action: {
                        withAnimation {
                            setModalViewModel.selectedSet = child.id
                        }
                    }) {
                        SetListItemView(viewModel: SetViewModel(forSetWithId: child.id))
                    }
                }
            } // ForEach viewModel.children
            .onDelete { viewModel.deleteNodes(withIndexes: $0) }
            .onMove {
                indexes, destination in
                viewModel.moveNodes(withIndexes: indexes, to: destination)
            }
            .listRowBackground(
                HStack{}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ultraThinMaterial)
            )
            .foregroundColor(.primary)
        } // List
        .onAppear {
            viewModel.update()
        }
    }
}

struct FolderListContentView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListContentView(viewModel: FolderViewModel(folderId: Store.RootNodeUUID))
    }
}
