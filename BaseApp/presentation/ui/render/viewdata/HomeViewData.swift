//
//  HomeViewData.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/22/26.
//

import SwiftUI

struct HomeViewData: View {
    let title: String
    let subtitle: String?
    let imageUrl: String
    let route: Route?
    
    @Environment(\.theme) var theme
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        Button {
            guard let route = route else {
                return
            }
            router.navigate(to: route)
        } label: {
            VStack {
                TitleViewData(title: title, subtitle: subtitle, route: route)
                ImageViewData(url: imageUrl)
                    .clipShape(.rect(cornerRadius: 24))
                    .padding()
            }
        }
    }
}
