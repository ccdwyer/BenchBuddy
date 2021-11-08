//
//  OnboardingData.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 11/7/21.
//

import Foundation
import SwiftUI

struct OnboardingData {
    let headline: String
    let description: String
    let imageName: String?
    let color: Color
}

let onboardingData = [
    OnboardingData(headline: "Welcome to Bench Buddy!", description: "This app is used to build your own customized workout plan", imageName: nil, color: Color("Background")),
    OnboardingData(headline: "Add your own exercises", description: "In the exercises tab, you can create your own exercises, and set your one repetition maximums, which can be used in later calculations.", imageName: "Exercises", color: .indigo),
    OnboardingData(headline: "Build your own program", description: "In the home tab, you can see your entire workout plan.  You can add sets, and create groupings.  This allows you to follow complex programs like Jim Wendler's 5/3/1 easily.", imageName: "MyProgram", color: Color("DarkBackground")),
    OnboardingData(headline: "Customize the app to suit your needs", description: "You can customize the units displayed, and how values increment in the settings tab, as well as see what features are upcoming.", imageName: "Settings", color: .indigo),
    OnboardingData(headline: "", description: "", imageName: nil, color: .clear)
]
