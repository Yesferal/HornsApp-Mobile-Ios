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
    var about: GetText?
    var dateTime: String?
    var totalDays: Int?
    var headliner: EventComponent?
    var ticketing: EventComponent?
    var links: [GetViewRender]?
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
    
    func mapToConcert() -> Concert {
        let isFavorite = false
        let links = links?.map { link in
            link.mapToViewRender()
        }
        
        return Concert.Builder(id: _id)
            .addName(name: name)
            .addAbout(about: about?.asLocalizedString().text)
            .addTimeInMillis(timeInMillis: dateTime.asFormatDate().asKotlinTimeInMillis())
            .addTotalDays(totalDays: totalDays.toKotlinInt())
            .addHeadlinerName(headlinerName: headliner?.name)
            .addHeadlinerImageUrl(headlinerImageUrl: headliner?.url)
            .addTicketingName(ticketingName: ticketing?.name)
            .addTicketingUrl(ticketingUrl: ticketing?.url)
            .addLinks(links: links)
            .addCategories(addCategories: categories)
            // TODO: Fill the commented attributes
            //.addVenue(venue: venue?.mapToVenue())
            //.addState(state: state?.mapToState())
            //.addActivities(activities: activities?.map { it.mapToBand() })
            .isFavorite(isFavorite: isFavorite)
            // TODO: Impl the LineUp feature
            //.addLineup(lineup: lineup?.mapToLineup())
            .build()
    }
}
