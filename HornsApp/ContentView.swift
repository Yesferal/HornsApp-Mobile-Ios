//
//  ContentView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/18/25.
//

import SwiftUI
import HornsAppCore
import Alamofire

struct ContentView: View {
    var text = LocalizedString(en: "English!", es: "Español!").text ?? "Fake text"
    var language: String = Locator().language()
    let locale = NSLocale.autoupdatingCurrent.language.languageCode?.identifier ?? "Fake text"
    
    var request = AF.request("", headers: ["": ""])
                        .responseDecodable(of: [GetEvents].self) { response in
                            switch response.result {
                                case .success(let events):
                                    print(events.map() { events in events.name ?? ""}.joined(separator: "; "))

                                case .failure(let error):
                                    print(error)
                                }
                    }

    let result = hapk_wrapper().iosHornsAppApiBaseUrl("Muvin")
    
    var body: some View {
        Text("HornsAppCore: Version: " + HornsAppCoreVersion().version)
            .padding()
        Text("Localization: KMP-Core: " + language)
            .padding()
        Text("Localization: iOS: " + locale)
            .padding()
        Text("Text: " + text)
            .padding()
        Text("Obj-C Result is : \(String(describing: result))")
    }
}

#Preview {
    ContentView()
}
