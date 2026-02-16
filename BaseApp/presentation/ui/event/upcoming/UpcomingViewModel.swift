//
//  HomeViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/30/25.
//

import HornsAppCore

@MainActor class UpcomingViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var data: [ViewItem] = []
    @Published var categories: [CategoryRender] = []

    var getUpcomingConcertsUseCase: GetUpcomingConcertsUseCase?
    var renderRepository: RenderRepository?
    
    func configure(getUpcomingConcertsUseCase: GetUpcomingConcertsUseCase, renderRepository: RenderRepository) {
        self.getUpcomingConcertsUseCase = getUpcomingConcertsUseCase
        self.renderRepository = renderRepository
    }
    
    func fetchData() async {
        isLoading = true
        defer { isLoading = false }
        
        await filterByCategory(categoryCondition: CategoryRender.Companion().ALL)
    }
        
    func filterByCategory(categoryCondition: String) async {
        do {
            guard let haResult = try await getUpcomingConcertsUseCase?.invoke(categoryKey: categoryCondition) else {
                return
            }
            let renderCategories = try await renderRepository?.getCategoryRender()
            let uiResult: UiResult<[Concert]> = mapCoreResultAsUiResult(haResult)
            
            switch uiResult {
            case .success(let events):
                var views: [ViewItem] = []
                events.forEach { e in
                    views.append(ViewItem(id: UUID(), data: .upcoming(concert: e)))
                }
                data = views
                categories = renderCategories ?? []
                return
            case .failed:
                // TODO: Logger
                return
            }
        } catch {
            // TODO: Logger
        }
    }
}
