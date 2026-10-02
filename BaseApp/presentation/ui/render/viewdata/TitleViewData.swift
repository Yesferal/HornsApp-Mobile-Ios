//
//  TitleViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/21/26.
//

import SwiftUI

struct TitleViewData: View {
    let title: String
    let subtitle: String?
    let route: Route?
    
    @Environment(\.theme) var theme
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        Button {
            guard let route = route else {
                return
            }
            router.navigate(to: route)
        } label: {
            VStack(alignment: .leading, spacing: Dimens.small) {
                HStack {
                    Image(systemName: "music.note")
                        .frame(width: Dimens.large)
                        .foregroundColor(theme.primaryText)

                    Text(title)
                        .foregroundColor(theme.primaryText)
                        .font(.title2)
                        .bold()

                    Spacer(minLength: 0)
                    Image(systemName: "chevron.right")
                        .foregroundColor(theme.secondaryText)
                }

                if let text = subtitle {
                    HStack {
                        Color.clear
                            .frame(width: Dimens.large)
                        Text(text)
                            .font(.subheadline)
                            .foregroundColor(theme.secondaryText)
                        Spacer(minLength: 0)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .padding(.horizontal)
        .buttonStyle(.plain)
    }
}
