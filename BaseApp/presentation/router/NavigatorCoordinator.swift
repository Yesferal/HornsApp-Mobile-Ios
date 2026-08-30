//
//  NavigatorCoordinator.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 8/30/26.
//

import HornsAppCore

enum NavParams {
    static let androidUri = "param_android_uri"
    static let parcelableViewData = "param_parcelable_view_data"
}

protocol NavigatorAdapter {
    func navigate(navigator: Navigator, navigatorRender: NavigatorRender?, router: Router) -> Bool
}

struct AppNavigatorAdapter: NavigatorAdapter {
    func navigate(navigator: Navigator, navigatorRender: NavigatorRender?, router: Router) -> Bool {
        switch navigator.to {
        case ScreenRender.Type_.homeScreen:
            router.navigate(to: .home)
            return true
        case ScreenRender.Type_.upcomingScreen:
            router.navigate(to: .upcoming)
            return true
        case ScreenRender.Type_.favoriteScreen:
            router.navigate(to: .favorite)
            return true
        default:
            return false
        }
    }
}

struct ExternalNavigatorAdapter: NavigatorAdapter {
    func navigate(navigator: Navigator, navigatorRender: NavigatorRender?, router: Router) -> Bool {
        switch navigator.to {
        case ScreenRender.Type_.webViewScreen:
            guard let url = webURL(from: navigatorRender) else {
                return false
            }
            router.navigate(to: .web(url: url))
            return true
        default:
            return false
        }
    }

    private func webURL(from navigatorRender: NavigatorRender?) -> URL? {
        guard let stringUrl = (navigatorRender?.parameters[NavParams.androidUri] as? StringOrObject)?.getStringValue(),
              let url = URL(string: stringUrl) else {
            return nil
        }
        return url
    }
}

final class NavigatorCoordinator {
    private let adapters: [NavigatorAdapter]

    init(adapters: [NavigatorAdapter] = [AppNavigatorAdapter(), ExternalNavigatorAdapter()]) {
        self.adapters = adapters
    }

    func route(from navigatorRender: NavigatorRender?) -> Route? {
        guard let navigatorRender, let key = navigatorRender.key else {
            return nil
        }
        let navigator = Navigator.Builder()
            .to(to_: key)
            .with(navigatorRender: navigatorRender)
            .build()

        switch navigator.to {
        case ScreenRender.Type_.webViewScreen:
            guard let url = (navigatorRender.parameters[NavParams.androidUri] as? StringOrObject)?.getStringValue(),
                  let parsedURL = URL(string: url) else {
                return nil
            }
            return .web(url: parsedURL)
        case ScreenRender.Type_.favoriteScreen:
            return .favorite
        case ScreenRender.Type_.upcomingScreen:
            return .upcoming
        case ScreenRender.Type_.homeScreen:
            return .home
        default:
            return nil
        }
    }

    func navigate(from navigatorRender: NavigatorRender?, router: Router) {
        guard let navigatorRender, let key = navigatorRender.key else {
            return
        }
        let navigator = Navigator.Builder()
            .to(to_: key)
            .with(navigatorRender: navigatorRender)
            .build()

        for adapter in adapters {
            if adapter.navigate(navigator: navigator, navigatorRender: navigatorRender, router: router) {
                return
            }
        }
    }
}
