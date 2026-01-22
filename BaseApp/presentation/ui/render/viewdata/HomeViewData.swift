//
//  HomeViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/22/26.
//

import SwiftUI

struct HomeViewData: View {
    let title: String
    let subtitle: String
    let imageUrl: String
    
    @Environment(\.theme) var theme
    
    var body: some View {
        VStack {
            TitleViewData(title: title, subtitle: subtitle)
            ImageViewData(url: imageUrl)
                .clipShape(.rect(cornerRadius: 24))
        }
    }
}
