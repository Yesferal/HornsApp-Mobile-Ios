//
//  HaEventDate.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/25/25.
//

import SwiftUI

struct HaEventDate: View {

    @Environment(\.theme) var theme

    let day: String
    let month: String

    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(day)
                .foregroundColor(theme.accent)
            Text(month)
                .foregroundColor(theme.primaryText)
        }
        .bold()
        .background(theme.background)
        .frame(width: 48)
    }
}
