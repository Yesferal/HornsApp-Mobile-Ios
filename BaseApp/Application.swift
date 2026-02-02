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
    @StateObject private var favoriteVM = FavoriteViewModel()
    
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
            .environmentObject(favoriteVM)
            .modelContainer(for: SwiftDataConcert.self)
        }
    }
}
