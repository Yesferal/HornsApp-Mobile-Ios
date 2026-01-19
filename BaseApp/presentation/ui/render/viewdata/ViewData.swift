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
    case divider
    case carousel(eventModel: EventModel)
    case upcoming(eventModel: EventModel)
}

@ViewBuilder
func render(_ viewData: ViewData) -> some View {
    switch viewData {
    case .divider:
        DividerViewData()
    case .carousel(let eventModel):
        CarouselViewData(event: eventModel)
    case .upcoming(let eventModel):
        UpcomingViewData(event: eventModel)
    }
}
