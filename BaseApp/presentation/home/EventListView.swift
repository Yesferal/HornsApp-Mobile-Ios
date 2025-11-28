//
//  EventList.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 6/28/25.
//

import SwiftUI

struct EventList: View {
    @StateObject var vm = HomeViewModel()
    
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
