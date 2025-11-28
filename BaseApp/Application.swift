//
//  HornsAppApp.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/18/25.
//

import SwiftUI

@main
struct Application: App {
    let theme: Theme = .appTheme
    
    init() {
        UIView.appearance().overrideUserInterfaceStyle = Theme.uiUserInterfaceStyle
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.theme, theme)
        }
    }
}
