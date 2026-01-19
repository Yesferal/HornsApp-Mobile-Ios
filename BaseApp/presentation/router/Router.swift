//
//  router.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/18/26.
//

final class Router: ObservableObject {
    @Published var path: [Route] = []

    func navigate(to route: Route) {
        path.append(route)
    }

    func pop() {
        _ = path.popLast()
    }

    func reset() {
        path.removeAll()
    }
}
