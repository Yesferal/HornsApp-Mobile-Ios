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
    case title(title: String, subtitle: String?)
    case seeMore(title: String, subtitle: String, icon: String, backgroundColor: String, buttonBackgroundColor: String, buttonForegroundColor: String, actionText: String, action: () -> Void)
    case home(title: String, subtitle: String?, imageUrl: String)
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
    case .title(let title, let subtitle):
        TitleViewData(title: title, subtitle: subtitle)
    case .seeMore(let title, let subtitle, let icon, let backgroundColor, let buttonBackgroundColor, let buttonForegroundColor, let actionText, let action):
        SeeMoreViewData(title: title, subtitle: subtitle, icon: icon, backgroundColor: backgroundColor, buttonBackgroundColor: buttonBackgroundColor, buttonForegroundColor: buttonForegroundColor, actionText: actionText, action: action)
    case .home(let title, let subtitle, let imageUrl):
        HomeViewData(title: title, subtitle: subtitle, imageUrl: imageUrl)
    case .empty:
        EmptyView()
    case .ad:
        EmptyView()
    }
}
