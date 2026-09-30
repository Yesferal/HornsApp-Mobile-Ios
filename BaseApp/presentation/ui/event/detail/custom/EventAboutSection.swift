//
//  EventAboutSection.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 8/30/26.
//

import SwiftUI

struct EventAboutSection: View {
    let about: String
    let isFavorite: Bool
    let onFavorite: () -> Void

    @Environment(\.theme) var theme

    var body: some View {
        HStack(alignment: .top) {
            HStack(alignment: .top) {
                Image(systemName: "info.circle")
                    .frame(width: 48)
                    .foregroundColor(theme.secondaryText)
                    .padding(.top, 2)

                HaTitleSubtitle(
                    title: HaLocalizedStringWrapper.getString(key: "about_section"),
                    subtitle: about
                )
            }

            Spacer(minLength: Dimens.medium)

            Button(action: onFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .fontWeight(.bold)
                    .padding(.horizontal, Dimens.large)
                    .padding(.vertical, Dimens.medium)
                    .background(theme.accent)
                    .foregroundColor(.white)
                    .cornerRadius(32)
            }
        }
        .padding(.top, 16)
        .padding(.bottom, Dimens.medium)
    }
}
