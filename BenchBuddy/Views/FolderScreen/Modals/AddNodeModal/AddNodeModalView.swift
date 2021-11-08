//
//  AddNodeModalView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import SwiftUI

struct AddNodeModalView: View {
    @ObservedObject var addNodeModalViewModel: AddNodeModalViewModel
    
    var formIsComplete: Bool {
        if addNodeModalViewModel.nodeType == .folder {
            guard addNodeModalViewModel.title.trimmingCharacters(in: .whitespacesAndNewlines) != "" else { return false }
            return true
        }
        guard addNodeModalViewModel.exercise != nil else { return false }
        return true
    }
    
    var body: some View {
        VStack {
            ZStack {
                Text("New Node")
                    .font(.headline)
                
                HStack {
                    Spacer()
                    Button(action: {
                        addNodeModalViewModel.displayed = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                    }
                    .padding(.horizontal)
                    
                }
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(Color("DarkBackground"))
            VStack {
                VStack(alignment: .leading) {
                    Text("Add a new...")
                        .font(.title)
                    Picker("Select a node type to add", selection: $addNodeModalViewModel.nodeType) {
                        ForEach(AddNodeModalViewModel.NodeType.allCases, id: \.self) { nodeType in
                            Text(nodeType.rawValue)
                        }
                    } // Picker
                    .pickerStyle(.segmented)
                    
                    if addNodeModalViewModel.nodeType == AddNodeModalViewModel.NodeType.folder {
                        AddFolderNodeView(addNodeModalViewModel: addNodeModalViewModel)
                    }
                    if addNodeModalViewModel.nodeType == AddNodeModalViewModel.NodeType.set {
                        AddSetNodeView(addNodeModalViewModel: addNodeModalViewModel)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16.0)
                
                Group {
                    Spacer()
                    if formIsComplete {
                        Button(action: {
                            addNodeModalViewModel.add()
                        }) {
                            AngularButton(title: "Add")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .padding()
        }
        .background(
            Image("Blob")
                .opacity(0.5)
                .offset(x: 250, y: -100)
                .accessibility(hidden: true)
        )
        .background(Color("Background"))
        .onAppear {
            addNodeModalViewModel.update()
        }
    }
}

struct AddNodeModalView_Previews: PreviewProvider {
    static var previews: some View {
        AddNodeModalView(addNodeModalViewModel: AddNodeModalViewModel(folderNodeId: Store.RootNodeUUID))
    }
}
