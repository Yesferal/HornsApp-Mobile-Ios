//
//  SettingsView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/2/26.
//

import EventKit
import SwiftUI
import UserNotifications

/// App Settings / About (`#store-7-settings-about`): version, permissions, social profiles.
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
            socialSection
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
            HaEventLink(
                iconName: "info.circle",
                title: HaLocalizedStringWrapper.getString(key: "settings_version"),
                trailingText: versionLabel,
                trailingSystemName: nil
            )
            HaEventLink(
                iconName: "app.badge",
                title: HaLocalizedStringWrapper.getString(key: "settings_app_name"),
                trailingText: dependencies.appSettings.appName,
                trailingSystemName: nil
            )
        } header: {
            Text(LocalizedStringKey("settings_section_about"))
                .foregroundStyle(theme.secondaryText)
        }
        .listRowBackground(theme.primary)
    }

    private var permissionsSection: some View {
        Section {
            HaEventLink(
                iconName: "bell",
                title: HaLocalizedStringWrapper.getString(key: "settings_notifications_status"),
                trailingText: notificationStatusLabel,
                trailingSystemName: nil
            )
            HaEventLink(
                iconName: "calendar",
                title: HaLocalizedStringWrapper.getString(key: "settings_calendar_status"),
                trailingText: calendarStatusLabel,
                trailingSystemName: nil
            )
            HaEventLink(
                iconName: "gear",
                title: HaLocalizedStringWrapper.getString(key: "settings_permissions_open_system"),
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

    private var socialSection: some View {
        Section {
            ForEach(dependencies.appSettings.socialLinks) { link in
                HaEventLink(
                    iconName: link.systemImage,
                    title: HaLocalizedStringWrapper.getString(key: link.titleLocalizationKey),
                    subtitle: "@\(link.handle)",
                    trailingSystemName: "arrow.up.right"
                ) {
                    openSocial(link)
                }
                .accessibilityLabel(LocalizedStringKey(link.titleLocalizationKey))
                .accessibilityValue("@\(link.handle)")
            }
        } header: {
            Text(LocalizedStringKey("settings_section_social"))
                .foregroundStyle(theme.secondaryText)
        } footer: {
            Text(LocalizedStringKey("settings_social_footer"))
                .foregroundStyle(theme.secondaryText)
        }
        .listRowBackground(theme.primary)
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

    private func openSocial(_ link: AppSocialLink) {
        UIApplication.shared.open(link.url)
    }
}
