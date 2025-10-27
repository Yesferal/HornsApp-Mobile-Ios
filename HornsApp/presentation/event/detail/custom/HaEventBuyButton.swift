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
    let subtitle: String
    let actionText: String
    let action: () -> Void

    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Image(systemName: iconName)
                    .frame(width: 48)
                HaVerticalDashLine()
            }

            HaTittleSubTittle(title: title, subtitle: subtitle)
            Spacer()
            Button(action: action) {
                Text(title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
        }
        
    }
}
