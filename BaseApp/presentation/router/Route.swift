//
//  route.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/18/26.
//

import SwiftUI
import SwiftData

enum Route: Hashable {
    case details(id: String, name: String, day: String, month: String)
    case upcoming
    case favorite
    case home
    case web(url: URL)
}

@ViewBuilder
func destination(for route: Route, context: ModelContext) -> some View {
    let _ = print("Navigating to:", route, type(of: route))

    switch route {
    case .details(let id, let name, let day, let month):
        DetailView(id: id, name: name, day: day, month: month, context: context)
    case .upcoming:
        UpcomingView()
    case .favorite:
        FavoriteView()
    case .home:
        ScreenRenderView()
    case .web(let url):
        InAppWebView(url: url)
            .ignoresSafeArea()
    }
}
