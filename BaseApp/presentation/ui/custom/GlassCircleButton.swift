//
//  GlassCircleButton.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/2/26.
//

import SwiftUI

/// Icon in a 36pt ultra-thin material circle (e.g. open / close search).
struct GlassCircleButton: View {
    let systemName: String
    let accessibilityLabel: LocalizedStringKey
    let action: () -> Void

    @Environment(\.theme) private var theme

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(theme.accent)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial, in: Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(accessibilityLabel)
    }
}
