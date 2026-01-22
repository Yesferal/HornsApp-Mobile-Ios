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
        ScreenRenderListView()
            .navigationTitle("ScreenRender")
            .background(theme.background)
    }
}
