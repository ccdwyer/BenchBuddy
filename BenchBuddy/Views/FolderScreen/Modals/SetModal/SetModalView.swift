//
//  SetModalView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import SwiftUI

struct SetModalView: View {
    @StateObject var viewModel: SetViewModel
    var body: some View {
        VStack {
            VStack {
                if let set = viewModel.set {
                    switch set.type {
                    case .cardio(durationInSeconds: let durationInSeconds):
                        CardioModalContentView(timerViewModel: TimerViewModel(withDurationInSeconds: durationInSeconds), setViewModel: viewModel)
                    case .fixedWeight(weight: let weight, repetitions: let repetitions):
                        FixedModalContentView(weight: weight, repetitions: repetitions, setViewModel: viewModel)
                    case .percentageMax(percentage: let percentage, repetitions: let repetitions):
                        PercentageMaxModalContentView(percentage: percentage, repetitions: repetitions, setViewModel: viewModel)
                    case .calisthenic(repetitions: let repetitions):
                        CalisthenicModalContentView(repetitions: repetitions, setViewModel: viewModel)
                    }
                }
            } // Card
            .padding()
            .background(Material.ultraThin)
            .cornerRadius(8.0)
            .shadow(color: Color("Shadow").opacity(0.5), radius: 8.0, x: 0, y: 0)
        } // container
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color("Background").opacity(0.5))
        .onAppear {
            viewModel.update()
        }
    }
}

struct SetModalView_Previews: PreviewProvider {
    static var previews: some View {
        SetModalView(viewModel: SetViewModel(forSetWithId: FolderNode.incompleteCardioSetId))
    }
}
