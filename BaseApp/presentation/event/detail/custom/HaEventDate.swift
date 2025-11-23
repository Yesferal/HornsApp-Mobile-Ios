//
//  HaEventDate.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/25/25.
//

import SwiftUI

struct HaEventDate: View {
    let day: String
    let month: String

    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(day)
                .foregroundColor(Color.red)
            Text(month)
        }
        .bold()
        .background(Color(.systemBackground))
        .frame(width: 48)
    }
}
