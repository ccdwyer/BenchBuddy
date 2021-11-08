//
//  FixedModalContentView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import SwiftUI

struct FixedModalContentView: View {
    let weight: Double
    let repetitions: Int
    
    @ObservedObject var setViewModel: SetViewModel
    
    var body: some View {
        VStack {
            Text("\(String(format: "%g", weight)) \(Store.global.state.settings.unit.rawValue)")
                .font(.largeTitle)
            Text("\(repetitions) reps")
                .font(.largeTitle)
            
            SetActions(setViewModel: setViewModel)
        }
    }
}

struct FixedModalContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FixedModalContentView(weight: 250.0, repetitions: 5, setViewModel: SetViewModel(forSetWithId: FolderNode.incompleteFixedWeightSetId))
        }
        .preferredColorScheme(.dark) // Card
        .padding()
        .background(Material.ultraThin)
        .cornerRadius(8.0)
        .shadow(color: Color("Shadow").opacity(0.5), radius: 8.0, x: 0, y: 0)
    }
}
