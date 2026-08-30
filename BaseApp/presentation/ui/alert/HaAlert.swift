//
//  HaAlert.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/13/26.
//

enum HaAlert: Identifiable {
    case eventAdded
    case calendarAccessDenied
    case favoriteUpdateFailed

    var id: Self { self }

    var title: String {
        switch self {
        case .eventAdded:
            return "key_event_added"
        case .calendarAccessDenied:
            return "key_calendar_access_denied"
        case .favoriteUpdateFailed:
            return "key_favorite_update_failed"
        }
    }

    var message: String {
        switch self {
        case .eventAdded:
            return "key_event_added_message"
        case .calendarAccessDenied:
            return "key_calendar_access_denied_message"
        case .favoriteUpdateFailed:
            return "key_favorite_update_failed_message"
        }
    }
}
