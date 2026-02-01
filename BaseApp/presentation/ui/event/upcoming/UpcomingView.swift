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

    @Environment(\.theme) var theme

    var body: some View {
        UpcomingList(context: context)
            .navigationTitle(LocalizedStringKey("upcoming"))
            .background(theme.background)
        
    }
}
