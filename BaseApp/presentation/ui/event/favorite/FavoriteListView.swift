//
//  FavoriteListView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/31/26.
//

import SwiftUI
import HornsAppCore

struct FavoriteListView: View {
    @Environment(\.theme) var theme
    @EnvironmentObject var router: Router

    @EnvironmentObject var vm: FavoriteViewModel

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch vm.state {
                case .idle, .loading:
                    HaProgressView()

                case .success(let items) where items.isEmpty:
                    EmptyStateView(
                        title: "empty_favorites_title",
                        message: "empty_favorites_message",
                        systemImage: "heart",
                        actionTitle: "empty_favorites_cta"
                    ) {
                        router.selectedTab = .upcoming
                    }
                    .background(theme.background)

                case .success(let items):
                    List(items) { view in
                        render(view.data)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .listRowInsets(.init())
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    .readableContentWidth()

                case .failed(let message, let icon, let actionText):
                    ErrorViewData(message: message, icon: icon, actionText: actionText) {
                        Task {
                            await vm.retryFetchData()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(theme.primary)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Footer — keeps empty state centered; avoids a floating row in the middle.
            settingsEntry
        }
        .onAppear {
            if case .idle = vm.state {
                Task {
                    await vm.fetchData()
                }
            }
        }
    }

    private var settingsEntry: some View {
        HaEventLink(
            iconName: "gearshape",
            title: HaLocalizedStringWrapper.getString(key: "settings_title")
        ) {
            router.navigate(to: .settings)
        }
        .padding(.horizontal, Dimens.medium)
        .padding(.vertical, Dimens.medium)
        .fixedSize(horizontal: false, vertical: true)
        .accessibilityLabel(LocalizedStringKey("settings_title"))
    }
}
