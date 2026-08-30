//
//  EventDetailViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/12/25.
//

import HornsAppCore

@MainActor
final class EventDetailViewModel: ObservableObject {
    @Published var state: ViewState<Concert> = .idle
    @Published var isFavorite: Bool = false
    @Published var favoriteAlert: HaAlert?

    private let getConcertUseCase: GetConcertUseCase
    private let updateFavoriteConcertUseCase: UpdateFavoriteConcertUseCase

    init(getConcertUseCase: GetConcertUseCase, updateFavoriteConcertUseCase: UpdateFavoriteConcertUseCase) {
        self.getConcertUseCase = getConcertUseCase
        self.updateFavoriteConcertUseCase = updateFavoriteConcertUseCase
    }

    func fetchData(id: String) async {
        state = .loading

        do {
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

    func onFavoriteImageViewClick(concert: Concert?) async -> Bool {
        guard let concert else {
            return false
        }

        let previousValue = isFavorite
        isFavorite.toggle()

        do {
            try await updateFavoriteConcertUseCase.invoke(concert: concert, isFavorite: isFavorite)
            return true
        } catch {
            isFavorite = previousValue
            favoriteAlert = .favoriteUpdateFailed
            return false
        }
    }
}
