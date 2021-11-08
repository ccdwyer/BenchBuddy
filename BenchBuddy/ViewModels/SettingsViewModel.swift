//
//  SettingsViewModel.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 11/1/21.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    enum WeightIncrement: String, Equatable, CaseIterable {
        case one = "1"
        case twoPointFive = "2.5"
        case five = "5"
    }
    
    enum TimeIncrement: String, Equatable, CaseIterable {
        case one = "1 minute"
        case five = "5 minutes"
        case fifteen = "15 minutes"
    }
    
    var oldUnit = Store.global.state.settings.unit
    var oldWeightIncrement: WeightIncrement = {
        switch Store.global.state.settings.weightIncrement {
        case 1.0:
            return .one
        case 2.5:
            return .twoPointFive
        case 5.0:
            return .five
        default:
            return .one
        }
    }()
    var oldTimeIncrement: TimeIncrement = {
        switch Store.global.state.settings.timeIncrement {
        case 1:
            return .one
        case 5:
            return .five
        case 15:
            return .fifteen
        default:
            return .one
        }
    }()
    
    @Published var dirty = false
    
    @Published var unit: WeightUnit = Store.global.state.settings.unit {
        didSet {
            checkIfDirty()
        }
    }
    @Published var weightIncrement: WeightIncrement = {
        switch Store.global.state.settings.weightIncrement {
        case 1.0:
            return .one
        case 2.5:
            return .twoPointFive
        case 5.0:
            return .five
        default:
            return .one
        }
    }() {
        didSet {
            checkIfDirty()
        }
    }
    @Published var timeIncrement: TimeIncrement = {
        switch Store.global.state.settings.timeIncrement {
        case 1:
            return .one
        case 5:
            return .five
        case 15:
            return .fifteen
        default:
            return .one
        }
    }() {
        didSet {
            checkIfDirty()
        }
    }
    
    var subscription: AnyCancellable?
    
    init() {
        self.subscription = Store.global.$state.sink(receiveValue: { [weak self] state in
            self?.update(withState: state)
        })
    }
    
    func update(withState state: Store.State = Store.global.state) {
        self.unit = state.settings.unit
        self.oldUnit = state.settings.unit
        
        switch state.settings.weightIncrement {
        case 1.0:
            self.weightIncrement = .one
            self.oldWeightIncrement = .one
        case 2.5:
            self.weightIncrement = .twoPointFive
            self.oldWeightIncrement = .twoPointFive
        case 5.0:
            self.weightIncrement = .five
            self.oldWeightIncrement = .five
        default:
            self.weightIncrement = .one
            self.oldWeightIncrement = .one
        }
        
        switch state.settings.timeIncrement {
        case 1:
            self.timeIncrement = .one
            self.oldTimeIncrement = .one
        case 5:
            self.timeIncrement = .five
            self.oldTimeIncrement = .five
        case 15:
            self.timeIncrement = .fifteen
            self.oldTimeIncrement = .fifteen
        default:
            self.timeIncrement = .one
            self.oldTimeIncrement = .one
        }
        
        self.dirty = false
    }
    
    private func checkIfDirty() {
        self.dirty = self.unit != self.oldUnit || self.weightIncrement != self.oldWeightIncrement || self.timeIncrement != self.oldTimeIncrement
    }
    
    func updateSettings() {
        var wi: Double
        switch self.weightIncrement {
        case .one:
            wi = 1.0
        case .twoPointFive:
            wi = 2.5
        case .five:
            wi = 5.0
        }
        
        var ti: Int
        switch self.timeIncrement {
        case .one:
            ti = 1
        case .five:
            ti = 5
        case .fifteen:
            ti = 15
        }
        
        let newSettings = Settings(unit: unit, weightIncrement: wi, timeIncrement: ti)
        guard Store.global.state.settings != newSettings else { return }
        
        Store.global.update(newSettings)
        self.oldUnit = self.unit
        self.oldWeightIncrement = self.weightIncrement
        self.oldTimeIncrement = self.timeIncrement
        self.dirty = false
    }
}
