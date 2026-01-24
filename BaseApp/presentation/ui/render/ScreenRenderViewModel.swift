//
//  ScreenRenderViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import HornsAppCore

@MainActor class ScreenRenderViewModel: ObservableObject {
    @Published var isLoading: Bool
    @Published var data: [ViewItem]
    var getHomeRenderUseCase: GetHomeRenderUseCase
    
    init(isLoading: Bool = false, data: [ViewItem] = [], getHomeRenderUseCase: GetHomeRenderUseCase) {
        self.isLoading = isLoading
        self.data = data
        self.getHomeRenderUseCase = getHomeRenderUseCase
    }
    
    func fetchData() async {
        data = []
        isLoading = true
        defer { isLoading = false }
        
        let screenRender: [ScreenRender]? = try? await getHomeRenderUseCase.invoke()
        print("Yesferal: ScreenRenderViewModel: ScreenRender: \(screenRender)")
        
        do {
            let appSettings = AppSettings()
            let appName = appSettings.appName
            let events: HaResult<[GetEvents]> = try await AlamoFireWrapper(appName: appName).makeRequest(path: appSettings.homePath)
            
            screenRender?[1].views?.map { v in
                print("Yesferal: v.type: \(v.type)")
            }
            
            switch events {
            case .success(let events):
                var views: [ViewItem] = []
                screenRender?[1].views?.forEach { v in
                    views.addViewItem(viewRender: v, events: events)
                }
                data = views
                return
            case .failed:
                // TODO: Logger
                return
            }
        } catch {
            // TODO: Logger
        }
    }
}

extension [ViewItem] {
    mutating func addViewItem(viewRender: ViewRender, events: [GetEvents]) {
        switch viewRender.type {
        case ViewRender.Type_.adView:
            append(ViewItem(id: UUID(), data: .ad))
        case ViewRender.Type_.iconCardView:
            append(ViewItem(id: UUID(), data: .seeMore(title: viewRender.data?.title?.text ?? "", subtitle: viewRender.data?.subtitle?.text ?? "", icon: "camera", backgroundColor: viewRender.style?.backgroundColor ?? "", buttonBackgroundColor: viewRender.style?.textColor ?? "", buttonForegroundColor: viewRender.style?.backgroundColor ?? "", actionText: "See More", action: {
                
            })))
            append(getDividerViewItem())
        case ViewRender.Type_.cardView:
            append(ViewItem(id: UUID(), data: .home(title: viewRender.data?.title?.text ?? "", subtitle: viewRender.data?.subtitle?.text ?? "", imageUrl: viewRender.data?.imageUrl ?? "")))
            append(getDividerViewItem())
        case ViewRender.Type_.rowView:
            guard let children = viewRender.children else {
                append(ViewItem(id: UUID(), data: .empty))
                return
            }
            let tempEvents = events.reversed().prefix(1)
            tempEvents.forEach { e in
                append(getChildrenViewItem(childrenRender: children, event: e))
            }
            append(getDividerViewItem())
        case ViewRender.Type_.columnView:
            guard let children = viewRender.children else {
                append(ViewItem(id: UUID(), data: .empty))
                return
            }
            append(ViewItem(id: UUID(), data: .title(title: viewRender.data?.title?.text ?? "", subtitle: viewRender.data?.subtitle?.text ?? "")))
            append(ViewItem(id: UUID(), data: .divider(height: Dimens.Space.medium)))
            let tempEvents = events.prefix(3)
            tempEvents.forEach { e in
                append(getChildrenViewItem(childrenRender: children, event: e))
            }
            append(getDividerViewItem())
        default:
            append(ViewItem(id: UUID(), data: .empty))
        }
    }
    
    private func getDividerViewItem() -> ViewItem {
        return ViewItem(id: UUID(), data: .divider(height: Dimens.Space.xlarge))
    }
    
    private func getChildrenViewItem(childrenRender: ChildrenRender, event: GetEvents) -> ViewItem {
        switch childrenRender.type {
        case ChildrenRender.Type_.carouselCardView:
            let model = EventModel.fromApi(event: event)
            return ViewItem(id: UUID(), data: .carousel(eventModel: model))
        case ChildrenRender.Type_.upcomingCardView:
            let model = EventModel.fromApi(event: event)
            return ViewItem(id: UUID(), data: .upcomingCompact(eventModel: model))
        case ChildrenRender.Type_.upcomingImageCardView:
            let model = EventModel.fromApi(event: event)
            return ViewItem(id: UUID(), data: .upcoming(eventModel: model))
        default:
            return ViewItem(id: UUID(), data: .empty)
        }
    }
}
