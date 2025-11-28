//
//  HaProgressView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/28/25.
//

import SwiftUI

struct HaProgressView: View {

    @Environment(\.theme) var theme

    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: theme.accent))
            .controlSize(.regular)
            .padding(12)
            .background(theme.background.opacity(0.7))
            .cornerRadius(12)
    }
}
