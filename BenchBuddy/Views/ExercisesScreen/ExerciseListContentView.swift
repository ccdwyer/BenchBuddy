//
//  ExerciseListContentView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 11/1/21.
//

import SwiftUI

struct ExerciseListContentView: View {
    @ObservedObject var viewModel: ExercisesViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.exercises) { exercise in
                Button(action: {
                    viewModel.select(exercise)
                }) {
                    Text(exercise.name)
                }
            } // ForEach viewModel.children
            .onDelete {
                indexes in
                Store.global.deleteExercises(atOffsets: indexes)
            }
            .onMove {
                indexes, destination in
                Store.global.moveExercises(fromOffsets: indexes, toOffset: destination)
            }
            .listRowBackground(
                HStack{}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ultraThinMaterial)
            )
            .foregroundColor(.primary)
        } // List
    }
}

struct ExerciseListContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListContentView(viewModel: ExercisesViewModel())
    }
}
