//
//  EventRow.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/28/25.
//

import SwiftUI
import HornsAppCore

struct UpcomingViewData: View {
    
    var concert: Concert

    @Environment(\.theme) var theme
    
    @EnvironmentObject var router: Router

    var body: some View {
        Button {
            router.navigate(to: .details(id: concert.id, name: concert.name ?? "", day: concert.getEventDay(), month: concert.getEventMonth()))
        } label: {
            HStack(alignment: .top) {
                VStack {
                    HaEventDate(day: concert.getEventDay(), month: concert.getEventMonth())
                    HaVerticalDashLine()
                }
                ImageViewData(url: concert.headlinerImageUrl ?? "")
                .overlay() {
                    ZStack {
                        VStack {
                            Spacer()
                            Text("#" + concert.getEventYear())
                                .font(.subheadline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(concert.name ?? "")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack {
                                HaIconText(icon: "calendar", text: concert.getEventTime())
                                HaIconText(icon: "mic", text: concert.headlinerName ?? "")
                            }
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.5))
                }
                .clipShape(.rect(cornerRadius: 24))
            }
        }
        .padding()
        .buttonStyle(.plain)
    }
}
