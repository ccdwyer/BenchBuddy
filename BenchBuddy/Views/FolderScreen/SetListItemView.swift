//
//  SetListItemView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/23/21.
//

import SwiftUI

struct SetListItemView: View {
    @StateObject var viewModel: SetViewModel
    
    var description: String {
        guard let set = viewModel.set else { return "" }
        guard let exercise = viewModel.exercise else { return "" }
        
        switch set.type {
        case .fixedWeight(weight: let weight, repetitions: let repetitions):
            return "\(repetitions)x \(String(format: "%g", weight))\(Store.global.state.settings.unit.rawValue)"
        case .percentageMax(percentage: let percentage, repetitions: let repetitions):
            var weight = ""
            switch exercise.type {
            case .repetition(max: let max):
                weight = "\(String(format: "%g", max * percentage / 100.0))"
            case .cardio: break
            case .calisthenic: break
            }
            return "\(repetitions)x \(weight)\(Store.global.state.settings.unit.rawValue)"
        case .cardio(durationInSeconds: let durationInSeconds):
            return "\(durationInSeconds / 60) minutes"
        case .calisthenic(repetitions: let repetitions):
            return "\(repetitions)x"
        }
    }
    
    var name: String {
        guard let exercise = viewModel.exercise else { return "" }
        return exercise.name
    }
    
    var completed: Bool {
        guard let set = viewModel.set else { return false }
        return set.completed
    }
    
    var body: some View {
        HStack {
            Text("\(viewModel.exercise?.name ?? "")")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            if completed {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
            
            Text("\(description)")
                .padding(.trailing, 8)
        }
        .onAppear {
            viewModel.update()
        }
    }
}

struct SetListItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SetListItemView(viewModel: SetViewModel(forSetWithId: FolderNode.incompleteCardioSetId))
        }
    }
}
