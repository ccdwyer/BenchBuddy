//
//  CardioSetModalView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import SwiftUI

struct CardioModalContentView: View {
    @StateObject var timerViewModel: TimerViewModel
    @ObservedObject var setViewModel: SetViewModel
    
    var body: some View {
        VStack {
            TimerView(timerViewModel: timerViewModel)
                .padding(5)
                .frame(maxWidth: 200, maxHeight: 200)
                
            HStack {
                Button(action: {
                    timerViewModel.resetTimer()
                }) {
                    Text("Reset")
                        .bold()
                        .foregroundColor(.red)
                        .padding()
                        .background(.red.opacity(0.2))
                        .cornerRadius(8)
                }
                Spacer()
                if timerViewModel.running {
                    Button(action: {
                        timerViewModel.pauseTimer()
                    }) {
                        Text("Pause")
                            .bold()
                            .foregroundColor(.yellow)
                            .padding()
                            .background(.yellow.opacity(0.2))
                            .cornerRadius(8)
                    }
                } else {
                    Button(action: {
                        timerViewModel.startTimer()
                    }) {
                        Text("Start")
                            .bold()
                            .foregroundColor(.green)
                            .padding()
                            .background(.green.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            } // Button HStack
            .frame(maxWidth: 200)
            
            SetActions(setViewModel: setViewModel)
        } // Modal content Vstack
        
    }
}

struct CardioModalContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardioModalContentView(timerViewModel: TimerViewModel(withDurationInSeconds: 245), setViewModel: SetViewModel(forSetWithId: FolderNode.incompleteCardioSetId))
        }
        .preferredColorScheme(.dark) // Card
        .padding()
        .background(Material.ultraThin)
        .cornerRadius(8.0)
        .shadow(color: Color("Shadow").opacity(0.5), radius: 8.0, x: 0, y: 0)
    }
}
