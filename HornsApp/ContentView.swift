//
//  ContentView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/18/25.
//

import SwiftUI
import HornsAppCore

struct ContentView: View {
    var text = LocalizedString(en: "English!", es: "Español!").text ?? "Fake text"
    
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        Text("HornsAppCore: Version: " + HornsAppCoreVersion().version)
            .padding()
        Text("Text: " + text)
            .padding()
        EventList()
    }
}

#Preview {
    ContentView()
}
