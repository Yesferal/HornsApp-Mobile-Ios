//
//  UpcomingCompactViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/20/26.
//

import SwiftUI
import HornsAppCore

struct UpcomingCompactViewData: View {

    var concert: Concert

    @Environment(\.theme) var theme

    @EnvironmentObject var router: Router

    var body: some View {
        Button {
            router.navigate(to: .details(id: concert.id, name: concert.name ?? "", day: concert.getEventDay(), month: concert.getEventMonth()))
        } label: {
            HStack(alignment: .top, spacing: Dimens.medium) {
                HaEventDate(day: concert.getEventDay(), month: concert.getEventMonth())
                HaTitleSubtitle(title: concert.name ?? "", subtitle: concert.ticketingName ?? "")
                    .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .padding(.vertical, Dimens.medium)
        .buttonStyle(.plain)
    }
}
