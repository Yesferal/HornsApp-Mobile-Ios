//
//  EventList.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/28/25.
//

import SwiftUI
import HornsAppCore

struct UpcomingList: View {
    @StateObject var vm = UpcomingViewModel(getConcertsUseCase: GetConcertsUseCase(concertRepository: ConcertRepositoryImpl(concertStorageDataSource: SwiftDataManager(), concertRemoteDataSource: AlamoFireWrapper(appSettings: AppSettings()))))
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                HaProgressView()
            }
            
            List(vm.data) { view in
                render(view.data)
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
