//
//  HomeView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/2/26.
//

import SwiftUI

struct HomeView: View {

    @Environment(\.theme) var theme
    @EnvironmentObject var router: Router

    // TODO: #feat-5-dynamic-tabs — build tabs from app_render.json instead of hardcoding three
    var body: some View {
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
        .tint(theme.accent)
    }
}
