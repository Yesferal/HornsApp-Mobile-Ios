//
//  EventList.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/28/25.
//

import SwiftUI
import HornsAppCore
import SwiftData

struct UpcomingList: View {
    
    @Environment(\.modelContext) var context

    @StateObject var vm = UpcomingViewModel()
    
    var getUpcomingConcertsUseCase: GetUpcomingConcertsUseCase
        
    init(context: ModelContext) {
        getUpcomingConcertsUseCase = GetUpcomingConcertsUseCase(concertRepository: ConcertRepositoryImpl(concertStorageDataSource: SwiftDataManager(context: context), concertRemoteDataSource: AlamoFireWrapper(appSettings: AppSettings())), filterConcertsByCategoryUseCase: FilterConcertsByCategoryUseCase())
    }
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                HaProgressView()
            }
            
            List(vm.data) { view in
                render(view.data)
                    .listRowSeparator(.hidden) // remove divider line
                    .listRowBackground(Color.clear) // remove row bg
                    .listRowInsets(.init()) // Remove padding
                    .listRowSeparator(.hidden) // Remove padding
            }
            .listStyle(.plain) // Remove padding
            .scrollContentBackground(.hidden) // Hides the default white card background
            .onAppear {
                if vm.data.isEmpty {
                    Task {
                        // FIXME: Move it to init function, one time call
                        vm.configure(getUpcomingConcertsUseCase: getUpcomingConcertsUseCase)
                        await vm.fetchData()
                    }
                }
            }
        }
        .animation(.easeInOut, value: vm.isLoading)
    }
}
