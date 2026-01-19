//
//  EventItem.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/22/25.
//

import SwiftUI

struct HaEventLink: View {
   
    @Environment(\.theme) var theme

    let iconName: String
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center) {
                Image(systemName: iconName)
                    .frame(width: 48)
                    .foregroundColor(theme.secondaryText)
                HaTittleSubTittle(title: title, subtitle: subtitle)
                    .frame(maxHeight: .infinity, alignment: .center)
                Spacer()
                Image(systemName: "chevron.right")
                    .frame(maxHeight: .infinity, alignment: .center)
                    .foregroundColor(theme.secondaryText)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .buttonStyle(.plain)
    }
}
