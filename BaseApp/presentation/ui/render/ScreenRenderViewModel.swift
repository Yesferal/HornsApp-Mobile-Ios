//
//  ScreenRenderViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import HornsAppCore

@MainActor class ScreenRenderViewModel: ObservableObject {
    @Published var isLoading: Bool
    @Published var data: [ViewItem]
    var getHomeRenderUseCase: GetHomeRenderUseCase
    
    init(isLoading: Bool = false, data: [ViewItem] = [], getHomeRenderUseCase: GetHomeRenderUseCase) {
        self.isLoading = isLoading
        self.data = data
        self.getHomeRenderUseCase = getHomeRenderUseCase
    }
    
    func fetchData() async {
        isLoading = true
        defer { isLoading = false }
        
        let screenRender: [ScreenRender]? = try? await getHomeRenderUseCase.invoke()
        print("Yesferal: ScreenRenderViewModel: ScreenRender: \(screenRender)")
        
        do {
            let appSettings = AppSettings()
            let appName = appSettings.appName
            let events: HaResult<[GetEvents]> = try await AlamoFireWrapper(appName: appName).makeRequest(path: appSettings.homePath)
            
            switch events {
            case .success(let events):
                // TODO: Fill this Array using the correct Render model
                data = [
                    ViewItem(id: UUID(), data: .carousel(eventModel: EventModel.fromApi(events: events)[0])),
                    ViewItem(id: UUID(), data: .divider),
                    ViewItem(id: UUID(), data: .title(title: "Upcoming", subtitle: "#Soon")),
                    ViewItem(id: UUID(), data: .upcoming(eventModel: EventModel.fromApi(events: events)[0])),
                    ViewItem(id: UUID(), data: .upcomingCompact(eventModel: EventModel.fromApi(events: events)[0])),
                    ViewItem(id: UUID(), data: .seeMore(title: "Siguenos en IG", subtitle: "Sabias acerca de nuestro IG? Siguenos y mantente informado.", icon: "camera", backgroundColor: "#651FFF", buttonBackgroundColor: "#FFFFFF", buttonForegroundColor: "#651FFF", actionText: "Ver Mas", action: {
                        
                    })),
                    ViewItem(id: UUID(), data: .home(title: "Upcoming", subtitle: "#Soon", imageUrl: "https://as1.ftcdn.net/v2/jpg/01/42/51/58/1000_F_142515887_xVLCVpdyWDU5ScHTi64iMCEZJioVHqU4.jpg")),
                ]
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
