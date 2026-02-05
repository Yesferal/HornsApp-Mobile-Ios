//
//  ScreenRenderListView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import SwiftUI
import HornsAppCore
import SwiftData

struct ScreenRenderListView: View {
    
    @Environment(\.modelContext) var context

    @StateObject var vm = ScreenRenderViewModel()
    
    var getHomeRenderUseCase: GetHomeRenderUseCase
    
    var getConcertsUseCase: GetConcertsUseCase
    
    init(context: ModelContext) {
        getHomeRenderUseCase = UseCaseFactory().createGetHomeRenderUseCase(repository: RenderRepositoryImpl(renderRemoteDataSource: SocketManager(renderStorageDataSource: HaFileReaderManager())))
        getConcertsUseCase = GetConcertsUseCase(concertRepository: ConcertRepositoryImpl(concertStorageDataSource: SwiftDataManager(context: context), concertRemoteDataSource: AlamoFireWrapper(appSettings: AppSettings())))
    }
    
    var body: some View {
        content
            .onAppear {
                self.vm.configure(getHomeRenderUseCase: getHomeRenderUseCase, getConcertsUseCase: getConcertsUseCase)
                Task {
                    await vm.fetchData()
                }
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch vm.state {
        case .idle:
            HaProgressView()
            
        case .loading:
            HaProgressView()
            
        case .success(let items):
            List(items) { view in
                render(view.data)
                    .listRowSeparator(.hidden) // Remove divider line
                    .listRowBackground(Color.clear) // Remove row bg
                    .listRowInsets(.init()) // Remove padding
                    .listRowSeparator(.hidden) // Remove padding
            }
            .listStyle(.plain) // Remove padding
            .scrollContentBackground(.hidden) // Hides the default white card background
            .environment(\.defaultMinListRowHeight, 0) // List rows are allowed to be any height, even 0
            
        case .failed(let error, let icon, let actionText):
            ErrorViewData(message: error, icon: icon, actionText: actionText) {
                Task {
                    await vm.retryFetchData()
                }
            }
        }
    }
}
