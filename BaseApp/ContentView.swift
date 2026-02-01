//
//  ContentView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/18/25.
//

import SwiftUI
import HornsAppCore

struct ContentView: View {

    @Environment(\.modelContext) var context

    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    
    let showDevInfo = false
    
    var localized = LocalizedString(en: "English!", es: "Español!").text ?? "Fake text"
    
    var body: some View {
        if showDevInfo {
            Text("HornsAppCore: Version: " + HornsAppCoreConfig().hornsAppCoreLibVersion)
                .padding()
            Text("Localized String: " + localized)
                .padding()
        }
        
        if hasSeenOnboarding {
            ScreenRenderView()
                .navigationDestination(for: Route.self) { route in
                    destination(for: route, context: context)
                }
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}
