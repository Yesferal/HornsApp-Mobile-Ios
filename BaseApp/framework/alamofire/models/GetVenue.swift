//
//  GetVenue.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/26/25.
//

struct GetVenue: Decodable {
    var latitude: Double?
    var longitude: Double?
    var name: GetText?
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case name
    }
}
