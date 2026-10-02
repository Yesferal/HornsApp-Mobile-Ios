//
//  HaEventLink.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/22/25.
//

import SwiftUI

/// Row: leading icon + title[/subtitle] + trailing value and/or chevron.
/// Pass `action` for tappable rows; omit it for read-only (e.g. Settings version).
struct HaEventLink: View {

    @Environment(\.theme) var theme

    let iconName: String
    let title: String
    var subtitle: String? = nil
    /// Status / value on the trailing edge (Settings). Takes priority over the icon when set.
    var trailingText: String? = nil
    var trailingSystemName: String? = "chevron.right"
    var action: (() -> Void)? = nil

    var body: some View {
        Group {
            if let action {
                Button(action: action) { row }
                    .buttonStyle(.plain)
            } else {
                row
                    .accessibilityElement(children: .combine)
            }
        }
    }

    private var row: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: iconName)
                .frame(width: 48)
                .foregroundStyle(theme.secondaryText)
            HaTitleSubtitle(title: title, subtitle: subtitle)
            Spacer(minLength: 0)
            if let trailingText {
                Text(trailingText)
                    .font(.subheadline)
                    .foregroundStyle(theme.secondaryText)
                    .multilineTextAlignment(.trailing)
            } else if let trailingSystemName {
                Image(systemName: trailingSystemName)
                    .font(.footnote)
                    .foregroundStyle(theme.secondaryText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        // Plain buttons only hit opaque glyphs; Spacer / padding need an explicit shape.
        .contentShape(Rectangle())
    }
}
