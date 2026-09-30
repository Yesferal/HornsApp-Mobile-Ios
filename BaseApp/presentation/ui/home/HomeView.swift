//
//  HomeView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/2/26.
//

import SwiftUI

struct HomeView: View {

    @Environment(\.theme) var theme
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @EnvironmentObject var router: Router

    // TODO: #feat-5-dynamic-tabs — build tabs from app_render.json instead of hardcoding three
    var body: some View {
        Group {
            if horizontalSizeClass == .regular {
                splitView
            } else {
                tabView
            }
        }
        .tint(theme.accent)
        .onChange(of: router.selectedTab) { _, _ in
            // Drop pushed detail when switching Home / Upcoming / Favorite
            router.path = NavigationPath()
        }
    }

    // MARK: - iPhone (compact): tabs

    private var tabView: some View {
        NavigationStack(path: $router.path) {
            TabView(selection: $router.selectedTab) {
                ScreenRenderView()
                    .tabItem {
                        Label(LocalizedStringKey("home"), systemImage: "house")
                    }
                    .tag(HomeTab.home)

                UpcomingView()
                    .tabItem {
                        Label(LocalizedStringKey("upcoming"), systemImage: "calendar")
                    }
                    .tag(HomeTab.upcoming)

                FavoriteView()
                    .tabItem {
                        Label(LocalizedStringKey("favorite"), systemImage: "heart.fill")
                    }
                    .tag(HomeTab.favorite)
            }
            .navigationDestination(for: Route.self) { route in
                destination(for: route)
            }
        }
    }

    // MARK: - iPad (regular): sidebar + detail

    /// iOS `List(selection:)` requires `Binding<SelectionValue?>` (non-optional is macOS-only).
    private var sidebarSelection: Binding<HomeTab?> {
        Binding(
            get: { router.selectedTab },
            set: { newValue in
                if let newValue {
                    router.selectedTab = newValue
                }
            }
        )
    }

    private var splitView: some View {
        NavigationSplitView {
            List(selection: sidebarSelection) {
                Label(LocalizedStringKey("home"), systemImage: "house")
                    .tag(HomeTab.home)
                Label(LocalizedStringKey("upcoming"), systemImage: "calendar")
                    .tag(HomeTab.upcoming)
                Label(LocalizedStringKey("favorite"), systemImage: "heart.fill")
                    .tag(HomeTab.favorite)
            }
            .navigationTitle(appDisplayName)
            .listStyle(.sidebar)
        } detail: {
            NavigationStack(path: $router.path) {
                detailRoot
                    .navigationDestination(for: Route.self) { route in
                        destination(for: route)
                    }
            }
        }
        .navigationSplitViewStyle(.balanced)
    }

    @ViewBuilder
    private var detailRoot: some View {
        switch router.selectedTab {
        case .home:
            ScreenRenderView()
        case .upcoming:
            UpcomingView()
        case .favorite:
            FavoriteView()
        }
    }

    private var appDisplayName: String {
        (Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String)
            ?? (Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String)
            ?? "App"
    }
}
