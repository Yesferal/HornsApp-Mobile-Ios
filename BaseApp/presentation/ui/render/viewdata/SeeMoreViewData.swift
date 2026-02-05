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
    let route: Route?

    @EnvironmentObject var router: Router

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
                    .font(.system(size: Dimens.xlarge * 2))
            }
            CtaViewData(actionText: actionText, backgroundColor: Color.init(hex: buttonBackgroundColor), foregroundColor: Color.init(hex: buttonForegroundColor), action: route?.asAction(router: router))
                .padding(.vertical, Dimens.small)
        }
        .padding()
        .background(Color.init(hex: backgroundColor))
    }
}
