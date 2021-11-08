//
//  ContentView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/3/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @AppStorage("showAccount") var showAccount = false
    @StateObject var setModalViewModel = SetViewModel(forSetWithId: nil)
    @AppStorage("finishedOnboarding") var finishedOnboarding = false
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        showAccount = false
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                switch selectedTab {
                case .home:
                    FolderView(viewModel: FolderViewModel(folderId: Store.RootNodeUUID), addNodeModalViewModel: AddNodeModalViewModel(folderNodeId: Store.RootNodeUUID))
                case .exercises:
                    ExercisesScreenView()
                case .settings:
                    SettingsScreenView()
                }
            }
            .environmentObject(setModalViewModel)
            .navigationViewStyle(StackNavigationViewStyle())
            .safeAreaInset(edge: .bottom) {
                VStack {}.frame(height: 44)
            }
            
            TabBar()
            
            if setModalViewModel.selectedSet != nil {
                SetModalView(viewModel: setModalViewModel)
            }
            
            if !finishedOnboarding {
                ConcentricOnboardingView(pageContents: onboardingData.map { (OnboardingSlideView(data: $0), $0.color) })
                    .duration(1.0)
                    .nextIcon("chevron.forward")
                    .didGoToLastPage {
                        self.finishedOnboarding = true
                    }
            }
            
        } // ZStack
        .onAppear {
            Store.global.load()
        }
        .dynamicTypeSize(.large ... .xxLarge)
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { Store.global.save() }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
