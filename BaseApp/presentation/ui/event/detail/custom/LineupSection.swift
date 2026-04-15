//
//  LineupSection.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 4/12/26.
//

import SwiftUI
import HornsAppCore

struct LineupSection: View {
    let event: Concert
    
    @Environment(\.theme) var theme

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {

            // Section header
            HStack(spacing: 8) {
                Text("activities_section")
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

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 12) {
                    let activities = event.activities ?? []
                    if  activities.isEmpty {
                        ActivityCard(name: event.headlinerName, image: event.headlinerImageUrl, isHeadliner: false)
                    } else {
                        ForEach(activities, id: \.id) { activity in
                            ActivityCard(name: activity.name, image: activity.membersImage, isHeadliner: false)
                        }
                    }

                    // MoreArtistsCard(count: 3)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
    }
}

// MARK: - Artist card
struct ActivityCard: View {
    let name: String?
    let image: String?
    let isHeadliner: Bool
    
    let CARD_WIDTH: CGFloat = 108
    
    @Environment(\.theme) var theme

    var body: some View {
        VStack(spacing: 4) {
            Circle()
                .fill(Color.black)
                .frame(width: CARD_WIDTH, height: CARD_WIDTH)
                .overlay(
                    AsyncImage(url: URL(string: image ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        theme.background
                    }
                )
                .clipShape(Circle())

            if isHeadliner {
                Text("key_headliner")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 1)
                    .background(theme.accent)
                    .textCase(.uppercase)
                    .cornerRadius(3)
            } else {
                Spacer().frame(height: 14)
            }

            Text(name ?? "")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .frame(width: CARD_WIDTH)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
        }
        .frame(width: CARD_WIDTH)
    }
}
