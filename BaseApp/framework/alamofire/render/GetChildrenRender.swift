//
//  GetChildrenRender.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/16/26.
//

import HornsAppCore

class GetChildrenRender: Decodable {
    let key: String?
    let filter: GetFilterRender?
    let sort: [String]?
    let take: Int?
    
    func mapToChildrenRender() -> ChildrenRender {
        return ChildrenRender(key: key, filter: filter?.mapToFilterRender(), sort: sort, take: take.toKotlinInt())
    }
}
