//
//  ContentView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/18/25.
//

import SwiftUI
import HornsAppCore

struct ContentView: View {
    let showDevInfo = false
    var localized = LocalizedString(en: "English!", es: "Español!").text ?? "Fake text"
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            if (showDevInfo) {
                Text("HornsAppCore: Version: " + HornsAppCoreVersion().version)
                    .padding()
                Text("Localized String: " + localized)
                    .padding()
            }
            EventList()
                .navigationTitle(LocalizedStringKey("home"))
        }
    }
}

#Preview {
    ContentView()
}
