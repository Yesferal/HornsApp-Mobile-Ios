//
//  HomeView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/2/26.
//

import SwiftUI

struct HomeView: View {

    @Environment(\.theme) var theme

    // TODO: #arch-6b-tab-switching — switch tabs instead of pushing duplicate screens (needs per-tab stack design)
    // TODO: #feat-5-dynamic-tabs — build tabs from app_render.json instead of hardcoding three
    var body: some View {
        TabView {
            ScreenRenderView()
                .tabItem {
                    Label("home", systemImage: "house")
                }
                //.tag(Tab.home)

            UpcomingView()
                .tabItem {
                    Label("upcoming", systemImage: "calendar")
                }
                //.tag(Tab.upcoming)
            
            FavoriteView()
                .tabItem {
                    Label("favorite", systemImage: "heart.fill")
                }
                //.tag(Tab.favorite)
        }
        .tint(theme.accent)
    }
}
