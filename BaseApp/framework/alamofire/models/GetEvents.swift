//
//  GetConcerts.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 5/26/25.
//


import Foundation
import HornsAppCore

struct GetEvents: Decodable {
    var _id: String
    var name: String?
    var dateTime: String?
    var totalDays: Int?
    var headliner: EventComponent?
    var ticketing: EventComponent?
    var categories: [String]?
    var activities: [GetActivities]?
    var lineup: GetLineup?

    enum CodingKeys: String, CodingKey {
        case _id
        case name
        case dateTime
        case totalDays
        case headliner
        case ticketing
        case categories
        case activities
        case lineup
    }
}

struct EventComponent: Decodable {
    var name: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
