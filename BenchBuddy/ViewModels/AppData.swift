//
//  AppData.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/4/21.
//

import Foundation

class AppData: ObservableObject {
    @Published var folders: [Folder] = []
    @Published var settings: [String] = []
}
