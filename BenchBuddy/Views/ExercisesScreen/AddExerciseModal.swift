//
//  AddExerciseModal.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 11/1/21.
//

import SwiftUI

struct AddExerciseModal: View {
    @ObservedObject var viewModel: ExercisesViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Text("New Exercise")
                    .font(.headline)
                
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.exitAddModal()
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
                    Group {
                        Text("Name")
                        TextField("Please enter a name...", text: $viewModel.addModalName)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    Picker("Exercise Type", selection: $viewModel.addModalExerciseType) {
                        ForEach(ExercisesViewModel.ExerciseType.allCases, id: \.rawValue) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical)
                    
                    if viewModel.addModalExerciseType == .weightBased {
                        Group {
                            Text("One Repetition Maximum")
                            Stepper("\(String(format:"%g", viewModel.updateModalOneRepMaximum)) \(Store.global.state.settings.unit.rawValue)", value: $viewModel.updateModalOneRepMaximum, in: Store.global.state.settings.weightIncrement...999, step: Store.global.state.settings.weightIncrement)
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16.0)
                
                Group {
                    Spacer()
                    if viewModel.addModalName.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                        Button(action: {
                            viewModel.addExercise()
                        }) {
                            AngularButton(title: "Add Exercise")
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
    }
}

struct AddExerciseModal_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseModal(viewModel: ExercisesViewModel())
    }
}
