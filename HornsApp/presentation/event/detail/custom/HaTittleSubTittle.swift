//
//  TittleSubTittle.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/25/25.
//

import SwiftUI

struct HaTittleSubTittle: View {
    let title: String
    let subtitle: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .bold()
            
            if let text = subtitle {
                Text(text)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

