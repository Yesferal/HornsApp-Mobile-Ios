//
//  ScreenRenderView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import SwiftUI

struct ScreenRenderView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dependencies) var dependencies
    
    @Environment(\.theme) var theme

    var body: some View {
        ScreenRenderListView(
            getHomeRenderUseCase: dependencies.makeGetHomeRenderUseCase(),
            getConcertsUseCase: dependencies.makeGetConcertsUseCase(context: context)
        )
        // FIXME: Use Localized String here
            .navigationTitle(LocalizedStringKey("home"))
            .background(theme.background)
    }
}
