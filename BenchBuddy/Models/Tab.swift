//
//  Tab.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/24/21.
//

import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
    var color: Color
    var selection: Tab
}

var tabItems = [
    TabItem(name: "Home", icon: "house", color: .teal, selection: .home),
    TabItem(name: "Exercises", icon: "sparkles", color: .pink, selection: .exercises),
    TabItem(name: "Settings", icon: "gear", color: .purple, selection: .settings)
]

enum Tab: String {
    case home
    case exercises
    case settings
}
