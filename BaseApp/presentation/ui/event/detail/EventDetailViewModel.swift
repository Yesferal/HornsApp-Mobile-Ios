//
//  EventDetailViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/12/25.
//

import HornsAppCore

@MainActor class EventDetailViewModel: ObservableObject {
    @Published var state: ViewState<Concert> = .idle
    @Published var isFavorite: Bool = false
    
    var getConcertUseCase: GetConcertUseCase?
    var updateFavoriteConcertUseCase: UpdateFavoriteConcertUseCase?
    
    func configure(getConcertUseCase: GetConcertUseCase, updateFavoriteConcertUseCase: UpdateFavoriteConcertUseCase) {
        self.getConcertUseCase = getConcertUseCase
        self.updateFavoriteConcertUseCase = updateFavoriteConcertUseCase
    }
    
    func fetchData(id: String) async {
        state = .loading
        
        do {
            guard let getConcertUseCase else {
                showErrorMessage()
                return
            }
            
            let haResult = try await getConcertUseCase.invoke(id: id)
            let uiResult: UiResult<Concert> = mapCoreResultAsUiResult(haResult)
            
            switch uiResult {
            case .success(let event):
                isFavorite = event.isFavorite
                state = .success(event)
            case .failed:
                showErrorMessage()
            }
        } catch {
            showErrorMessage()
        }
    }
    
    func retryFetchData(id: String) async {
        state = .idle
        await fetchData(id: id)
    }
    
    func showErrorMessage() {
        state = .failed(
            HaLocalizedStringWrapper.getString(key: "error_message_no_concert"),
            "wifi.slash",
            HaLocalizedStringWrapper.getString(key: "retry")
        )
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
