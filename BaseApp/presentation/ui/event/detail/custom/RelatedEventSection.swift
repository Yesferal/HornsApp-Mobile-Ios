//
//  RelatedSection.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 4/12/26.
//

import SwiftUI
import HornsAppCore

struct RelatedEventSection: View {
    let events: [Concert]

    @Environment(\.theme) var theme

    var body: some View {
        if events.isEmpty {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 32) {
                // Section header
                HStack(spacing: 8) {
                    Text("related_event_section")
                        .font(.headline)
                        .foregroundColor(theme.primaryText)
                        .textCase(.uppercase)
                    
                    Text("new_label")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(theme.accent)
                        .textCase(.uppercase)
                        .cornerRadius(3)
                }
                .padding(.top, 16)
                
                ForEach(events, id: \.id) { event in
                    UpcomingCompactViewData(concert: event)
                }
            }
        }
    }
}
