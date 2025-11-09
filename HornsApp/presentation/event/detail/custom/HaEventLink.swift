//
//  EventItem.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/22/25.
//

import SwiftUI

struct HaEventLink: View {
    let iconName: String
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center) {
                Image(systemName: iconName)
                    .frame(width: 48)
                    .foregroundColor(Color.gray)
                HaTittleSubTittle(title: title, subtitle: subtitle)
                    .frame(maxHeight: .infinity, alignment: .center)
                Spacer()
                Image(systemName: "chevron.right")
                    .frame(maxHeight: .infinity, alignment: .center)
                    .foregroundColor(.gray)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .buttonStyle(.plain)
    }
}
