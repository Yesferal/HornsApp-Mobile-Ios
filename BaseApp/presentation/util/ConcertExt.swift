//
//  ConcertExt.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/27/26.
//

import HornsAppCore

extension Concert {
    func getEventYear() -> String {
        if let formatted = kotlinTimeInMillisToDate()?.formatDate(to: "yyyy") {
            return formatted
        } else {
            return ""
        }
    }
    
    func getEventMonth() -> String {
        if let formatted = kotlinTimeInMillisToDate()?.formatDate(to: "MMM") {
            return formatted.uppercased()
        } else {
            return ""
        }
    }
    
    func getEventDay() -> String {
        if let formatted = kotlinTimeInMillisToDate()?.formatDate(to: "dd") {
            return formatted
        } else {
            return ""
        }
    }
    
    func getEventAsCalendarLabel() -> String {
        if let formatted = kotlinTimeInMillisToDate()?.formatDate(to: "EEE dd, MMMM YYYY") {
            return formatted
        } else {
            return ""
        }
    }
    
    func getEventTime() -> String {
        if let formatted = kotlinTimeInMillisToDate()?.formatDate(to: "HH:mm a") {
            return formatted.uppercased()
        } else {
            return ""
        }
    }
    
    func kotlinTimeInMillisToDate() -> Date? {
        guard let timeInMillis else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(timeInMillis.int64Value) / 1000)
    }
}
