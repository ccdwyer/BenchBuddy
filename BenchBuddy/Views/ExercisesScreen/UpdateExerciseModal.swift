//
//  UpdateExerciseModal.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 11/1/21.
//

import SwiftUI

struct UpdateExerciseModal: View {
    @ObservedObject var viewModel: ExercisesViewModel
    var body: some View {
        VStack {
            ZStack {
                Text("Update Exercise")
                    .font(.headline)
                
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.exitUpdateModal()
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
                        TextField("Please enter a name...", text: $viewModel.updateModalName)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    if viewModel.updateModalExerciseType == .weightBased {
                        Group {
                            Text("One Repetition Maximum")
                                .padding(.top)
                            Stepper("\(String(format:"%g", viewModel.updateModalOneRepMaximum)) \(Store.global.state.settings.unit.rawValue)", value: $viewModel.updateModalOneRepMaximum, in: Store.global.state.settings.weightIncrement...999, step: Store.global.state.settings.weightIncrement)
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16.0)
                
                Group {
                    Spacer()
                    if viewModel.updateModalName.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                        Button(action: {
                            viewModel.updateExercise()
                        }) {
                            AngularButton(title: "Update Exercise")
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

struct UpdateExerciseModal_Previews: PreviewProvider {
    static var previews: some View {
        UpdateExerciseModal(viewModel: ExercisesViewModel())
    }
}
