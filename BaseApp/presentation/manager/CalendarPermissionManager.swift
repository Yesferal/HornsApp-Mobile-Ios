//
//  CalendarPermission.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/6/26.
//

import EventKit
import HornsAppCore

class CalendarPermissionManager {
    let eventStore = EKEventStore()

    func requestAccess() async -> Bool {
        do {
            return try await eventStore.requestWriteOnlyAccessToEvents()
        } catch {
            print("Calendar permission error:", error)
            return false
        }
    }
    
    func saveEventToCalendar(event: Concert?) {
        guard let startDate = event?.kotlinTimeInMillisToDate(),
              let endDate = Calendar.current.date(byAdding: .hour, value: 2, to: startDate),
              let calendar = eventStore.defaultCalendarForNewEvents
        else { return }
        
        let ekEvent = EKEvent(eventStore: eventStore)
        ekEvent.title = event?.name
        ekEvent.startDate = startDate
        ekEvent.endDate = endDate
        ekEvent.calendar = calendar
        
        try? eventStore.save(ekEvent, span: .thisEvent)
    }
}
