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
    
    func mapToConcert() -> Concert {
        let isFavorite = false
        let links = links?.map { link in
            link.mapToViewRender()
        }
        
        let activities = activities?.map {
            $0.mapToActivity()
        }
        
        return Concert.Builder(id: _id)
            .addName(name: name)
            .addAbout(about: about?.asLocalizedString().text)
            .addTimeInMillis(timeInMillis: dateTime.asFormatDate()?.asKotlinTimeInMillis())
            .addTotalDays(totalDays: totalDays.toKotlinInt())
            .addHeadlinerName(headlinerName: headliner?.name)
            .addHeadlinerImageUrl(headlinerImageUrl: headliner?.url)
            .addTicketingName(ticketingName: ticketing?.name)
            .addTicketingUrl(ticketingUrl: ticketing?.url)
            .addLinks(links: links)
            .addCategories(addCategories: categories)
            .addVenue(venue: venue?.mapToVenue())
            // TODO: Fill the commented attributes
            //.addState(state: state?.mapToState())
            .addActivities(activities: activities)
            .isFavorite(isFavorite: isFavorite)
            // TODO: Impl the LineUp feature
            //.addLineup(lineup: lineup?.mapToLineup())
            .build()
    }
}
