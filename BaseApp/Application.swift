//
//  HornsAppApp.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/18/25.
//

import SwiftUI

@main
struct Application: App {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    
    let theme: Theme = .appTheme
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                ContentView().environment(\.theme, theme)
            } else {
                OnboardingView().environment(\.theme, theme)
            }
        }
    }
}
