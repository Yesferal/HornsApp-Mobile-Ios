//
//  EventDetailViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/12/25.
//

import HornsAppCore

@MainActor class EventDetailViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var data: Concert? = nil
    @Published var isFavorite: Bool = false
    
    var getConcertUseCase: GetConcertUseCase?
    var updateFavoriteConcertUseCase: UpdateFavoriteConcertUseCase?
    
    func configure(getConcertUseCase: GetConcertUseCase, updateFavoriteConcertUseCase: UpdateFavoriteConcertUseCase) {
        self.getConcertUseCase = getConcertUseCase
        self.updateFavoriteConcertUseCase = updateFavoriteConcertUseCase
    }
    
    func fetchData(id: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            guard let haResult = try await getConcertUseCase?.invoke(id: id) else {
                return
            }
            let uiResult: UiResult<Concert> = mapCoreResultAsUiResult(haResult)
            
            switch uiResult {
            case .success(let event):
                isFavorite = event.isFavorite
                data = event
                return
            case .failed:
                // TODO: Logger
                return
            }
        } catch {
            // TODO: Logger
        }
    }
    
    func onFavoriteImageViewClick(concert: Concert?) async {
        do {
            guard let concert = concert else {
                return
            }
            isFavorite.toggle()

            try await updateFavoriteConcertUseCase?.invoke(concert: concert, isFavorite: isFavorite)
        } catch {
            // TODO: Logger
        }
    }
}
