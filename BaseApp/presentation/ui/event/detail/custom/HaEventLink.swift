//
//  HaEventLink.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/22/25.
//

import SwiftUI

/// Tappable row: leading icon + title[/subtitle] + trailing chevron (or external arrow).
struct HaEventLink: View {

    @Environment(\.theme) var theme

    let iconName: String
    let title: String
    var subtitle: String? = nil
    /// When `true`, icon uses accent (nav-style CTAs); otherwise secondary text (detail rows).
    var accentIcon: Bool = false
    var trailingSystemName: String = "chevron.right"
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: iconName)
                    .frame(width: 48)
                    .foregroundStyle(accentIcon ? theme.accent : theme.secondaryText)
                HaTitleSubtitle(title: title, subtitle: subtitle)
                Spacer(minLength: 0)
                Image(systemName: trailingSystemName)
                    .font(.footnote)
                    .foregroundStyle(theme.secondaryText)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            // Plain buttons only hit opaque glyphs; Spacer / padding need an explicit shape.
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
