//
//  SwiftDataManager.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/27/26.
//

import HornsAppCore

// TODO: Implement Local Storage and Favorite feature
class SwiftDataManager: ConcertStorageDataSource {
    func getConcertCached() -> [Concert]? {
        return nil
    }
    
    func getFavoriteConcerts() async throws -> [Concert] {
        return []
    }
    
    func insertFavoriteConcert(concert: Concert) async throws {
        
    }
    func removeFavoriteConcert(concert: Concert) async throws {
        
    }
    
    func updateConcertCached(concerts: [Concert]?) {
        
    }
    
    
}
