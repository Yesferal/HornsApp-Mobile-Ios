//
//  AppDependenciesKey.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 8/23/26.
//

import SwiftUI

struct AppDependenciesKey: EnvironmentKey {
    @MainActor static let defaultValue = AppDependencies()
}

extension EnvironmentValues {
    var dependencies: AppDependencies {
        get { self[AppDependenciesKey.self] }
        set { self[AppDependenciesKey.self] = newValue }
    }
}
