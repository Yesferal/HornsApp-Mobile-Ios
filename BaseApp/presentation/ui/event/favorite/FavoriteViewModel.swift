//
//  FAvoriteViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/31/26.
//

import HornsAppCore

@MainActor class FavoriteViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var data: [ViewItem] = []
    
    var getFavoriteConcertsUseCase: GetFavoriteConcertsUseCase?
    
    func configure(getFavoriteConcertsUseCase: GetFavoriteConcertsUseCase) {
        self.getFavoriteConcertsUseCase = getFavoriteConcertsUseCase
    }
    
    func fetchData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            guard let events = try await getFavoriteConcertsUseCase?.invoke() else {
                return
            }
            
            var views: [ViewItem] = []
            events.forEach { e in
                views.append(ViewItem(id: UUID(), data: .upcoming(concert: e)))
            }
            data = views
        } catch {
            // TODO: Logger
        }
    }
}

