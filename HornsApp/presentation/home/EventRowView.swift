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
        HStack {
            VStack {
                Text(event.getEventDay())
                Text(event.getEventMonth())
            }.frame(maxHeight: .infinity, alignment: .topLeading)
            AsyncImage(url: URL(string: event.headlinerUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.white
            }
            .aspectRatio(1.6, contentMode: .fit)
            .overlay() {
                VStack {
                    Spacer()
                    Text("#" + event.getEventYear())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(event.name ?? "")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Text(event.getEventTime())
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(event.headlinerName ?? "")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }.background(Color.black.opacity(0.35))
            }
            .clipShape(.rect(cornerRadius: 8))
        }
    }
}
