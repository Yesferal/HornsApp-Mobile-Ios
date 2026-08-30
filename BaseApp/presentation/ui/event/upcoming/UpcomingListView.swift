//
//  EventList.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/28/25.
//

import SwiftUI
import HornsAppCore

struct UpcomingList: View {
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
        ZStack {
            if isLoading {
                HaProgressView()
            }

            content
        }
        .animation(.easeInOut, value: isLoading)
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

    private var isLoading: Bool {
        switch vm.state {
        case .idle, .loading:
            return true
        default:
            return false
        }
    }

    @ViewBuilder
    private var content: some View {
        switch vm.state {
        case .failed(let message, let icon, let actionText):
            ErrorViewData(message: message, icon: icon, actionText: actionText) {
                Task {
                    await vm.retryFetchData()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(theme.primary)

        case .success(let items):
            List {
                CategoryChipsView(categories: vm.categories, selectedCategory: $selectedCategory)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init())
                    .background(theme.background)

                ForEach(items) { view in
                    render(view.data)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(.init())
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)

        case .idle, .loading:
            EmptyView()
        }
    }
}
