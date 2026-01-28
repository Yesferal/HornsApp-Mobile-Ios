//
//  ConcertExt.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/27/26.
//

import HornsAppCore

extension Concert {
    func getEventYear() -> String {
        if let formatted = formatDateAsString(kotlinMillisToDate(timeInMillis), to: "yyyy") {
            return formatted
        } else {
            return ""
        }
    }
    
    func getEventMonth() -> String {
        if let formatted = formatDateAsString(kotlinMillisToDate(timeInMillis), to: "MMM") {
            return formatted.uppercased()
        } else {
            return ""
        }
    }
    
    func getEventDay() -> String {
        if let formatted = formatDateAsString(kotlinMillisToDate(timeInMillis), to: "dd") {
            return formatted
        } else {
            return ""
        }
    }
    
    func getEventAsCalendarLabel() -> String {
        if let formatted = formatDateAsString(kotlinMillisToDate(timeInMillis), to: "EEE dd, MMMM YYYY") {
            return formatted
        } else {
            return ""
        }
    }
    
    func getEventTime() -> String {
        if let formatted = formatDateAsString(kotlinMillisToDate(timeInMillis), to: "HH:mm a") {
            return formatted.uppercased()
        } else {
            return ""
        }
    }
    
    private func kotlinMillisToDate(_ millis: KotlinLong?) -> Date? {
        guard let millis else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(millis.int64Value) / 1000)
    }
    
    private func formatDateAsString(_ input: Date?,
                                    to outputFormat: String) -> String? {
        guard let input = input else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.dateFormat = outputFormat
        
        return formatter.string(from: input)
    }
}
