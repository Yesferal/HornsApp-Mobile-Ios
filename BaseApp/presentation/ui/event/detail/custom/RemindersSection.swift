//
//  ReminderView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 4/12/26.
//

import SwiftUI
import UserNotifications
import HornsAppCore

struct RemindersSection: View {
    let event: Concert

    @SwiftUI.State private var oneDayBefore = false
    @SwiftUI.State private var twoHoursBefore = false
    @SwiftUI.State private var permissionDenied = false

    @Environment(\.theme) var theme

    let ONE_DAY_BEFORE = "1day"
    let TWO_HOUS_BEFORE = "2hours"

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {

            // Section header
            HStack(spacing: 8) {
                Text("reminder_section")
                    .font(.headline)

                Text("new_label")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
                    .background(theme.accent)
                    .textCase(.uppercase)
                    .cornerRadius(3)
            }
            .padding(.top, 16)

            if permissionDenied {
                Text("reminder_error_message")
                    .font(.subheadline)
            }

            if let oneDayDate: Date = event.kotlinTimeInMillisToDate()?.addingTimeInterval(-86400) {
                ReminderRow(
                    icon: "bell",
                    title: HaLocalizedStringWrapper.getString(key: "key_day_before"),
                    subtitle: oneDayDate.formatDate(to: "dd MMM · h:mm a"),
                    isOn: $oneDayBefore
                )
                .onChange(of: oneDayBefore) { _, newValue in
                    handleToggle(newValue, id: ONE_DAY_BEFORE, triggerDate: oneDayDate)
                }
            }

            if let twoHoursDate = event.kotlinTimeInMillisToDate()?.addingTimeInterval(-7200) {
                ReminderRow(
                    icon: "alarm",
                    title: HaLocalizedStringWrapper.getString(key: "key_hours_before"),
                    subtitle: twoHoursDate.formatDate(to: "dd MMM · h:mm a"),
                    isOn: $twoHoursBefore
                )
                .onChange(of: twoHoursBefore) { _, newValue in
                    handleToggle(newValue, id: TWO_HOUS_BEFORE, triggerDate: twoHoursDate)
                }
            }
        }
    }

    // MARK: - Notification logic
    private func handleToggle(_ enabled: Bool, id: String, triggerDate: Date) {
        if enabled {
            requestPermissionAndSchedule(id: id, triggerDate: triggerDate)
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        }
    }

    private func requestPermissionAndSchedule(id: String, triggerDate: Date) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
                if granted {
                    scheduleNotification(id: id, triggerDate: triggerDate)
                } else {
                    permissionDenied = true
                    // revert toggle
                    if id == ONE_DAY_BEFORE { oneDayBefore = false }
                    if id == TWO_HOUS_BEFORE { twoHoursBefore = false }
                }
            }
        }
    }

    private func scheduleNotification(id: String, triggerDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = event.name ?? ""
        content.body = id == ONE_DAY_BEFORE
        ? String(format: HaLocalizedStringWrapper.getString(key: "key_notification_one_day_before"), event.name ?? "", event.venue?.name ?? "")
        : String(format: HaLocalizedStringWrapper.getString(key: "key_notification_two_hours_before"), event.name ?? "", event.venue?.name ?? "")
        content.sound = .default

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}

// MARK: - Single reminder row
struct ReminderRow: View {
    let icon: String
    let title: String
    let subtitle: String
    @Binding var isOn: Bool

    @Environment(\.theme) var theme

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
                .frame(width: 48)
                .foregroundColor(theme.secondaryText)
            HaTittleSubTittle(title: title, subtitle: subtitle)
                .frame(maxHeight: .infinity, alignment: .center)
            
            Spacer()

            Toggle(isOn: $isOn, label: { })
                .toggleStyle(SwitchToggleStyle(tint: theme.accent))
                .labelsHidden()
                .scaleEffect(0.85)
        }
    }
}
