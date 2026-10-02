//
//  CategoryChipsView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/16/26.
//

import SwiftUI
import HornsAppCore

struct CategoryChipsView: View {
    let categories: [CategoryRender]

    @Binding var selectedCategory: CategoryRender?
    /// `false`: magnifier + category chips. `true`: field replaces chips until dismissed.
    @Binding var isSearching: Bool
    @Binding var searchText: String

    @Environment(\.theme) var theme
    @FocusState private var isFieldFocused: Bool

    var body: some View {
        // Match UpcomingViewData: `.padding()` + 48pt date column, then Dimens.medium gap.
        HStack(alignment: .center, spacing: Dimens.medium) {
            if isSearching {
                // Same leading seat as open — mode toggle, not trailing Cancel.
                GlassCircleButton(
                    systemName: "xmark",
                    accessibilityLabel: "key_cancel"
                ) {
                    searchText = ""
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isSearching = false
                    }
                }
                .frame(width: 48)
                searchField
            } else {
                GlassCircleButton(
                    systemName: "magnifyingglass",
                    accessibilityLabel: "search_title"
                ) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isSearching = true
                    }
                }
                .frame(width: 48)
                categoryScroll
            }
        }
        .padding(.leading, Dimens.medium)
        .padding(.trailing, isSearching ? Dimens.medium : 0)
        .frame(height: Dimens.xlarge * 2)
        .onChange(of: isSearching) { _, searching in
            isFieldFocused = searching
        }
    }

    private var categoryScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Dimens.medium) {
                ForEach(categories, id: \._id) { category in
                    chip(for: category)
                }
            }
            .padding(.vertical)
            .padding(.trailing, Dimens.medium)
        }
    }

    /// Inside the capsule: field + optional clear + active category chip (same as chip row).
    private var searchField: some View {
        HStack(spacing: Dimens.small) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(theme.accent)

            TextField(
                "",
                text: $searchText,
                prompt: Text(LocalizedStringKey("search_events_prompt"))
            )
            .focused($isFieldFocused)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(theme.secondaryText)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(LocalizedStringKey("empty_upcoming_clear_search"))
            }

            if let selectedCategory {
                // Same chip as the category row; fixedSize so TextField can't crush it.
                chip(for: selectedCategory)
                    .fixedSize()
            }
        }
        .padding(.horizontal, Dimens.medium)
        .padding(.vertical, Dimens.small)
        .background(.ultraThinMaterial, in: Capsule())
        .overlay {
            Capsule()
                .strokeBorder(theme.secondaryText.opacity(0.25), lineWidth: 1)
        }
    }

    private func chip(for category: CategoryRender) -> some View {
        let isSelected = selectedCategory?._id == category._id

        return Text(category.name?.text ?? "")
            .font(.subheadline)
            .padding(.horizontal, Dimens.medium)
            .padding(.vertical, Dimens.small)
            .foregroundColor(isSelected ? theme.accent : theme.secondaryText)
            .background(
                Capsule()
                    .stroke(
                        isSelected ? theme.accent : theme.secondaryText,
                        lineWidth: 2
                    )
            )
            .onTapGesture {
                if selectedCategory?._id == category._id {
                    selectedCategory = nil
                } else {
                    selectedCategory = category
                }
            }
    }
}
