//
//  HomeView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/25/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    @Environment(\.theme) var theme

    var body: some View {
        EventList()
            .navigationTitle(LocalizedStringKey("home"))
            .background(theme.background)
        
    }
}
