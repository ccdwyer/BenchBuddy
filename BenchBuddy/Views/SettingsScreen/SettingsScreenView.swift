//
//  SettingsScreenView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 11/1/21.
//

import SwiftUI

struct SettingsScreenView: View {
    @StateObject var viewModel: SettingsViewModel = SettingsViewModel()
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack {
                    Text("Weight Unit")
                    Picker("Weight Unit", selection: $viewModel.unit) {
                        ForEach(WeightUnit.allCases, id: \.rawValue) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("Weight Increment")
                    Picker("Weight Increment", selection: $viewModel.weightIncrement) {
                        ForEach(SettingsViewModel.WeightIncrement.allCases, id: \.rawValue) { increment in
                            Text("\(increment.rawValue) \(viewModel.unit.rawValue)").tag(increment)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("Time Increment")
                    Picker("Time Increment", selection: $viewModel.timeIncrement) {
                        ForEach(SettingsViewModel.TimeIncrement.allCases, id: \.rawValue) { increment in
                            Text(increment.rawValue).tag(increment)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16.0)
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("What's coming soon...")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom)
                    Text("Version 1.1")
                        .font(.headline)
                    Text("Estimated release date: December 2021")
                        .font(.caption)
                        .padding(.bottom, 1)
                    Text("• Preloaded weight lifting plans, including 5/3/1, Bigger Leaner Stronger, Thinner Leaner Stronger, Starting Strength, StrongLifts 5x5, Push Pull Legs, The Texas Method, and more!")
                        .font(.caption)
                        .padding(.bottom, 8)
                    Text("Version 1.2")
                        .font(.headline)
                    Text("Estimated release date: January 2022")
                        .font(.caption)
                        .padding(.bottom, 1)
                    Text("• Cardio tracking in background")
                        .font(.caption)
                        .padding(.bottom, 2)
                    Text("• Music controls in app")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16.0)
                .padding([.horizontal, .top])
                
                VStack(alignment: .leading) {
                    Text("Have feedback? Reach out!")
                        .font(.title3)
                        .padding(.bottom, 4)
                    
                    Text("Email me at [chris.dwyer@hey.com](mailto:chris.dwyer@hey.com)")
                    
                    Text("Submit feature requests at")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16.0)
                .padding([.horizontal, .top])
                
                
                
                VStack {}.frame(height: 80)
            }// Scroll View

            if viewModel.dirty {
                VStack {
                    Spacer()
                
                    Button(action: {
                        viewModel.updateSettings()
                    }) {
                        AngularButton(title: "Update Settings")
                    }
                    .padding([.horizontal, .bottom])
                    .padding(.vertical)
                }
            }
        } // VStack
        .background(
            Image("Blob")
                .opacity(0.5)
                .offset(x: 250, y: -100)
                .accessibility(hidden: true)
        )
        .background(Color("Background"))
        .navigationTitle(Text("Settings"))
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            viewModel.update()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            VStack {}.frame(height: 44)
        }
    }
}

struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreenView()
    }
}
