//
//  router.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/18/26.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var path = NavigationPath()

    func navigate(to route: Route) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }
}
