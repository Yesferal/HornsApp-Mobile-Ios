//
//  SeeMoreViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/22/26.
//

import SwiftUI

struct SeeMoreViewData: View {
    let title: String
    let subtitle: String
    let icon: String
    let backgroundColor: String
    let buttonBackgroundColor: String
    let buttonForegroundColor: String
    let actionText: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(title)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Image(systemName: icon)
                    .foregroundStyle(.white)
            }
            CtaViewData(actionText: actionText, buttonEnabled: true, backgroundColor: Color.init(hex: buttonBackgroundColor), foregroundColor: Color.init(hex: buttonForegroundColor), action: action)
        }
        .background(Color.init(hex: backgroundColor))
    }
}
