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
    
    var body: some View {
        NavigationLink {
            DetailView(id: event.id, name: event.name ?? "", day: event.getEventDay(), month: event.getEventMonth())
                .background(theme.background)
        } label: {
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
                
                Text(event.name ?? "")
                    .font(.headline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HaIconText(icon: "calendar", text: event.getEventTime())
                HaIconText(icon: "mic", text: event.headlinerName ?? "")
            }
        }
        .buttonStyle(.plain)
    }
}
