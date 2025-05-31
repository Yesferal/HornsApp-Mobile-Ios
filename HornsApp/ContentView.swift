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
    var language: String = Locator().language()
    let locale = NSLocale.autoupdatingCurrent.language.languageCode?.identifier ?? "Fake text"
    
    var body: some View {
        Text("HornsAppCore: Version: " + HornsAppCoreVersion().version)
            .padding()
        Text("Localization: KMP-Core: " + language)
            .padding()
        Text("Localization: iOS: " + locale)
            .padding()
        Text("Text: " + text)
            .padding()
    }
}

#Preview {
    ContentView()
}
