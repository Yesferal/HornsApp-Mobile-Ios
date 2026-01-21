//
//  TicketButton.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/25/25.
//

import SwiftUI

struct HaEventBuyButton: View {
    let iconName: String
    let title: String
    let subtitle: String?
    let actionText: String?
    let buttonEnabled: Bool
    let action: () -> Void
    
    @Environment(\.theme) var theme
    
    var body: some View {
        HStack(alignment: .center) {
            HStack(alignment: .center) {
                Image(systemName: iconName)
                    .frame(width: 48)
                    .foregroundColor(theme.secondaryText)
                HaTittleSubTittle(title: title, subtitle: subtitle)
            }
            Spacer()
            CtaViewData(actionText: actionText, buttonEnabled: buttonEnabled, action: action)
        }
        
    }
}
