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
        // Immersive home (carousel). Nav bar visibility is owned by HomeView for phone tabs.
        ScreenRenderListView(
            getHomeRenderUseCase: dependencies.makeGetHomeRenderUseCase(),
            getConcertsUseCase: dependencies.makeGetConcertsUseCase(context: context)
        )
        .background(theme.background)
    }
}
