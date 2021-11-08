//
//  TimerView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerViewModel: TimerViewModel
    
    var durationDescription: String {
        let timeRemaining = timerViewModel.timeRemaining
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return "\(minutes)m \(seconds)s"
    }
    
    var progress: Double {
        return Double(timerViewModel.timeRemaining) / Double(timerViewModel.initialDuration)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundColor(Color.gray)
                
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.accentColor)
                .rotationEffect(Angle(degrees: 270.0))
            
            Text(durationDescription)
                .font(.title)
        } // Zstack
    } // body
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timerViewModel: TimerViewModel(withDurationInSeconds: 60))
    }
}
