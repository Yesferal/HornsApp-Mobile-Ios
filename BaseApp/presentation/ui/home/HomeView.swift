//
//  HomeView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/2/26.
//

import SwiftUI

struct HomeView: View {

    @Environment(\.theme) var theme
    
    // TODO: 1: Improve navigation instead of opening new Upcomingor Favorite view
    // TODO: 2: Create these views dynamically instead of has only the same three
    /*
    enum Tab {
        case home, upcoming, favorite
    }

    @State private var selectedTab: Tab = .home*/

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
