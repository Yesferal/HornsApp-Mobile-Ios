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
    @Environment(\.dependencies) var dependencies
    
    @Environment(\.theme) var theme

    @SwiftUI.State private var selectedCategory: CategoryRender?
    
    @StateObject var vm = UpcomingViewModel()
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                HaProgressView()
            }
            
            List {
                CategoryChipsView(categories: vm.categories,
                                  selectedCategory: $selectedCategory)
                .listRowSeparator(.hidden)
                .listRowInsets(.init())
                .background(theme.background)

                
                ForEach(vm.data) { view in
                    render(view.data)
                        .listRowSeparator(.hidden) // remove divider line
                        .listRowBackground(Color.clear) // remove row bg
                        .listRowInsets(.init()) // Remove padding
                        .listRowSeparator(.hidden) // Remove padding
                }
            }
            .listStyle(.plain) // Remove padding
            .scrollContentBackground(.hidden) // Hides the default white card background
            .onAppear {
                if vm.data.isEmpty {
                    Task {
                        vm.configure(
                            getUpcomingConcertsUseCase: dependencies.makeGetUpcomingConcertsUseCase(context: context),
                            renderRepository: dependencies.getRenderRepository()
                        )
                        await vm.fetchData()
                    }
                }
            }
            .onChange(of: selectedCategory) { oldValue, newValue in
                Task {
                    await vm.filterByCategory(categoryCondition: newValue?._id ?? CategoryRender.Companion().ALL)
                }
            }
        }
        .animation(.easeInOut, value: vm.isLoading)
    }
}
