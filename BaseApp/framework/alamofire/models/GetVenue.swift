//
//  GetVenue.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/26/25.
//

import HornsAppCore

struct GetVenue: Decodable {
    var name: GetText?
    var _id: String
    var mapSearchName: String?
    var description: String?
    var imageUrl: String?
    var latitude: Double?
    var longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case name
        case _id
        case mapSearchName
        case description
        case imageUrl
        case latitude
        case longitude
    }
    
    func mapToVenue() -> Venue {
        let coreLatitude = latitude.map { String($0) }
        let coreLongitude = longitude.map { String($0) }
        
        return Venue(id: _id, name: name?.asLocalizedString().text, description: description, mapSearchName: mapSearchName, latitude: coreLatitude, longitude: coreLongitude, imageUrl: imageUrl)
    }
}
