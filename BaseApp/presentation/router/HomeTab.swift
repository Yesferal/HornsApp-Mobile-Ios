//
//  HomeTab.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 8/30/26.
//

import HornsAppCore

enum HomeTab: Hashable {
    case home
    case upcoming
    case favorite

    init?(route: Route) {
        switch route {
        case .home:
            self = .home
        case .upcoming:
            self = .upcoming
        case .favorite:
            self = .favorite
        default:
            return nil
        }
    }
}
