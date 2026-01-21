//
//  CtaViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/20/26.
//

import SwiftUI

struct CtaViewData: View {
    let actionText: String?
    let buttonEnabled: Bool
    let action: () -> Void
    
    @Environment(\.theme) var theme

    var body: some View {
        if let buttonText = actionText {
            Button(buttonText, action: action)
                .padding()
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .background(buttonEnabled ? theme.accent : theme.secondaryText)
                .foregroundColor(.white)
                .cornerRadius(32)
                .disabled(!buttonEnabled)
        }
    }
}
