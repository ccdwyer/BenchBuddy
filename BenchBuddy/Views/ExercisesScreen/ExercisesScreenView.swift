//
//  ExercisesScreenView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/31/21.
//

import SwiftUI
import BottomSheet
import DynamicColor

struct ExercisesScreenView: View {
    @StateObject var viewModel = ExercisesViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                ExerciseListContentView(viewModel: viewModel)
            }// VStack
            .safeAreaInset(edge: .bottom) {
                VStack {}.frame(height: 44)
            }
            .sheet(isPresented: $viewModel.displayAddModal, onDismiss: didDismiss) {
                AddExerciseModal(viewModel: viewModel)
            }
            .sheet(item: $viewModel.selectedExercise, onDismiss: didDismiss) { _ in
                UpdateExerciseModal(viewModel: viewModel)
            }
        } // ZStack
        .background(
            Image("Blob")
                .opacity(0.5)
                .offset(x: 250, y: -100)
                .accessibility(hidden: true)
        )
        .background(Color("Background"))
        .navigationTitle(Text("Exercises"))
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            if viewModel.selectedExercise == nil && !viewModel.displayAddModal {
                HStack {
                    Button(action: {
                        viewModel.displayAddModal = true
                    }) {
                        Image(systemName: "plus")
                    }
                    EditButton()
                }
            } else {
                EmptyView()
            }
        }
        .onAppear {
            viewModel.update()
        }
    }
    
    func didDismiss() {
        viewModel.exitAddModal()
    }
}

struct ExercisesScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesScreenView(viewModel: ExercisesViewModel())
    }
}
