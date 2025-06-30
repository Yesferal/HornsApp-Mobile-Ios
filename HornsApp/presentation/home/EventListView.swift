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
        List(vm.data) { event in
            EventRow(event: event)
        }.onAppear {
            if vm.data.isEmpty {
                Task {
                    await vm.fetchData()
                }
            }
        }
    }
}
