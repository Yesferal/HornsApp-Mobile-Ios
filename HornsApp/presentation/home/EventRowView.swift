//
//  EventRow.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/28/25.
//

import SwiftUI

struct EventRow: View {
    
    var event: EventModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: event.headlinerUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 128, height: 80)
            .clipShape(.rect(cornerRadius: 16))
            
            Text(event.name ?? "")
            
            Spacer()
        }
    }
}
