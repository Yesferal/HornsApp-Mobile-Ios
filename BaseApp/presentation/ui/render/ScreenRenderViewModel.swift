//
//  ScreenRenderViewModel.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import HornsAppCore

@MainActor class ScreenRenderViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var data: [ViewItem] = []
    var getHomeRenderUseCase: GetHomeRenderUseCase?
    var getConcertsUseCase: GetConcertsUseCase?
    
    func configure(getHomeRenderUseCase: GetHomeRenderUseCase, getConcertsUseCase: GetConcertsUseCase) {
        self.getHomeRenderUseCase = getHomeRenderUseCase
        self.getConcertsUseCase = getConcertsUseCase
    }
    
    func fetchData() async {
        data = []
        isLoading = true
        defer { isLoading = false }
        
        guard let screenRender: [ScreenRender]? = try? await getHomeRenderUseCase?.invoke() else {
            return
        }
        print("Yesferal: ScreenRenderViewModel: ScreenRender: \(screenRender)")
        
        do {
            guard let haResult = try await getConcertsUseCase?.invoke() else {
                return
            }
            let uiResult: UiResult<[Concert]> = mapCoreResultAsUiResult(haResult)
            
            switch uiResult {
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
    mutating func addViewItem(viewRender: ViewRender, events: [Concert]) {
        switch viewRender.type {
        case ViewRender.Type_.adView:
            append(ViewItem(id: UUID(), data: .ad))
        case ViewRender.Type_.iconCardView:
            append(ViewItem(id: UUID(), data: .seeMore(title: viewRender.data?.title?.text ?? "", subtitle: viewRender.data?.subtitle?.text ?? "", icon: "music.note", backgroundColor: viewRender.style?.backgroundColor ?? "", buttonBackgroundColor: viewRender.style?.textColor ?? "", buttonForegroundColor: viewRender.style?.backgroundColor ?? "", actionText: "See More", route: getRoute(navigatorRender: viewRender.navigation))))
            append(getDividerViewItem())
        case ViewRender.Type_.cardView:
            append(ViewItem(id: UUID(), data: .home(title: viewRender.data?.title?.text ?? "", subtitle: viewRender.data?.subtitle?.text, imageUrl: viewRender.data?.imageUrl ?? "", route: getRoute(navigatorRender: viewRender.navigation))))
            append(getDividerViewItem())
        case ViewRender.Type_.rowView:
            guard let children = viewRender.children else {
                append(ViewItem(id: UUID(), data: .empty))
                return
            }
            let tempEvents = children.getConcertsForSections(concerts: events)
            
            if (!tempEvents.isEmpty) {
                tempEvents.forEach { e in
                    append(getChildrenViewItem(childrenRender: children, concert: e))
                }
                append(getDividerViewItem())
            }
        case ViewRender.Type_.columnView:
            guard let children = viewRender.children else {
                return
            }
            let tempEvents = children.getConcertsForSections(concerts: events)
            if (!tempEvents.isEmpty) {
                append(ViewItem(id: UUID(), data: .title(title: viewRender.data?.title?.text ?? "", subtitle: viewRender.data?.subtitle?.text, route: getRoute(navigatorRender: viewRender.navigation))))
                append(ViewItem(id: UUID(), data: .divider(height: Dimens.small)))
                tempEvents.forEach { e in
                    append(getChildrenViewItem(childrenRender: children, concert: e))
                }
                append(getDividerViewItem())
            }
        default:
            append(ViewItem(id: UUID(), data: .empty))
        }
    }
    
    private func getDividerViewItem() -> ViewItem {
        return ViewItem(id: UUID(), data: .divider(height: Dimens.xlarge))
    }
    
    private func getChildrenViewItem(childrenRender: ChildrenRender, concert: Concert) -> ViewItem {
        switch childrenRender.type {
        case ChildrenRender.Type_.carouselCardView:
            return ViewItem(id: UUID(), data: .carousel(concert: concert))
        case ChildrenRender.Type_.upcomingCardView:
            return ViewItem(id: UUID(), data: .upcomingCompact(concert: concert))
        case ChildrenRender.Type_.upcomingImageCardView:
            return ViewItem(id: UUID(), data: .upcoming(concert: concert))
        default:
            return ViewItem(id: UUID(), data: .empty)
        }
    }
    
    private func getRoute(navigatorRender: NavigatorRender?) -> Route? {
        guard let key = navigatorRender?.key else {
            return nil
        }
        let navigator: Navigator = Navigator.Builder().to(to_: key).build()
        switch navigator.to {
        case ScreenRender.Type_.webViewScreen:
            guard let stringUrl = (navigatorRender?.parameters["param_android_uri"] as? StringOrObject)?.getStringValue() else {
                return nil
            }
            guard let url = URL(string: stringUrl) else {
                return nil
            }
            return .web(url: url)
        case ScreenRender.Type_.favoriteScreen:
            return .favorite
        case ScreenRender.Type_.upcomingScreen:
            return .upcoming
        default:
            return nil
        }
    }
}
