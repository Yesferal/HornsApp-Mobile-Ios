//
//  Route.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/18/26.
//

import SwiftUI

enum Route: Hashable {
    case details(id: String, name: String, day: String, month: String)
    case upcoming
    case favorite
    case home
    case settings
    case web(url: URL)
    
    func asAction(router: Router) -> (() -> Void) {
        return { router.navigate(to: self) }
    }
}

@ViewBuilder
func destination(for route: Route) -> some View {
    switch route {
    case .details(let id, let name, let day, let month):
        EventDetailView(id: id, name: name, day: day, month: month)
    case .settings:
        SettingsView()
    case .web(let url):
        InAppWebView(url: url)
            .ignoresSafeArea()
    case .home, .upcoming, .favorite:
        EmptyView()
    }
}
