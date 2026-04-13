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
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.theme) var theme
    
    @EnvironmentObject var router: Router
    
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    
    @SwiftUI.State private var hasError = false
    
    @SwiftUI.State private var activeAlert: HaAlert?
    
    @SwiftUI.State private var showMapDialog = false
    
    @StateObject private var vm = EventDetailViewModel()
    
    var getConcertUseCase: GetConcertUseCase
    
    var updateFavoriteConcertUseCase: UpdateFavoriteConcertUseCase
    
    private var calendarPermissionManager = CalendarPermissionManager()
    
    var location: MapLauncherManager.Location? {
        guard
            let event = vm.data,
            let lat = Double(event.venue?.latitude ?? ""),
            let lon = Double(event.venue?.longitude ?? "")
        else { return nil }

        return MapLauncherManager.Location(
            name: event.venue?.mapSearchName ?? "",
            latitude: lat,
            longitude: lon
        )
    }
    
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
                            let actionText = (event?.ticketingName?.isEmpty == false)
                            ? event?.ticketingName
                            : HaLocalizedStringWrapper.getString(key: "go_now")
                            HaEventBuyButton(iconName: "ticket", title: HaLocalizedStringWrapper.getString(key: "available_on"), subtitle: HaLocalizedStringWrapper.getString(key: "go_now"), actionText: actionText, route: .web(url: url))
                        } else {
                            HaEventBuyButton(iconName: "ticket", title: HaLocalizedStringWrapper.getString(key: "available_soon"), subtitle: HaLocalizedStringWrapper.getString(key: "unavailable"), actionText: event?.ticketingName, route: nil)
                        }
                        HaEventLink(iconName: "location", title: event?.venue?.name ?? HaLocalizedStringWrapper.getString(key: "venue"), subtitle: HaLocalizedStringWrapper.getString(key: "go_to_maps")) {
                            showMapDialog = true
                        }
                        HaEventLink(iconName: "calendar", title: event?.getEventAsCalendarLabel() ?? "", subtitle: HaLocalizedStringWrapper.getString(key: "add_to_calendar")) {
                            Task {
                                let granted = await calendarPermissionManager.requestAccess()
                                
                                if granted {
                                    calendarPermissionManager.saveEventToCalendar(event: event)
                                    activeAlert = .eventAdded
                                } else {
                                    activeAlert = .calendarAccessDenied
                                }
                            }
                        }
                        
                        if let safeEvent = event {
                            RemindersSection(event: safeEvent)
                        }
                    }
                }
                
                Spacer() // Pushes content to the top
            }
            .padding()
            
        }
        .alert(item: $activeAlert) { alert in
            Alert(
                title: Text(HaLocalizedStringWrapper.getString(key: alert.title)),
                message: Text(HaLocalizedStringWrapper.getString(key: alert.message)))
        }
        .confirmationDialog(
            "open_with",
            isPresented: $showMapDialog,
            titleVisibility: .visible
        ) {
            if let location {
                ForEach(MapLauncherManager.availableApps(for: location)) { app in
                    Button(app.displayName) {
                        MapLauncherManager.open(app, location: location)
                    }
                }
            }
            
            Button("key_cancel", role: .cancel) { }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            if vm.data == nil {
                vm.configure(getConcertUseCase: getConcertUseCase, updateFavoriteConcertUseCase: updateFavoriteConcertUseCase)
                Task {
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
                            await favoriteVM.update()
                        }
                    }
                }
            }
        }
        .background(theme.background)
    }
}
