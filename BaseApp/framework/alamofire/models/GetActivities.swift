//
//  GetActivities.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/26/25.
//

import HornsAppCore

struct GetActivities: Decodable {
    var _id: String
    var name: String?
    var about: GetText?
    var images: GetActivityImages?
    
    func mapToActivity() -> Band {
        return Band(id: _id, name: name, about: about?.asLocalizedString().text, logoImage: images?.logo, membersImage: images?.members, country: nil, formerIn: nil, genres: nil)
    }
}

struct GetActivityImages: Decodable {
    var logo: String?
    var members: String?
}
