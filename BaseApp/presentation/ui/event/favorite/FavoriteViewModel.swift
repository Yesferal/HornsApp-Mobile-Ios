//
//  FavoriteViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/31/26.
//

import HornsAppCore

@MainActor
final class FavoriteViewModel: ObservableObject {
    @Published var state: ViewState<[ViewItem]> = .idle

    private let getFavoriteConcertsUseCase: GetFavoriteConcertsUseCase

    init(getFavoriteConcertsUseCase: GetFavoriteConcertsUseCase) {
        self.getFavoriteConcertsUseCase = getFavoriteConcertsUseCase
    }

    func fetchData() async {
        state = .loading

        do {
            let events = try await getFavoriteConcertsUseCase.invoke()
            let views = events.map { ViewItem(id: UUID(), data: .upcoming(concert: $0)) }
            state = .success(views)
        } catch {
            showErrorMessage()
        }
    }

    func update() async {
        await fetchData()
    }

    func retryFetchData() async {
        state = .idle
        await fetchData()
    }

    private func showErrorMessage() {
        state = .failed(
            HaLocalizedStringWrapper.getString(key: "error_message_no_concert"),
            "wifi.slash",
            HaLocalizedStringWrapper.getString(key: "retry")
        )
    }
}
