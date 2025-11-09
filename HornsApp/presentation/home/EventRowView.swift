//
//  EventRow.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/28/25.
//

import SwiftUI

struct EventRowView: View {
    
    var event: EventModel
    
    var body: some View {
        NavigationLink {
            DetailView(id: event.id, name: event.name ?? "", day: event.getEventDay(), month: event.getEventMonth())
        } label: {
            HStack(alignment: .top) {
                VStack {
                    HaEventDate(day: event.getEventDay(), month: event.getEventMonth())
                    HaVerticalDashLine()
                }
                AsyncImage(url: URL(string: event.headlinerUrl ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.white
                }
                .aspectRatio(1.6, contentMode: .fit)
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
                .clipShape(.rect(cornerRadius: 16))
            }
        }
    }
}
