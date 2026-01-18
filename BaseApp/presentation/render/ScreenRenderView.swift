//
//  ScreenRenderView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import SwiftUI

struct ScreenRenderView: View {
    @Environment(\.theme) var theme

    var body: some View {
        NavigationStack {
            ScreenRenderListView()
                .navigationTitle("ScreenRender")
                .background(theme.background)
        }
    }
}
