//
//  SettingsView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/2/26.
//

import EventKit
import SwiftUI
import UserNotifications

/// App Settings / About (`#store-7-settings-about`): version, permissions, Instagram.
struct SettingsView: View {
    @Environment(\.theme) private var theme
    @Environment(\.dependencies) private var dependencies
    @Environment(\.scenePhase) private var scenePhase

    @State private var notificationStatus: UNAuthorizationStatus = .notDetermined
    @State private var calendarStatus: EKAuthorizationStatus = .notDetermined

    var body: some View {
        List {
            aboutSection
            permissionsSection
            instagramSection
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(theme.background)
        .navigationTitle(LocalizedStringKey("settings_title"))
        .navigationBarTitleDisplayMode(.inline)
        .readableContentWidth()
        .onAppear { refreshPermissionStatuses() }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                refreshPermissionStatuses()
            }
        }
    }

    // MARK: - Sections

    private var aboutSection: some View {
        Section {
            settingsRow(
                icon: "info.circle",
                titleKey: "settings_version",
                value: versionLabel
            )
            settingsRow(
                icon: "app.badge",
                titleKey: "settings_app_name",
                value: dependencies.appSettings.appName
            )
        } header: {
            Text(LocalizedStringKey("settings_section_about"))
                .foregroundStyle(theme.secondaryText)
        }
        .listRowBackground(theme.primary)
    }

    private var permissionsSection: some View {
        Section {
            settingsRow(
                icon: "bell",
                titleKey: "settings_notifications_status",
                value: notificationStatusLabel
            )
            settingsRow(
                icon: "calendar",
                titleKey: "settings_calendar_status",
                value: calendarStatusLabel
            )

            HaEventLink(
                iconName: "gear",
                title: HaLocalizedStringWrapper.getString(key: "settings_permissions_open_system"),
                accentIcon: true,
                trailingSystemName: "arrow.up.right",
                action: openSystemSettings
            )
            .accessibilityHint(LocalizedStringKey("settings_permissions_open_system_hint"))
        } header: {
            Text(LocalizedStringKey("settings_section_permissions"))
                .foregroundStyle(theme.secondaryText)
        } footer: {
            Text(LocalizedStringKey("settings_permissions_footer"))
                .foregroundStyle(theme.secondaryText)
        }
        .listRowBackground(theme.primary)
    }

    private var instagramSection: some View {
        Section {
            HaEventLink(
                iconName: "camera",
                title: HaLocalizedStringWrapper.getString(key: "settings_instagram"),
                subtitle: "@\(dependencies.appSettings.instagramHandle)",
                accentIcon: true,
                trailingSystemName: "arrow.up.right",
                action: openInstagram
            )
            .accessibilityLabel(LocalizedStringKey("settings_instagram"))
            .accessibilityValue("@\(dependencies.appSettings.instagramHandle)")
        } header: {
            Text(LocalizedStringKey("settings_section_social"))
                .foregroundStyle(theme.secondaryText)
        } footer: {
            Text(LocalizedStringKey("settings_instagram_footer"))
                .foregroundStyle(theme.secondaryText)
        }
        .listRowBackground(theme.primary)
    }

    // MARK: - Rows

    private func settingsRow(icon: String, titleKey: LocalizedStringKey, value: String) -> some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 28)
                .foregroundStyle(theme.secondaryText)
            Text(titleKey)
                .foregroundStyle(theme.primaryText)
            Spacer()
            Text(value)
                .foregroundStyle(theme.secondaryText)
                .multilineTextAlignment(.trailing)
        }
        .accessibilityElement(children: .combine)
    }

    // MARK: - Data

    private var versionLabel: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "—"
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "—"
        return "\(version) (\(build))"
    }

    private var notificationStatusLabel: String {
        switch notificationStatus {
        case .authorized, .provisional, .ephemeral:
            return HaLocalizedStringWrapper.getString(key: "settings_permission_allowed")
        case .denied:
            return HaLocalizedStringWrapper.getString(key: "settings_permission_denied")
        case .notDetermined:
            return HaLocalizedStringWrapper.getString(key: "settings_permission_not_determined")
        @unknown default:
            return HaLocalizedStringWrapper.getString(key: "settings_permission_not_determined")
        }
    }

    private var calendarStatusLabel: String {
        switch calendarStatus {
        case .fullAccess, .writeOnly:
            return HaLocalizedStringWrapper.getString(key: "settings_permission_allowed")
        case .denied, .restricted:
            return HaLocalizedStringWrapper.getString(key: "settings_permission_denied")
        case .notDetermined:
            return HaLocalizedStringWrapper.getString(key: "settings_permission_not_determined")
        @unknown default:
            return HaLocalizedStringWrapper.getString(key: "settings_permission_not_determined")
        }
    }

    private func refreshPermissionStatuses() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                notificationStatus = settings.authorizationStatus
            }
        }
        calendarStatus = EKEventStore.authorizationStatus(for: .event)
    }

    private func openSystemSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }

    private func openInstagram() {
        let handle = dependencies.appSettings.instagramHandle
        // Prefer app URL; fall back to https.
        let appURL = URL(string: "instagram://user?username=\(handle)")
        let webURL = URL(string: "https://www.instagram.com/\(handle)/")
        if let appURL, UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else if let webURL {
            UIApplication.shared.open(webURL)
        }
    }
}
