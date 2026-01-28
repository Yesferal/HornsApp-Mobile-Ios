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
    
    var getConcertUseCase: GetConcertUseCase
    
    init(getConcertUseCase: GetConcertUseCase) {
        self.getConcertUseCase = getConcertUseCase
    }
    
    func fetchData(id: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let haResult = try await getConcertUseCase.invoke(id: id)
            let uiResult: UiResult<Concert> = mapCoreResultAsUiResult(haResult)
            
            switch uiResult {
            case .success(let event):
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
}
