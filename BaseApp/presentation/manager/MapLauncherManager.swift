//
//  MapLauncher.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/13/26.
//

import SwiftUI
import MapKit

struct MapLauncherManager {

    struct Location {
        let name: String
        let latitude: Double
        let longitude: Double
    }

    static func availableApps(for location: Location) -> [MapApp] {
        MapApp.allCases.filter { $0.isAvailable }
    }

    static func open(_ app: MapApp, location: Location) {
        app.open(location: location)
    }
}
