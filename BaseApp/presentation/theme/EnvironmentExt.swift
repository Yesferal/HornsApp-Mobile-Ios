//
//  EnvironmentExt.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 11/24/25.
//


import SwiftUI

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
