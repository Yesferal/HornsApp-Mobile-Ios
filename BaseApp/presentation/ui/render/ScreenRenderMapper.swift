//
//  ScreenRenderMapper.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 8/30/26.
//

import HornsAppCore

struct ScreenRenderMapper {
    func map(views: [ViewRender]?, events: [Concert]) -> [ViewItem] {
        var viewItems: [ViewItem] = []
        views?.forEach { viewRender in
            appendViewItem(to: &viewItems, viewRender: viewRender, events: events)
        }
        return viewItems
    }

    private func appendViewItem(to viewItems: inout [ViewItem], viewRender: ViewRender, events: [Concert]) {
        switch viewRender.type {
        case ViewRender.Type_.adView:
            viewItems.append(ViewItem(id: UUID(), data: .ad))
        case ViewRender.Type_.iconCardView:
            viewItems.append(ViewItem(id: UUID(), data: .seeMore(
                title: viewRender.data?.title?.text ?? "",
                subtitle: viewRender.data?.subtitle?.text ?? "",
                icon: "music.note",
                backgroundColor: viewRender.style?.backgroundColor ?? "",
                buttonBackgroundColor: viewRender.style?.textColor ?? "",
                buttonForegroundColor: viewRender.style?.backgroundColor ?? "",
                actionText: HaLocalizedStringWrapper.getString(key: "see_more"),
                route: getRoute(navigatorRender: viewRender.navigation)
            )))
            viewItems.append(getDividerViewItem())
        case ViewRender.Type_.cardView:
            viewItems.append(ViewItem(id: UUID(), data: .home(
                title: viewRender.data?.title?.text ?? "",
                subtitle: viewRender.data?.subtitle?.text,
                imageUrl: viewRender.data?.imageUrl ?? "",
                route: getRoute(navigatorRender: viewRender.navigation)
            )))
            viewItems.append(getDividerViewItem())
        case ViewRender.Type_.rowView:
            guard let children = viewRender.children else {
                viewItems.append(ViewItem(id: UUID(), data: .empty))
                return
            }
            let tempEvents = children.getConcertsForSections(concerts: events)

            if !tempEvents.isEmpty {
                tempEvents.forEach { event in
                    viewItems.append(getChildrenViewItem(childrenRender: children, concert: event))
                }
                viewItems.append(getDividerViewItem())
            }
        case ViewRender.Type_.columnView:
            guard let children = viewRender.children else {
                return
            }
            let tempEvents = children.getConcertsForSections(concerts: events)
            if !tempEvents.isEmpty {
                viewItems.append(ViewItem(id: UUID(), data: .title(
                    title: viewRender.data?.title?.text ?? "",
                    subtitle: viewRender.data?.subtitle?.text,
                    route: getRoute(navigatorRender: viewRender.navigation)
                )))
                viewItems.append(ViewItem(id: UUID(), data: .divider(height: Dimens.small)))
                tempEvents.forEach { event in
                    viewItems.append(getChildrenViewItem(childrenRender: children, concert: event))
                }
                viewItems.append(getDividerViewItem())
            }
        default:
            viewItems.append(ViewItem(id: UUID(), data: .empty))
        }
    }

    private func getDividerViewItem() -> ViewItem {
        ViewItem(id: UUID(), data: .divider(height: Dimens.xlarge))
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
