//
//  TimerViewModel.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/30/21.
//

import Foundation
import SwiftUI

class TimerViewModel: ObservableObject {
    let initialDuration: Int
    @Published var timeRemaining = 0
    @Published var running = false
    
    var timer: Timer?
    
    init(withDurationInSeconds duration: Int) {
        self.initialDuration = duration
        self.timeRemaining = duration
    }
    
    func startTimer() {
        self.running = true
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            withAnimation(.linear) {
                self.timeRemaining -= 1
            }
            
            if self.timeRemaining == 0 {
                self.timer?.invalidate()
            }
        }
    }
    
    func pauseTimer() {
        self.running = false
        self.timer?.invalidate()
    }
    
    func resetTimer() {
        self.running = false
        self.timer?.invalidate()
        self.timeRemaining = initialDuration
    }
}
