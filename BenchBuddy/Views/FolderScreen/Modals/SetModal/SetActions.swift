//
//  SetActions.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import SwiftUI

struct SetActions: View {
    @ObservedObject var setViewModel: SetViewModel
    
    var isComplete: Bool {
        guard let set = setViewModel.set else { return false }
        return set.completed
    }
    
    var buttonTitle: String {
        return isComplete ? "Reset" : "Complete"
    }
    
    var body: some View {
        VStack {
            Button(action: {
                setViewModel.completeSet()
                setViewModel.selectedSet = nil
            }) {
                AngularButton(title: buttonTitle)
                    .frame(maxWidth: 200)
            }
            .padding(.top)
            
            Button(action: {
                setViewModel.selectedSet = nil
            }) {
                Text("Cancel")
                    .foregroundColor(.accentColor)
            }
            .padding(.top)
        }
    }
}

struct SetActions_Previews: PreviewProvider {
    static var previews: some View {
        SetActions(setViewModel: SetViewModel(forSetWithId: FolderNode.completeWeightSetId))
    }
}
