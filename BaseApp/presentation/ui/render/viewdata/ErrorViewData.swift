//
//  ErrorViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/3/26.
//

import SwiftUI

struct ErrorViewData: View {
    let message: String
    let icon: String
    let actionText: String?
    let action: (() -> Void)?

    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundStyle(.white)
                .font(.system(size: Dimens.xlarge * 2))
            Text(message)
                .padding(Dimens.medium)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            if action != nil {
                CtaViewData(actionText: actionText, action: action)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
