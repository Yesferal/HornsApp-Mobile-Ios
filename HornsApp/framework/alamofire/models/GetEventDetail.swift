//
//  GetEventDetailed.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/8/25.
//

import Foundation
import HornsAppCore

struct GetEventDetail: Decodable {
    var _id: String
    var name: String?
    var dateTime: String?
    var totalDays: Int?
    var headliner: EventComponent?
    var ticketing: EventComponent?
    var categories: [String]?
    var venue: GetVenue?
    var state: GetState?
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
        case venue
        case state
        case activities
        case lineup
    }
}
