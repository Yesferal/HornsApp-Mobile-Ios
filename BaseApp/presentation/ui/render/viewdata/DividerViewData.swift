//
//  IconHomeRow.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 12/9/25.
//

import SwiftUI

struct DividerViewData: View {
    let height: Int
    
    var body: some View {
        Color.clear
            .frame(height: CGFloat(height))
            .listRowSeparator(.hidden)
    }
}
