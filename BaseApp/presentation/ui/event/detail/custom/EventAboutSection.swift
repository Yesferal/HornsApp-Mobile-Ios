//
//  EventAboutSection.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 8/30/26.
//

import SwiftUI

struct EventAboutSection: View {
    let about: String

    @Environment(\.theme) var theme

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(LocalizedStringKey("about_section"))
                .font(.headline)
                .foregroundColor(theme.primaryText)
                .textCase(.uppercase)

            Text(about)
                .font(.body)
                .foregroundColor(theme.secondaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.top, 16)
    }
}
