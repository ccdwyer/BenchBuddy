//
//  CalisthenicModalContentView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import SwiftUI

struct CalisthenicModalContentView: View {
    let repetitions: Int
    @ObservedObject var setViewModel: SetViewModel
    
    var body: some View {
        VStack {
            Text("\(repetitions) reps")
                .font(.largeTitle)
            
            SetActions(setViewModel: setViewModel)
        }
    }
}

struct CalisthenicModalContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalisthenicModalContentView(repetitions: 5, setViewModel: SetViewModel(forSetWithId: FolderNode.completeCalisthenicSetId))
    }
}
