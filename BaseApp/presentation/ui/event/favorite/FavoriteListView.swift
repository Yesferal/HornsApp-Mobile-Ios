//
//  FavoriteListView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 1/31/26.
//

import SwiftUI
import HornsAppCore
import SwiftData

struct FavoriteListView: View {
    
    @Environment(\.modelContext) var context

    @StateObject var vm = FavoriteViewModel()
    
    var getFavoriteConcertsUseCase: GetFavoriteConcertsUseCase
    
    init(context: ModelContext) {
        getFavoriteConcertsUseCase = GetFavoriteConcertsUseCase(concertRepository: ConcertRepositoryImpl(concertStorageDataSource: SwiftDataManager(context: context), concertRemoteDataSource: AlamoFireWrapper(appSettings: AppSettings())))
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
            .scrollContentBackground(.hidden) // Hides the default white card background
            .listStyle(.plain) // Remove padding
            .onAppear {
                if vm.data.isEmpty {
                    Task {
                        // FIXME: Try to use it one time in init instead
                        vm.configure(getFavoriteConcertsUseCase: getFavoriteConcertsUseCase)
                        await vm.fetchData()
                    }
                }
            }
        }
        .animation(.easeInOut, value: vm.isLoading)
    }
}
