//
//  FolderListItemView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/23/21.
//

import SwiftUI

struct FolderListItemView: View {
    let nodeId: UUID
    let folder: Folder
    
    var body: some View {
        HStack {
            Text(folder.title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct FolderListItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FolderListItemView(nodeId: UUID(), folder: Folder(title: "Arm Day", children: []))
            FolderListItemView(nodeId: UUID(), folder: Folder(title: "Leg Day", children: []))
        }
        .padding()
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
