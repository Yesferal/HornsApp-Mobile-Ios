//
//  EventModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/28/25.
//

import Foundation

struct EventModel: Identifiable {
    var id: UUID
    var name: String?
    var dateTime: Date?
    var headlinerUrl: String?
    var headlinerName: String?
    
    static func fromApi(events: [GetEvents]) -> [EventModel] {
        return events.map {
            EventModel(id: UUID.init(uuidString: $0._id) ?? UUID(), name: $0.name, dateTime: formatStringAsDate($0.dateTime), headlinerUrl: $0.headliner?.url, headlinerName: $0.headliner?.name)
        }
    }
    
    func getEventYear() -> String {
        if let formatted = formatDateAsString(dateTime, to: "yyyy") {
            return formatted
        } else {
            return ""
        }
    }
    
    func getEventMonth() -> String {
        if let formatted = formatDateAsString(dateTime, to: "MMM") {
            return formatted.uppercased()
        } else {
            return ""
        }
    }
    
    func getEventDay() -> String {
        if let formatted = formatDateAsString(dateTime, to: "dd") {
            return formatted
        } else {
            return ""
        }
    }
    
    func getEventTime() -> String {
        if let formatted = formatDateAsString(dateTime, to: "HH:mm a") {
            return formatted.uppercased()
        } else {
            return ""
        }
    }
    
    private static func formatStringAsDate(_ input: String?,
                                    from inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let localeIdentifier = "en_US_POSIX"
        guard let input = input else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: localeIdentifier)
        formatter.dateFormat = inputFormat
        
        guard let date = formatter.date(from: input) else {
            return nil
        }
        
        return date
    }
    
    private func formatDateAsString(_ input: Date?,
                                    to outputFormat: String) -> String? {
        let localeIdentifier = "en_US_POSIX"
        guard let input = input else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: localeIdentifier)
        formatter.dateFormat = outputFormat
        
        return formatter.string(from: input)
    }
}
