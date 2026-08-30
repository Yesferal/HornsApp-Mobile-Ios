//
//  Router.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/18/26.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var path = NavigationPath()
    @Published var selectedTab: HomeTab = .home

    func navigate(to route: Route) {
        if let tab = HomeTab(route: route) {
            selectedTab = tab
            return
        }
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }
}
