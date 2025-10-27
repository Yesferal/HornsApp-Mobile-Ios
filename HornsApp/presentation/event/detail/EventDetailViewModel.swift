//
//  EventDetailViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/12/25.
//

@MainActor class EventDetailViewModel: ObservableObject {
    @Published var data: EventModel? = nil
    
    func fetchData(id: String) async {
        do {
            let appName = AppSettings().appName
            let path = "concert/"+id
            print("Yesferal: Request path: " + path)
            let event: HaResult<GetEvents> = try await AlamoFireWrapper(appName: appName).makeRequest(path: path)
            
            switch event {
            case .success(let event):
                data = EventModel.fromApi(event: event)
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
