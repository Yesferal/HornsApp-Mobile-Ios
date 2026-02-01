//
//  EventDetailView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/12/25.
//

import SwiftUI
import HornsAppCore
import SwiftData

struct DetailView: View {
    let id: String
    let name: String
    let day: String
    let month: String
    
    @Environment(\.modelContext) var context
    
    @StateObject private var vm = EventDetailViewModel()
    
    @SwiftUI.State private var hasError = false
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.theme) var theme
    
    @EnvironmentObject var router: Router
    
    var getConcertUseCase: GetConcertUseCase
    
    var updateFavoriteConcertUseCase: UpdateFavoriteConcertUseCase
    
    init(id: String, name: String, day: String, month: String, context: ModelContext) {
        self.id = id
        self.name = name
        self.day = day
        self.month = month
        
        let concertRepository = ConcertRepositoryImpl(concertStorageDataSource: SwiftDataManager(context: context), concertRemoteDataSource: AlamoFireWrapper(appSettings: AppSettings()))
        getConcertUseCase = GetConcertUseCase(concertRepository: concertRepository, getFavoriteConcertsUseCase: GetFavoriteConcertsUseCase(concertRepository: concertRepository))
        updateFavoriteConcertUseCase = UpdateFavoriteConcertUseCase(concertRepository: concertRepository)
    }

    var body: some View {
        let event = vm.data
        
        ScrollView {
            ZStack(alignment: .leading) {
                HaVerticalDashLine()
                    .frame(width: 48)
                
                VStack(spacing: 32) {
                    HStack(alignment: .top) {
                        HaEventDate(day: day, month: month)
                        AsyncImage(url: URL(string: event?.headlinerImageUrl ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            theme.background
                        }
                        .overlay() {
                            ZStack {
                                Text(event?.headlinerName ?? "")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .font(.headline)
                                    .bold()
                            }
                            .background(Color.black.opacity(0.5))
                        }
                        .aspectRatio(1, contentMode: .fill)
                        .clipped()
                        .clipShape(.rect(cornerRadius: 16))
                    }
                    HStack {
                        Spacer()
                            .frame(width: 48)
                        
                        Circle()
                            .fill(theme.accent)
                            .frame(width: 8, height: 8)
                    }
                    
                    if vm.isLoading {
                        HaProgressView()
                    } else {
                        
                        if let url = URL(string: event?.ticketingUrl ?? "") {
                            HaEventBuyButton(iconName: "ticket", title: HaLocalizedStringWrapper.getString(key: "available_on"), subtitle: HaLocalizedStringWrapper.getString(key: "go_now"), actionText: event?.ticketingName, route: .web(url: url))
                        } else {
                            HaEventBuyButton(iconName: "ticket", title: HaLocalizedStringWrapper.getString(key: "available_soon"), subtitle: HaLocalizedStringWrapper.getString(key: "unavailable"), actionText: event?.ticketingName, route: nil)
                        }
                        HaEventLink(iconName: "location", title: event?.venue?.mapSearchName ?? HaLocalizedStringWrapper.getString(key: "venue"), subtitle: HaLocalizedStringWrapper.getString(key: "go_to_maps")) {
                            guard let latitude = event?.venue?.latitude else {
                                return
                            }
                            guard let longitude = event?.venue?.longitude else {
                                return
                            }
                            let query = "q=\(latitude),\(longitude)"
                            let appleURL = "maps://?\(query)"
                            let googleURL = "comgooglemaps://?\(query)"
                            if let googleMapsURL = URL(string: googleURL), UIApplication.shared.canOpenURL(googleMapsURL) {
                                UIApplication.shared.open(googleMapsURL)
                            } else if let appleMapsURL = URL(string: appleURL) {
                                UIApplication.shared.open(appleMapsURL)
                            }
                        }
                        HaEventLink(iconName: "calendar", title: event?.getEventAsCalendarLabel() ?? "", subtitle: HaLocalizedStringWrapper.getString(key: "add_to_calendar")) {
                            // TODO: Implement Calendar feature
                            print("Button tapped!")
                        }
                    }
                }
                
                Spacer() // Pushes content to the top
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            if vm.data == nil {
                Task {
                    vm.configure(getConcertUseCase: getConcertUseCase, updateFavoriteConcertUseCase: updateFavoriteConcertUseCase)
                    await vm.fetchData(id: id)
                }
            }
        }
        .navigationTitle(self.name)
        .toolbar {
            if event != nil {
                ToolbarItem(placement: .topBarTrailing) {
                    FavoriteButton(isFavorite: vm.isFavorite) { isChecked in
                        Task {
                            await vm.onFavoriteImageViewClick(concert: event)
                        }
                    }
                }
            }
        }
        .background(theme.background)
    }
}
