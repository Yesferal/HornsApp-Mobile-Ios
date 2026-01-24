//
//  HaIconText.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/26/25.
//

import SwiftUI

struct HaIconText: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: CGFloat(Dimens.Space.small)) {
            Image(systemName: icon)
                .foregroundStyle(.white)
            
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
