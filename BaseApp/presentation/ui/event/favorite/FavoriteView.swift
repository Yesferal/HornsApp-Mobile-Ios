//
//  FavoriteView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/31/26.
//

import SwiftUI
import HornsAppCore

struct FavoriteView: View {
    
    @Environment(\.theme) var theme

    var body: some View {
        FavoriteListView()
            .navigationTitle(LocalizedStringKey("favorite"))
            .background(theme.background)
    }
}
