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
            
            List(vm.data) { event in
                EventRowView(event: event)
                    .listRowSeparator(.hidden) // remove divider line
                    .listRowBackground(Color.clear) // remove row bg
            }
            .scrollContentBackground(.hidden) // Hides the default white card background
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
