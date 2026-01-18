//
//  GetFilterRender.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/16/26.
//

import HornsAppCore

class GetFilterRender: Decodable {
    let events: [String]?
    let categories: [String]?
    
    func mapToFilterRender() -> FilterRender {
        return FilterRender(events: events, categories: categories)
    }
}
