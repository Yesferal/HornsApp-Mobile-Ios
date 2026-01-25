//
//  CarouselRow.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import SwiftUI

struct CarouselViewData: View {
    var event: EventModel
    
    @Environment(\.theme) var theme
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: event.headlinerUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                theme.background
            }
            .aspectRatio(1.6, contentMode: .fit)
            .overlay() {
                ZStack {
                    Spacer()
                }
                .background(Color.black.opacity(0.5))
            }
            .onTapGesture {
                router.navigate(to: .details(id: event.id, name: event.name ?? "", day: event.getEventDay(), month: event.getEventMonth()))
            }
            .padding(.vertical, Dimens.medium)
            
            HStack {
                VStack(alignment: .leading, spacing: Dimens.small) {
                    Text(event.name ?? "")
                        .foregroundColor(theme.primaryText)
                        .font(.title2)
                        .bold()
                    
                    HaIconText(icon: "calendar", text: event.getEventTime())
                        .background(theme.background)
                    HaIconText(icon: "mic", text: event.headlinerName ?? "")
                        .background(theme.background)
                }
                .onTapGesture {
                    router.navigate(to: .details(id: event.id, name: event.name ?? "", day: event.getEventDay(), month: event.getEventMonth()))
                }
                
                if let url = URL(string: event.ticketingUrl ?? "") {
                    CtaViewData(actionText: event.ticketingName, route: .web(url: url))
                }
            }
            .padding(.horizontal, Dimens.medium)
        }
        .padding(.vertical, Dimens.small)
    }
}
