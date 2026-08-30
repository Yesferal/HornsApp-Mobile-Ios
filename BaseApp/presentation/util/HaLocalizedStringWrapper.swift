//
//  HaLocalizedStringWrapper.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/9/25.
//

import Foundation

class HaLocalizedStringWrapper {

    /// Use in ViewModels and non-SwiftUI code. In SwiftUI views, prefer `LocalizedStringKey` or `Text(LocalizedStringKey(...))`.
    static func getString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
