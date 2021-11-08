//
//  AddSetNodeView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import SwiftUI

struct AddSetNodeView: View {
    @ObservedObject var addNodeModalViewModel: AddNodeModalViewModel
    @State var duration = Store.global.state.settings.timeIncrement
    
    var valueDescription: String {
        return addNodeModalViewModel.setType == .percentageOfMaximum ? "\(String(format:"%g", addNodeModalViewModel.value))%" : "\(String(format:"%g", addNodeModalViewModel.value)) \(Store.global.state.settings.unit.rawValue)"
    }
    
    var valueMaximum: Double {
        return addNodeModalViewModel.setType == .percentageOfMaximum ? 120 : 999
    }
    
    var valueIncrement: Double {
        return addNodeModalViewModel.setType == .percentageOfMaximum ? 1.0 : Store.global.state.settings.weightIncrement
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if addNodeModalViewModel.exercises.count > 0 {
                Text("For The exercise...")
                    .font(.title2)
                    .padding(.top)
                Picker("Select a node type to add", selection: $addNodeModalViewModel.exercise) {
                    ForEach(addNodeModalViewModel.exercises) { exercise in
                        Text(exercise.name)
                            .font(.title2)
                            .foregroundColor(.primary)
                            .tag(exercise as Exercise?)
                    }
                } // Picker
                
                if addNodeModalViewModel.exercise != nil {
                    switch addNodeModalViewModel.exercise!.type {
                    case .cardio:
                        Text("Duration (minutes)")
                        Stepper("\(duration) minutes", value: $duration, in: Store.global.state.settings.timeIncrement...120, step: Store.global.state.settings.timeIncrement)
                            .onChange(of: duration, perform: {
                                duration in
                                addNodeModalViewModel.value = Double(duration * 60)
                            })
                    case .repetition:
                        Picker("Select a set type", selection: $addNodeModalViewModel.setType) {
                            ForEach(AddNodeModalViewModel.SetType.allCases, id: \.self) { setType in
                                Text(setType.rawValue)
                            }
                        } // Picker
                            .pickerStyle(.segmented)
                        
                        Stepper(valueDescription, value: $addNodeModalViewModel.value, in: valueIncrement...valueMaximum, step: valueIncrement)
                        Stepper("\(addNodeModalViewModel.repetitions) reps", value: $addNodeModalViewModel.repetitions, in: 1...250)
                    case .calisthenic:
                        Stepper("\(addNodeModalViewModel.repetitions) reps", value: $addNodeModalViewModel.repetitions, in: 1...250)
                    } // Switch
                } // if exercise isn't null
            } else {
                Text("Please add an exercise")
                    .font(.title2)
                    .padding(.top)
            }
        } // VStack
        .onChange(of: addNodeModalViewModel.exercise, perform: {
            _ in
            addNodeModalViewModel.value = 100.0
            addNodeModalViewModel.repetitions = 5
        })
        .onChange(of: addNodeModalViewModel.setType, perform: {
            _ in
            addNodeModalViewModel.value = 100.0
            addNodeModalViewModel.repetitions = 5
        })
    }
}

struct AddSetNodeView_Previews: PreviewProvider {
    static var previews: some View {
        AddSetNodeView(addNodeModalViewModel: AddNodeModalViewModel(folderNodeId: Store.RootNodeUUID))
    }
}
