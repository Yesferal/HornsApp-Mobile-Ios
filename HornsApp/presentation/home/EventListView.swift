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
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .padding(20)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(12)
            }
            
            List(vm.data) { event in
                EventRowView(event: event)
                    .listRowSeparator(.hidden)
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
