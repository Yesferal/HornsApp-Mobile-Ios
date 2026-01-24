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
    let backgroundColor: Color?
    let foregroundColor: Color
    let action: () -> Void
    
    @Environment(\.theme) var theme
    
    init(actionText: String?, buttonEnabled: Bool, backgroundColor: Color? = nil, foregroundColor: Color = .white, action: @escaping () -> Void) {
        self.actionText = actionText
        self.buttonEnabled = buttonEnabled
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.action = action
    }

    var body: some View {
        if let buttonText = actionText {
            let enabledColor = backgroundColor ?? theme.accent
            Button(buttonText, action: action)
                .padding(.horizontal, Dimens.large)
                .padding(.vertical, Dimens.medium)
                .fontWeight(.bold)
                .background(buttonEnabled ? enabledColor : theme.secondaryText)
                .foregroundColor(foregroundColor)
                .cornerRadius(32)
                .disabled(!buttonEnabled)
        }
    }
}
