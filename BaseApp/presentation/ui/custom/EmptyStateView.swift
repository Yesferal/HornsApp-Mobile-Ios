//
//  EmptyStateView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 9/29/26.
//

import SwiftUI

struct EmptyStateView: View {
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    let systemImage: String
    var actionTitle: LocalizedStringKey? = nil
    var action: (() -> Void)? = nil

    @Environment(\.theme) private var theme

    var body: some View {
        VStack(spacing: Dimens.medium) {
            Image(systemName: systemImage)
                .font(.system(size: Dimens.xlarge * 2))
                .foregroundStyle(theme.accent)

            Text(title)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundStyle(theme.primaryText)

            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(theme.secondaryText)
                .padding(.horizontal, Dimens.large)

            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .padding(.horizontal, Dimens.large)
                    .padding(.vertical, Dimens.medium)
                    .fontWeight(.bold)
                    .background(theme.accent)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 32))
                    .padding(.top, Dimens.small)
            }
        }
        .padding(Dimens.large)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .readableContentWidth()
    }
}
