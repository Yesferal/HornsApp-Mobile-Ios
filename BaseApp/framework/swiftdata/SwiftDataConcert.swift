//
//  SwiftDataConcert.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/31/26.
//

import SwiftData
import HornsAppCore

@Model
final class SwiftDataConcert {
    @Attribute(.unique) var id: String
    var name: String?
    var headlinerName: String?
    var headlinerImageUrl: String?
    var timeInMillis: Int64?
    
    init(id: String, name: String?, headlinerName: String?, headlinerImageUrl: String?, timeInMillis: Int64?) {
        self.id = id
        self.name = name
        self.headlinerName = headlinerName
        self.headlinerImageUrl = headlinerImageUrl
        self.timeInMillis = timeInMillis
    }
    
    func mapToConcert() -> Concert {
        let isFavorite = true
        
        return Concert.Builder(id: id)
            .addName(name: name)
            .addHeadlinerName(headlinerName: headlinerName)
            .addHeadlinerImageUrl(headlinerImageUrl: headlinerImageUrl)
            .addTimeInMillis(timeInMillis: timeInMillis.toKotlinLong())
            .isFavorite(isFavorite: isFavorite)
            .build()
    }
}
