//
//  UpcomingCompactViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/20/26.
//

import SwiftUI

struct UpcomingCompactViewData: View {
    
    var event: EventModel
    
    @Environment(\.theme) var theme
    
    @EnvironmentObject var router: Router

    var body: some View {
        Button {
            router.navigate(to: .details(id: event.id, name: event.name ?? "", day: event.getEventDay(), month: event.getEventMonth()))
        } label: {
            HStack(alignment: .top) {
                VStack {
                    HaEventDate(day: event.getEventDay(), month: event.getEventMonth())
                    HaVerticalDashLine()
                }
                
                HaTittleSubTittle(title: event.name ?? "", subtitle: event.ticketingName ?? "")
                    .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .buttonStyle(.plain)
    }
}
