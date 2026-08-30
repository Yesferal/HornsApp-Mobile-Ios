//
//  ScreenRenderListView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import SwiftUI
import HornsAppCore

struct ScreenRenderListView: View {
    @StateObject private var vm: ScreenRenderViewModel

    init(getHomeRenderUseCase: GetHomeRenderUseCase, getConcertsUseCase: GetConcertsUseCase) {
        _vm = StateObject(wrappedValue: ScreenRenderViewModel(
            getHomeRenderUseCase: getHomeRenderUseCase,
            getConcertsUseCase: getConcertsUseCase
        ))
    }

    var body: some View {
        content
            .onAppear {
                if case .idle = vm.state {
                    Task {
                        await vm.fetchData()
                    }
                }
            }
    }

    @ViewBuilder
    private var content: some View {
        switch vm.state {
        case .idle, .loading:
            HaProgressView()

        case .success(let items):
            List(items) { view in
                render(view.data)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init())
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListRowHeight, 0)

        case .failed(let error, let icon, let actionText):
            ErrorViewData(message: error, icon: icon, actionText: actionText) {
                Task {
                    await vm.retryFetchData()
                }
            }
        }
    }
}
