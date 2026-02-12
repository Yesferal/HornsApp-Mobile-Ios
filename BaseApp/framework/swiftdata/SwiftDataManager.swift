//
//  SwiftDataManager.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/27/26.
//

import SwiftData
import HornsAppCore

// TODO: Implement Chached Local Storage
@MainActor
class SwiftDataManager: ConcertStorageDataSource {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func getConcertCached() -> [Concert]? {
        return nil
    }
    
    func getFavoriteConcerts() async throws -> [Concert] {
        return try context.fetch(FetchDescriptor<SwiftDataConcert>())
            .map { c in
                c.mapToConcert()
            }
    }
    
    func insertFavoriteConcert(concert: Concert) async throws {
        context.insert(SwiftDataConcert(id: concert.id, name: concert.name, headlinerName: concert.headlinerName, headlinerImageUrl: concert.headlinerImageUrl, timeInMillis: concert.timeInMillis?.int64Value))
    }
    
    func removeFavoriteConcert(concert: Concert) async throws {
        
        let concertId = concert.id
        let results = try context.fetch(FetchDescriptor<SwiftDataConcert>(
            predicate: #Predicate { $0.id == concertId }
        ))
        
        guard let storedConcert = results.first else {
            print("Yesferal: Concert not found in SwiftData")
            return
        }
        
        context.delete(storedConcert)
    }
    
    func updateConcertCached(concerts: [Concert]?) {
        
    }
}
