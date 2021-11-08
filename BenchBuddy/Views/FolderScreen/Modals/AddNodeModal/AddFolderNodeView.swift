//
//  AddFolderNodeView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import SwiftUI

struct AddFolderNodeView: View {
    @ObservedObject var addNodeModalViewModel: AddNodeModalViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Titled:")
            TextField(
                "Title",
                text: $addNodeModalViewModel.title
            )
                .textFieldStyle(.roundedBorder)
        }
        .padding(.top)
    }
}

struct AddFolderNodeView_Previews: PreviewProvider {
    static var previews: some View {
        AddFolderNodeView(addNodeModalViewModel: AddNodeModalViewModel(folderNodeId: Store.RootNodeUUID))
    }
}
