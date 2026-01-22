//
//  TitleViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/21/26.
//

import SwiftUI

struct TitleViewData: View {
    let title: String
    let subtitle: String
    
    @Environment(\.theme) var theme
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        Button {
            router.navigate(to: .upcoming)
        } label: {
            HStack(alignment: .center) {
                Image(systemName: "music.note")
                    .frame(width: 48)
                    .foregroundColor(theme.secondaryText)
                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundColor(theme.primaryText)
                        .font(.title2)
                        .bold()
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(theme.secondaryText)
                }
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
