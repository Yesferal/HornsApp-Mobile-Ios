//
//  VerticalDashLine.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/26/25.
//

import SwiftUI

struct HaVerticalDashLine: View {
    var body: some View {
        Rectangle()
            .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [2, 5]))
            .frame(width: 0.5)
            .foregroundColor(.gray)
    }
}
