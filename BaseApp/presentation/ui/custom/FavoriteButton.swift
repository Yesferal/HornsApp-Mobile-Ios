//
//  FavoriteButton.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/1/26.
//

import SwiftUI

struct FavoriteButton: View {
    
    @Environment(\.theme) var theme
    
    var isFavorite: Bool
    let action: (Bool) -> Void
    
    var body: some View {
        Button(action: {
            action(isFavorite)
        }, label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? theme.accent : theme.secondaryText)
        })
    }
}
