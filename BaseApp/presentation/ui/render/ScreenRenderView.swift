//
//  ScreenRenderView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import SwiftUI

struct ScreenRenderView: View {
    @Environment(\.theme) var theme

    @StateObject private var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            ScreenRenderListView()
                .environmentObject(router)
                .navigationDestination(for: Route.self) { route in
                    destination(for: route)
                }
                .navigationTitle("ScreenRender")
                .background(theme.background)
        }
    }
}
