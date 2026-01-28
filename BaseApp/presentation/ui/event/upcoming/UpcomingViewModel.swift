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
    
    var getConcertsUseCase: GetConcertsUseCase
    
    init(getConcertsUseCase: GetConcertsUseCase) {
        self.getConcertsUseCase = getConcertsUseCase
    }
        
    func fetchData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let haResult = try await getConcertsUseCase.invoke()
            let uiResult: UiResult<[Concert]> = mapCoreResultAsUiResult(haResult)
            
            switch uiResult {
            case .success(let events):
                var views: [ViewItem] = []
                events.forEach { e in
                    views.append(ViewItem(id: UUID(), data: .upcoming(concert: e)))
                }
                data = views
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
