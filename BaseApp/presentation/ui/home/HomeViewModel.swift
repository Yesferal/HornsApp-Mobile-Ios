//
//  HomeViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/30/25.
//

@MainActor class HomeViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var data: [EventModel] = []
    
    func fetchData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let appSettings = AppSettings()
            let appName = appSettings.appName
            let events: HaResult<[GetEvents]> = try await AlamoFireWrapper(appName: appName).makeRequest(path: appSettings.homePath)
            
            switch events {
            case .success(let events):
                data = EventModel.fromApi(events: events).sorted { $0.dateTime?.timeIntervalSince1970 ?? 0.0 < $1.dateTime?.timeIntervalSince1970 ?? 0.0 }
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
