//
//  PercentageMaxModalContentView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import SwiftUI

struct PercentageMaxModalContentView: View {
    let percentage: Double
    let repetitions: Int
    @ObservedObject var setViewModel: SetViewModel
    
    var weight: Double {
        guard let exercise = setViewModel.exercise else { return 0 }
        
        switch exercise.type {
        case .repetition(max: let max):
            return max * percentage / 100
        case .cardio:
            return 0
        case .calisthenic:
            return 0
        }
    }
    
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

struct PercentageMaxModalContentView_Previews: PreviewProvider {
    static var previews: some View {
        PercentageMaxModalContentView(percentage: 80.0, repetitions: 6, setViewModel: SetViewModel(forSetWithId: FolderNode.completeWeightSetId))
    }
}
