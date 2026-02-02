//
//  CarouselRow.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import SwiftUI
import HornsAppCore

struct CarouselViewData: View {
    var concert: Concert
    
    @Environment(\.theme) var theme
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: concert.headlinerImageUrl ?? "")) { image in
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
                router.navigate(to: .details(id: concert.id, name: concert.name ?? "", day: concert.getEventDay(), month: concert.getEventMonth()))
            }
            .padding(.vertical, Dimens.medium)
            
            HStack {
                VStack(alignment: .leading, spacing: Dimens.small) {
                    Text(concert.name ?? "")
                        .foregroundColor(theme.primaryText)
                        .font(.title2)
                        .bold()
                    
                    HaIconText(icon: "calendar", text: concert.getEventAsCalendarLabel())
                        .background(theme.background)
                    HaIconText(icon: "mic", text: concert.headlinerName ?? "")
                        .background(theme.background)
                }
                .onTapGesture {
                    router.navigate(to: .details(id: concert.id, name: concert.name ?? "", day: concert.getEventDay(), month: concert.getEventMonth()))
                }
                
                if let url = URL(string: concert.ticketingUrl ?? "") {
                    CtaViewData(actionText: concert.ticketingName, route: .web(url: url))
                }
            }
            .padding(.horizontal, Dimens.medium)
        }
        .padding(.vertical, Dimens.small)
    }
}
