//
//  UpcomingViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/30/25.
//

import Foundation
import HornsAppCore

@MainActor
final class UpcomingViewModel: ObservableObject {
    @Published var state: ViewState<[ViewItem]> = .idle
    @Published var categories: [CategoryRender] = []
    @Published var searchText: String = ""

    private let getUpcomingConcertsUseCase: GetUpcomingConcertsUseCase
    private let renderRepository: RenderRepository
    /// Last category fetch; search filters this client-side.
    private var categoryItems: [ViewItem] = []

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
                categoryItems = events.map { ViewItem(id: UUID(), data: .upcoming(concert: $0)) }
                publishFiltered()
            case .failed:
                categoryItems = []
                showErrorMessage()
            }
        } catch {
            categoryItems = []
            showErrorMessage()
        }
    }

    func applySearch() {
        guard case .success = state else { return }
        publishFiltered()
    }

    func retryFetchData() async {
        state = .idle
        await fetchData()
    }

    private func publishFiltered() {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else {
            state = .success(categoryItems)
            return
        }

        let filtered = categoryItems.filter { item in
            guard case .upcoming(let concert) = item.data else { return false }
            let name = concert.name ?? ""
            let headliner = concert.headlinerName ?? ""
            return name.localizedCaseInsensitiveContains(query)
                || headliner.localizedCaseInsensitiveContains(query)
        }
        state = .success(filtered)
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
