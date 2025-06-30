//
//  EventModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/28/25.
//

struct EventModel: Identifiable {
    var id: UUID
    var name: String?
    var dateTime: String?
    var headlinerUrl: String?
    var headlinerName: String?
    
    static func fromApi(events: [GetEvents]) -> [EventModel] {
        return events.map {
            EventModel(id: UUID.init(uuidString: $0._id) ?? UUID(), name: $0.name, dateTime: $0.dateTime, headlinerUrl: $0.headliner?.url, headlinerName: $0.headliner?.name)
        }
    }
}
