//
//  route.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/18/26.
//

import SwiftUI

enum Route: Hashable {
    case details(id: String, name: String, day: String, month: String)
    case home
}

@ViewBuilder
func destination(for route: Route) -> some View {
    switch route {
    case .details(let id, let name, let day, let month):
        DetailView(id: id, name: name, day: day, month: month)
        
    case .home:
        HomeView()
    }
}
