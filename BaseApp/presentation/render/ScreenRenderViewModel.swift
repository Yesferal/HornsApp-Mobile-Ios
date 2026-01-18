//
//  ScreenRenderViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import HornsAppCore

@MainActor class ScreenRenderViewModel: ObservableObject {
    @Published var isLoading: Bool
    @Published var data: [EventModel]
    var getHomeRenderUseCase: GetHomeRenderUseCase
    
    init(isLoading: Bool = false, data: [EventModel] = [], getHomeRenderUseCase: GetHomeRenderUseCase) {
        self.isLoading = isLoading
        self.data = data
        self.getHomeRenderUseCase = getHomeRenderUseCase
    }
    
    func fetchData() async {
        isLoading = true
        defer { isLoading = false }
        
        let screenRender: [ScreenRender]? = try? await getHomeRenderUseCase.invoke()
        print("Yesferal: ScreenRenderViewModel: ScreenRender: \(screenRender)")
    }
}
