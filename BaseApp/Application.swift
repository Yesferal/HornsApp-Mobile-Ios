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
    let dependencies = AppDependencies()

    init() {
        UIView.appearance().overrideUserInterfaceStyle = Theme.uiUserInterfaceStyle
    }

    var body: some Scene {
        WindowGroup {
            AppRootView(dependencies: dependencies)
                .environment(\.theme, theme)
                .environment(\.dependencies, dependencies)
                .modelContainer(for: SwiftDataConcert.self)
        }
    }
}

// If this feels heavy long-term, alternatives are:
// 1. Inject a refresh notification instead of a global FavoriteViewModel
// 2. Move favorite sync to a small service in AppDependencies
// For now, AppRootView is the minimal fix to get init() injection working without bringing back configure().
private struct AppRootView: View {
    let dependencies: AppDependencies

    @Environment(\.modelContext) private var context

    @StateObject private var router = Router()
    @State private var favoriteVM: FavoriteViewModel?

    var body: some View {
        Group {
            if let favoriteVM {
                // NavigationStack lives in HomeView (TabView vs NavigationSplitView).
                ContentView()
                    .environmentObject(router)
                    .environmentObject(favoriteVM)
            } else {
                HaProgressView()
            }
        }
        .onAppear {
            if favoriteVM == nil {
                favoriteVM = FavoriteViewModel(
                    getFavoriteConcertsUseCase: dependencies.makeGetFavoriteConcertsUseCase(context: context)
                )
            }
        }
    }
}
