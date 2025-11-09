//
//  GetText.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/9/25.
//

import HornsAppCore

struct GetText: Decodable {
    var en: String?
    var es: String?
    
    enum CodingKeys: String, CodingKey {
        case en
        case es
    }
    
    func asLocalizedString() -> LocalizedString {
        return LocalizedString(en: en, es: es)
    }
}

