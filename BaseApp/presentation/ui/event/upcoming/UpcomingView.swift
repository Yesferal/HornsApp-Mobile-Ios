//
//  HomeView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/25/25.
//

import SwiftUI
import HornsAppCore

struct UpcomingView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dependencies) var dependencies
    
    @Environment(\.theme) var theme

    var body: some View {
        UpcomingList(
            getUpcomingConcertsUseCase: dependencies.makeGetUpcomingConcertsUseCase(context: context),
            renderRepository: dependencies.getRenderRepository()
        )
            .navigationTitle(LocalizedStringKey("upcoming"))
            .background(theme.background)
        
    }
}
