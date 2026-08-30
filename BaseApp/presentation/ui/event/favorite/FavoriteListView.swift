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

    @EnvironmentObject var vm: FavoriteViewModel

    var body: some View {
        Group {
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
                .scrollContentBackground(.hidden)
                .listStyle(.plain)

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
        .onAppear {
            if case .idle = vm.state {
                Task {
                    await vm.fetchData()
                }
            }
        }
    }
}
