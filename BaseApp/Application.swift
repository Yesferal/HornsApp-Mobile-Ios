//
//  HornsAppApp.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/18/25.
//

import SwiftUI
import SwiftData

@main
struct Application: App {
    let theme: Theme = .appTheme
    
    @StateObject private var router = Router()
    
    init() {
        UIView.appearance().overrideUserInterfaceStyle = Theme.uiUserInterfaceStyle
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                ContentView()
            }
            .environment(\.theme, theme)
            .environmentObject(router)
            .modelContainer(for: SwiftDataConcert.self)
        }
    }
}
