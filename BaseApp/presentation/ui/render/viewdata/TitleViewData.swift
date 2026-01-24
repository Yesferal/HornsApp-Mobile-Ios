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
    
    @Environment(\.theme) var theme
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        Button {
            router.navigate(to: .upcoming)
        } label: {
            VStack {
                HStack {
                    Image(systemName: "music.note")
                        .frame(width: CGFloat(Dimens.Space.large))
                        .frame(maxHeight: .infinity, alignment: .center)
                        .foregroundColor(theme.primaryText)
                    
                    Text(title)
                        .foregroundColor(theme.primaryText)
                        .font(.title2)
                        .bold()
                        .frame(maxHeight: .infinity, alignment: .center)
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                        .frame(maxHeight: .infinity, alignment: .center)
                        .foregroundColor(theme.secondaryText)
                    
                }
                .fixedSize(horizontal: false, vertical: true)
                
                HStack {
                    if let text = subtitle {
                        Color.clear
                            .frame(width: CGFloat(Dimens.Space.large))
                        Text(text)
                            .font(.subheadline)
                            .foregroundColor(theme.secondaryText)
                    }
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal)
        .buttonStyle(.plain)
    }
}
