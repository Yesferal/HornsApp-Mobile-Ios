//
//  ScreenRenderViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import HornsAppCore

@MainActor
final class ScreenRenderViewModel: ObservableObject {
    @Published var state: ViewState<[ViewItem]> = .idle

    private let getHomeRenderUseCase: GetHomeRenderUseCase
    private let getConcertsUseCase: GetConcertsUseCase
    private let mapper: ScreenRenderMapper

    init(
        getHomeRenderUseCase: GetHomeRenderUseCase,
        getConcertsUseCase: GetConcertsUseCase,
        mapper: ScreenRenderMapper = ScreenRenderMapper()
    ) {
        self.getHomeRenderUseCase = getHomeRenderUseCase
        self.getConcertsUseCase = getConcertsUseCase
        self.mapper = mapper
    }

    func fetchData() async {
        guard case .idle = state else { return }

        state = .loading

        guard let screenRender: [ScreenRender]? = try? await getHomeRenderUseCase.invoke() else {
            showErrorMessage()
            return
        }

        do {
            let haResult = try await getConcertsUseCase.invoke()
            let uiResult: UiResult<[Concert]> = mapCoreResultAsUiResult(haResult)

            switch uiResult {
            case .success(let events):
                let views = mapper.map(views: screenRender?[0].views, events: events)
                state = .success(views)
            case .failed:
                showErrorMessage()
            }
        } catch {
            showErrorMessage()
        }
    }

    func showErrorMessage() {
        state = .failed(
            HaLocalizedStringWrapper.getString(key: "error_message_no_concert"),
            "wifi.slash",
            HaLocalizedStringWrapper.getString(key: "retry")
        )
    }

    func retryFetchData() async {
        state = .idle
        await fetchData()
    }
}
