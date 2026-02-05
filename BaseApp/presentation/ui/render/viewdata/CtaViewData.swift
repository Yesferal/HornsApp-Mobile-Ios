//
//  CtaViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/20/26.
//

import SwiftUI

struct CtaViewData: View {
    let actionText: String?
    let backgroundColor: Color?
    let foregroundColor: Color
    let action: () -> Void
    var isEnabled: Bool
    
    @Environment(\.theme) var theme
        
    init(actionText: String?, backgroundColor: Color? = nil, foregroundColor: Color = .white, action: (() -> Void)? = nil) {
        self.actionText = actionText
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        guard let action = action else {
            self.isEnabled = false
            self.action = {}
            return
        }
        self.isEnabled = true
        self.action = action
    }

    var body: some View {
        if let buttonText = actionText {
            let enabledColor = backgroundColor ?? theme.accent
            Button(buttonText) {
                action()
            }
            .padding(.horizontal, Dimens.large)
            .padding(.vertical, Dimens.medium)
            .fontWeight(.bold)
            .background(isEnabled ? enabledColor : theme.secondaryText)
            .foregroundColor(foregroundColor)
            .cornerRadius(32)
            .disabled(!isEnabled)
        }
    }
}
