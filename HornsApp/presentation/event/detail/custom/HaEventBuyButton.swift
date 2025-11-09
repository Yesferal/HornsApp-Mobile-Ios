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
    
    var body: some View {
        HStack(alignment: .center) {
            HStack(alignment: .center) {
                Image(systemName: iconName)
                    .frame(width: 48)
                    .foregroundColor(Color.gray)
                HaTittleSubTittle(title: title, subtitle: subtitle)
            }
            Spacer()
            if let buttonText = actionText {
                Button(buttonText, action: action)
                    .padding()
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .background(buttonEnabled ? Color.red : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .disabled(!buttonEnabled)
            }
        }
        
    }
}
