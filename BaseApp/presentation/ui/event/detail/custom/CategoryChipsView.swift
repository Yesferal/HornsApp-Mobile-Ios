//
//  CategoryPagerView.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/16/26.
//

import SwiftUI
import HornsAppCore

struct CategoryChipsView: View {
    let categories: [CategoryRender]
    
    @Binding var selectedCategory: CategoryRender?
    
    @Environment(\.theme) var theme
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Dimens.medium) {
                ForEach(categories, id: \._id) { category in
                    chip(for: category)
                }
            }
            .padding()
        }
        .frame(height: Dimens.xlarge * 2)
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
                }            }
    }
}
