//
//  FolderView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/23/21.
//

import SwiftUI
import Combine

struct FolderView: View {
    @StateObject var viewModel: FolderViewModel
    @State var showAlert = false
    @StateObject var addNodeModalViewModel: AddNodeModalViewModel
    @EnvironmentObject var setModalViewModel: SetViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                FolderListContentView(viewModel: viewModel)
                ResetProgramButton
            }// VStack
            .safeAreaInset(edge: .bottom) {
                VStack {}.frame(height: 44)
            }
        } // ZStack
        .background(
            Image("Blob")
                .opacity(0.5)
                .offset(x: 250, y: -100)
                .accessibility(hidden: true)
        )
        .background(Color("Background"))
        .navigationTitle(Text(viewModel.folder?.title ?? "Folder"))
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            HStack {
                Button(action: {
                    addNodeModalViewModel.displayed = true
                }) {
                    Image(systemName: "plus")
                }
                
                EditButton()
            }
        }
        .sheet(isPresented: $addNodeModalViewModel.displayed, onDismiss: didDismiss) {
            AddNodeModalView(addNodeModalViewModel: addNodeModalViewModel)
        }
    }
    
    func didDismiss() {
        addNodeModalViewModel.displayed = false
    }
}

extension FolderView {
    @ViewBuilder
    var ResetProgramButton: some View {
        if viewModel.folderId == Store.RootNodeUUID {
            Button(action: {
                withAnimation {
                    showAlert = true
                }
            }) {
                AngularButton(title: "Reset Program")
                    .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Resetting Program"),
                    message: Text("This can not be reversed, this will mark all sets as incomplete."),
                    primaryButton: .cancel(
                        Text("Cancel"),
                        action: {
                            showAlert = false
                        }
                    ),
                    secondaryButton: .destructive(
                        Text("Reset"),
                        action: {
                            Store.global.reset()
                        }
                    )
                )
            }
        } else {
            EmptyView()
        }
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView(viewModel: FolderViewModel(folderId: Store.RootNodeUUID), addNodeModalViewModel: AddNodeModalViewModel(folderNodeId: Store.RootNodeUUID))
    }
}
