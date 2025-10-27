//
//  EventDetailView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/12/25.
//

import SwiftUI

struct DetailView: View {
    let id: String
    let name: String
    let day: String
    let month: String
    
    @StateObject var vm = EventDetailViewModel()
    
    @State private var hasError = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        let event = vm.data
        
        ScrollView {
            VStack(spacing: 32) {
                HStack(alignment: .top) {
                    VStack {
                        HaEventDate(day: day, month: month)
                        HaVerticalDashLine()
                    }
                    AsyncImage(url: URL(string: event?.headlinerUrl ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.white
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .overlay() {
                        ZStack {
                            Text(event?.headlinerName ?? "")
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                .font(.headline)
                                .bold()
                        }
                        .background(Color.black.opacity(0.5))
                    }
                    .clipShape(.rect(cornerRadius: 16))
                }
                HStack {
                    Spacer()
                        .frame(width: 48)
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                }
                
                HaEventBuyButton(iconName: "ticket", title: "title", subtitle: "subtitle", actionText: "Buy") {
                    print("Button tapped!")
                }
                HaEventLink(iconName: "location", title: "title", subtitle: "subtitle", actionText: "Buy") {
                    print("Button tapped!")
                }
                HaEventLink(iconName: "calendar", title: "title", subtitle: "subtitle", actionText: "Buy") {
                    print("Button tapped!")
                }
            }
            .padding()
            
            Spacer() // Pushes content to the top
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            if vm.data == nil {
                Task {
                    await vm.fetchData(id: id)
                }
            }
        }
        .navigationTitle(self.name)
    }
}
