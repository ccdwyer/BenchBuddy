//
//  BenchBuddyApp.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/3/21.
//

import SwiftUI

@main
struct BenchBuddyApp: App {
    @StateObject var model = Model()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
