//
//  TittleSubTittle.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/25/25.
//

import SwiftUI

struct HaTittleSubTittle: View {
    @Environment(\.theme) var theme

    let title: String
    let subtitle: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(theme.primaryText)
                .font(.headline)
                .bold()
            
            if let text = subtitle {
                Text(text)
                    .font(.subheadline)
                    .foregroundColor(theme.secondaryText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

