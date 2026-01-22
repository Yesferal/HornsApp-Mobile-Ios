//
//  ImageViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/22/26.
//

import SwiftUI

struct ImageViewData: View {
    let url: String
    
    @Environment(\.theme) var theme
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            theme.background
        }
        .aspectRatio(1.6, contentMode: .fit)
    }
}
