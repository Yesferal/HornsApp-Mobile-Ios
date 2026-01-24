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
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    Text(title)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(subtitle)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Image(systemName: icon)
                    .foregroundStyle(.white)
                    .font(.system(size: CGFloat(Dimens.Space.xlarge * 2)))
            }
            CtaViewData(actionText: actionText, buttonEnabled: true, backgroundColor: Color.init(hex: buttonBackgroundColor), foregroundColor: Color.init(hex: buttonForegroundColor), action: action)
                .padding(.vertical, CGFloat(Dimens.Space.small))
        }
        .padding()
        .background(Color.init(hex: backgroundColor))
    }
}
