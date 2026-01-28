//
//  HomeView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/25/25.
//

import SwiftUI
import HornsAppCore

struct UpcomingView: View {
    
    @Environment(\.theme) var theme

    var body: some View {
        UpcomingList()
            .navigationTitle(LocalizedStringKey("home"))
            .background(theme.background)
        
    }
}
