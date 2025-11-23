//
//  HaLocalizedString.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/9/25.
//

import Foundation

class HaLocalizedStringWrapper {
    
    static func getString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
