//
//  GetText.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/9/25.
//

struct GetText: Decodable {
    var en: String?
    var es: String?
    
    enum CodingKeys: String, CodingKey {
        case en
        case es
    }
}

