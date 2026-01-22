//
//  HomeView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/25/25.
//

import SwiftUI

struct UpcomingView: View {
    
    @StateObject var vm = UpcomingViewModel()
    
    @Environment(\.theme) var theme

    var body: some View {
        UpcomingList()
            .navigationTitle(LocalizedStringKey("home"))
            .background(theme.background)
        
    }
}
