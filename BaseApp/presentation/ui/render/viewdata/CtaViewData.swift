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
    let route: Route?
    
    @Environment(\.theme) var theme
    
    @EnvironmentObject var router: Router
    
    init(actionText: String?, backgroundColor: Color? = nil, foregroundColor: Color = .white, route: Route? = nil) {
        self.actionText = actionText
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.route = route
    }

    var body: some View {
        if let buttonText = actionText {
            let enabledColor = backgroundColor ?? theme.accent
            Button(buttonText) {
                guard let route = route else {
                    return
                }
                router.navigate(to: route)
            }
            .padding(.horizontal, Dimens.large)
            .padding(.vertical, Dimens.medium)
            .fontWeight(.bold)
            .background(buttonEnabled() ? enabledColor : theme.secondaryText)
            .foregroundColor(foregroundColor)
            .cornerRadius(32)
            .disabled(!buttonEnabled())
        }
    }
    
    private func buttonEnabled() -> Bool {
        return route != nil
    }
}
