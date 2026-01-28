//
//  ViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/18/26.
//

import SwiftUI
import HornsAppCore

struct ViewItem: Identifiable {
    let id: UUID
    let data: ViewData
}

enum ViewData {
    case divider(height: CGFloat)
    case carousel(concert: Concert)
    case upcoming(concert: Concert)
    case upcomingCompact(concert: Concert)
    case title(title: String, subtitle: String?, route: Route?)
    case seeMore(title: String, subtitle: String, icon: String, backgroundColor: String, buttonBackgroundColor: String, buttonForegroundColor: String, actionText: String, route: Route?)
    case home(title: String, subtitle: String?, imageUrl: String, route: Route?)
    case empty
    case ad
}

@ViewBuilder
func render(_ viewData: ViewData) -> some View {
    switch viewData {
    case .divider(let height):
        DividerViewData(height: height)
    case .carousel(let concert):
        CarouselViewData(concert: concert)
    case .upcoming(let concert):
        UpcomingViewData(concert: concert)
    case .upcomingCompact(let concert):
        UpcomingCompactViewData(concert: concert)
    case .title(let title, let subtitle, let route):
        TitleViewData(title: title, subtitle: subtitle, route: route)
    case .seeMore(let title, let subtitle, let icon, let backgroundColor, let buttonBackgroundColor, let buttonForegroundColor, let actionText, let route):
        SeeMoreViewData(title: title, subtitle: subtitle, icon: icon, backgroundColor: backgroundColor, buttonBackgroundColor: buttonBackgroundColor, buttonForegroundColor: buttonForegroundColor, actionText: actionText, route: route)
    case .home(let title, let subtitle, let imageUrl, let route):
        HomeViewData(title: title, subtitle: subtitle, imageUrl: imageUrl, route: route)
    case .empty:
        EmptyView()
    case .ad:
        EmptyView()
    }
}
