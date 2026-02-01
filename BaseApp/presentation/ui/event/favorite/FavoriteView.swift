//
//  FavoriteView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/31/26.
//

import SwiftUI
import HornsAppCore

struct FavoriteView: View {
    
    @Environment(\.modelContext) var context

    @Environment(\.theme) var theme

    var body: some View {
        FavoriteListView(context: context)
        // FIXME: Use Localized EN/ES version
            .navigationTitle(LocalizedStringKey("Favorite"))
            .background(theme.background)
        
    }
}
