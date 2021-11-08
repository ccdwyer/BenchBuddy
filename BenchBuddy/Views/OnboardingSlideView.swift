//
//  OnboardingSlideView.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 11/7/21.
//

import SwiftUI

struct OnboardingSlideView: View {
    let data: OnboardingData
    var body: some View {
        VStack() {
            if let imageName = data.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
            }
            
            Text(data.headline)
                .font(.title)
                .padding()
            
            Text(data.description)
                .padding()
        }
        .safeAreaInset(edge: .bottom) {
            VStack {}.frame(height: 200)
        }
        .safeAreaInset(edge: .top) {
            VStack {}.frame(height: 44)
        }
    }
}

struct OnboardingSlideView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSlideView(data: onboardingData[0])
    }
}
