//
//  ReadableContentWidth.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 9/29/26.
//

import SwiftUI

/// Max content width on iPad (regular horizontal size class).
///
/// Phone (compact) stays full width. Regular uses this cap so lists and detail
/// don’t stretch edge-to-edge in landscape (App Store `#store-6-ipad-layout`).
private enum ReadableLayout {
    static let regularMaxWidth: CGFloat = 720
}

/// Centers content and caps its width on iPad.
///
/// Applies `maxWidth: 720` when `horizontalSizeClass == .regular`, then
/// `maxWidth: .infinity` so the block stays horizontally centered in the
/// parent. On compact (iPhone), content keeps full available width.
struct ReadableContentWidth: ViewModifier {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: horizontalSizeClass == .regular ? ReadableLayout.regularMaxWidth : .infinity)
            .frame(maxWidth: .infinity)
    }
}

extension View {
    /// Prefer applying once on a screen’s root scroll/list (or empty/error
    /// container), not on every child row — so titles and cards share one
    /// leading edge.
    ///
    /// **Used on:** Home (`ScreenRenderListView`), Upcoming, Favorites,
    /// Event detail, Onboarding, `EmptyStateView`.
    ///
    /// See `#store-6-ipad-layout` in `docs/todo/TODO.md`.
    func readableContentWidth() -> some View {
        modifier(ReadableContentWidth())
    }
}
