//
//  ScreenRenderListView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import SwiftUI
import HornsAppCore

struct ScreenRenderListView: View {
    @StateObject var vm = ScreenRenderViewModel(getHomeRenderUseCase: UseCaseFactory().createGetHomeRenderUseCase(repository: RenderRepositoryImpl(renderRemoteDataSource: SocketManager(renderStorageDataSource: HaFileReaderManager()))))
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                HaProgressView()
            }
            
            List(vm.data) { view in
                render(view.data)
                    .listRowSeparator(.hidden) // Remove divider line
                    .listRowBackground(Color.clear) // Remove row bg
                    .listRowInsets(.init()) // Remove padding
                    .listRowSeparator(.hidden) // Remove padding
            }
            .listStyle(.plain) // Remove padding
            .scrollContentBackground(.hidden) // Hides the default white card background
            .environment(\.defaultMinListRowHeight, 0) // List rows are allowed to be any height, even 0
            .onAppear {
                if vm.data.isEmpty {
                    Task {
                        await vm.fetchData()
                    }
                }
            }
        }
        .animation(.easeInOut, value: vm.isLoading)
    }
}
