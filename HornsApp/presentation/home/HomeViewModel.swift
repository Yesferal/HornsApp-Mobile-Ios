//
//  HomeViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/30/25.
//

@MainActor class HomeViewModel: ObservableObject {
    @Published var data: [EventModel] = []
    
    func fetchData() async {
        do {
            let events: HaResult<[GetEvents]> = try await AlamoFireWrapper().makeRequest(path: "concert")
            
            switch events {
            case .success(let events):
                data = EventModel.fromApi(events: events)
                return
            case .failed:
                return
            }
        } catch {
            
        }
    }
}
