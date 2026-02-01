//
//  ScreenRenderView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import SwiftUI

struct ScreenRenderView: View {
    
    @Environment(\.modelContext) var context

    @Environment(\.theme) var theme

    @StateObject private var router = Router()

    var body: some View {
        ScreenRenderListView(context: context)
        // FIXME: Use Localized String here
            .navigationTitle(LocalizedStringKey("home"))
            .background(theme.background)
    }
}
