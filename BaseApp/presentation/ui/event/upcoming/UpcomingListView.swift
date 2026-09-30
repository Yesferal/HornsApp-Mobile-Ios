//
//  UpcomingListView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/31/26.
//

import SwiftUI
import HornsAppCore

struct UpcomingListView: View {
    @StateObject private var vm: UpcomingViewModel

    @Environment(\.theme) var theme

    @SwiftUI.State private var selectedCategory: CategoryRender?

    init(getUpcomingConcertsUseCase: GetUpcomingConcertsUseCase, renderRepository: RenderRepository) {
        _vm = StateObject(wrappedValue: UpcomingViewModel(
            getUpcomingConcertsUseCase: getUpcomingConcertsUseCase,
            renderRepository: renderRepository
        ))
    }

    var body: some View {
        VStack(spacing: 0) {
            if !vm.categories.isEmpty {
                CategoryChipsView(categories: vm.categories, selectedCategory: $selectedCategory)
                    .background(theme.background)
            }

            stateContent
        }
        .onAppear {
            if case .idle = vm.state {
                Task {
                    await vm.fetchData()
                }
            }
        }
        .onChange(of: selectedCategory) { _, newValue in
            Task {
                await vm.filterByCategory(categoryCondition: newValue?._id ?? CategoryRender.Companion().ALL)
            }
        }
    }

    @ViewBuilder
    private var stateContent: some View {
        switch vm.state {
        case .idle, .loading:
            HaProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .success(let items) where items.isEmpty:
            if selectedCategory == nil {
                EmptyStateView(
                    title: "empty_upcoming_title",
                    message: "empty_upcoming_message",
                    systemImage: "calendar"
                )
                .background(theme.background)
            } else {
                EmptyStateView(
                    title: "empty_upcoming_filter_title",
                    message: "empty_upcoming_filter_message",
                    systemImage: "calendar",
                    actionTitle: "empty_upcoming_clear_filter"
                ) {
                    selectedCategory = nil
                }
                .background(theme.background)
            }

        case .success(let items):
            List(items) { view in
                render(view.data)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init())
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
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
}
