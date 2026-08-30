//
//  UpcomingViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/30/25.
//

import HornsAppCore

@MainActor
final class UpcomingViewModel: ObservableObject {
    @Published var state: ViewState<[ViewItem]> = .idle
    @Published var categories: [CategoryRender] = []

    private let getUpcomingConcertsUseCase: GetUpcomingConcertsUseCase
    private let renderRepository: RenderRepository

    init(getUpcomingConcertsUseCase: GetUpcomingConcertsUseCase, renderRepository: RenderRepository) {
        self.getUpcomingConcertsUseCase = getUpcomingConcertsUseCase
        self.renderRepository = renderRepository
    }

    func fetchData() async {
        await loadCategoriesIfNeeded()
        await filterByCategory(categoryCondition: CategoryRender.Companion().ALL)
    }

    func filterByCategory(categoryCondition: String) async {
        state = .loading

        do {
            let haResult = try await getUpcomingConcertsUseCase.invoke(categoryKey: categoryCondition)
            let uiResult: UiResult<[Concert]> = mapCoreResultAsUiResult(haResult)

            switch uiResult {
            case .success(let events):
                let views = events.map { ViewItem(id: UUID(), data: .upcoming(concert: $0)) }
                state = .success(views)
            case .failed:
                showErrorMessage()
            }
        } catch {
            showErrorMessage()
        }
    }

    func retryFetchData() async {
        state = .idle
        await fetchData()
    }

    private func loadCategoriesIfNeeded() async {
        guard categories.isEmpty else { return }
        categories = (try? await renderRepository.getCategoryRender()) ?? []
    }

    private func showErrorMessage() {
        state = .failed(
            HaLocalizedStringWrapper.getString(key: "error_message_no_concert"),
            "wifi.slash",
            HaLocalizedStringWrapper.getString(key: "retry")
        )
    }
}
