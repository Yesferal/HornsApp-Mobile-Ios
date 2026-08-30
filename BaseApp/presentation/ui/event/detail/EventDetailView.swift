//
//  EventDetailView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/12/25.
//

import SwiftUI
import HornsAppCore

struct EventDetailView: View {
    let id: String
    let name: String
    let day: String
    let month: String

    @Environment(\.modelContext) var context
    @Environment(\.dependencies) var dependencies

    var body: some View {
        EventDetailViewBody(
            id: id,
            name: name,
            day: day,
            month: month,
            viewModel: EventDetailViewModel(
                getConcertUseCase: dependencies.makeGetConcertUseCase(context: context),
                updateFavoriteConcertUseCase: dependencies.makeUpdateFavoriteConcertUseCase(context: context)
            )
        )
    }
}

private struct EventDetailViewBody: View {
    let id: String
    let name: String
    let day: String
    let month: String

    @StateObject var viewModel: EventDetailViewModel

    @Environment(\.dismiss) var dismiss
    @Environment(\.theme) var theme
    @EnvironmentObject var router: Router
    @EnvironmentObject var favoriteVM: FavoriteViewModel

    @SwiftUI.State private var activeAlert: HaAlert?
    @SwiftUI.State private var showMapDialog = false

    private var calendarPermissionManager = CalendarPermissionManager()

    init(id: String, name: String, day: String, month: String, viewModel: EventDetailViewModel) {
        self.id = id
        self.name = name
        self.day = day
        self.month = month
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var location: MapLauncherManager.Location? {
        guard
            let event = loadedEvent,
            let lat = Double(event.venue?.latitude ?? ""),
            let lon = Double(event.venue?.longitude ?? "")
        else { return nil }

        return MapLauncherManager.Location(
            name: event.venue?.mapSearchName ?? "",
            latitude: lat,
            longitude: lon
        )
    }

    var body: some View {
        let event = loadedEvent

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

                    switch viewModel.state {
                    case .loading, .idle:
                        HaProgressView()
                    case .failed(let message, let icon, let actionText):
                        ErrorViewData(message: message, icon: icon, actionText: actionText) {
                            Task {
                                await viewModel.retryFetchData(id: id)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 240)
                        .background(theme.primary)
                        .clipShape(.rect(cornerRadius: 16))
                    case .success:
                        detailActions(for: event)
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
        .alert(item: $viewModel.favoriteAlert) { alert in
            Alert(
                title: Text(HaLocalizedStringWrapper.getString(key: alert.title)),
                message: Text(HaLocalizedStringWrapper.getString(key: alert.message)))
        }
        .confirmationDialog(
            LocalizedStringKey("open_with"),
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

            Button(LocalizedStringKey("key_cancel"), role: .cancel) { }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            if case .idle = viewModel.state {
                Task {
                    await viewModel.fetchData(id: id)
                }
            }
        }
        .navigationTitle(name)
        .toolbar {
            if event != nil {
                ToolbarItem(placement: .topBarTrailing) {
                    FavoriteButton(isFavorite: viewModel.isFavorite) { _ in
                        Task {
                            let didUpdate = await viewModel.onFavoriteImageViewClick(concert: event)
                            if didUpdate {
                                await favoriteVM.update()
                            }
                        }
                    }
                }
            }
        }
        .background(theme.background)
    }

    private var loadedEvent: Concert? {
        if case .success(let event) = viewModel.state {
            return event
        }
        return nil
    }

    @ViewBuilder
    private func detailActions(for event: Concert?) -> some View {
        HaEventBuyButton(iconName: "calendar", title: event?.getEventAsCalendarLabel() ?? "", subtitle: HaLocalizedStringWrapper.getString(key: "add_to_calendar"), actionText: HaLocalizedStringWrapper.getString(key: "key_add_to_calendar_button")) {
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

        HaEventLink(iconName: "location", title: event?.venue?.name ?? HaLocalizedStringWrapper.getString(key: "venue"), subtitle: HaLocalizedStringWrapper.getString(key: "go_to_maps")) {
            showMapDialog = true
        }

        if let url = URL(string: event?.ticketingUrl ?? "") {
            let title = (event?.ticketingName?.isEmpty == false)
            ? event?.ticketingName
            : HaLocalizedStringWrapper.getString(key: "available_on")
            HaEventLink(iconName: "ticket", title: title ?? "", subtitle: HaLocalizedStringWrapper.getString(key: "go_now"), action: Route.web(url: url).asAction(router: router))
        } else {
            HaEventLink(iconName: "ticket", title: HaLocalizedStringWrapper.getString(key: "available_soon"), subtitle: HaLocalizedStringWrapper.getString(key: "unavailable")) {}
        }

        if let safeEvent = event {
            RemindersSection(event: safeEvent)
            LineupSection(event: safeEvent)
            RelatedEventSection(events: [])
        }
    }
}
