//
//  EventRow.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/28/25.
//

import SwiftUI

struct UpcomingViewData: View {
    
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
                ImageViewData(url: event.headlinerUrl ?? "")
                .overlay() {
                    ZStack {
                        VStack {
                            Spacer()
                            Text("#" + event.getEventYear())
                                .font(.subheadline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(event.name ?? "")
                                .font(.headline)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack {
                                HaIconText(icon: "calendar", text: event.getEventTime())
                                HaIconText(icon: "mic", text: event.headlinerName ?? "")
                            }
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.5))
                }
                .clipShape(.rect(cornerRadius: 24))
            }
        }
        .buttonStyle(.plain)
    }
}
