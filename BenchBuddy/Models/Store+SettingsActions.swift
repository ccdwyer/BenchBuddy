//
//  Store+SettingsActions.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 11/1/21.
//

import Foundation

extension Store {
    func update(_ settings: Settings) {
        self.state.settings = settings
    }
}
