//
//  ViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/18/26.
//

import SwiftUI

struct ViewItem: Identifiable {
    let id: UUID
    let data: ViewData
}

enum ViewData {
    case divider(height: CGFloat)
    case carousel(eventModel: EventModel)
    case upcoming(eventModel: EventModel)
    case upcomingCompact(eventModel: EventModel)
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
    case .carousel(let eventModel):
        CarouselViewData(event: eventModel)
    case .upcoming(let eventModel):
        UpcomingViewData(event: eventModel)
    case .upcomingCompact(let eventModel):
        UpcomingCompactViewData(event: eventModel)
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
