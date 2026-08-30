//
//  MapApp.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 2/13/26.
//

import UIKit
import MapKit

enum MapApp: CaseIterable, Identifiable {
    case appleMaps
    case googleMaps
    case waze

    var id: Self { self }

    var displayName: String {
        switch self {
        case .appleMaps:
            return HaLocalizedStringWrapper.getString(key: "key_map_apple_maps")
        case .googleMaps:
            return HaLocalizedStringWrapper.getString(key: "key_map_google_maps")
        case .waze:
            return HaLocalizedStringWrapper.getString(key: "key_map_waze")
        }
    }

    var isAvailable: Bool {
        switch self {
        case .appleMaps:
            return true

        case .googleMaps:
            return UIApplication.shared.canOpenURL(
                URL(string: "comgooglemaps://")!
            )

        case .waze:
            return UIApplication.shared.canOpenURL(
                URL(string: "waze://")!
            )
        }
    }

    func open(location: MapLauncherManager.Location) {
        let lat = location.latitude
        let lng = location.longitude
        let name = location.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        switch self {

        case .appleMaps:
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let placemark = MKPlacemark(coordinate: coordinate)
            let item = MKMapItem(placemark: placemark)
            item.name = location.name
            item.openInMaps()

        case .googleMaps:
            let url = URL(string: "comgooglemaps://?q=\(name)&center=\(lat),\(lng)")!
            UIApplication.shared.open(url)

        case .waze:
            let url = URL(string: "waze://?ll=\(lat),\(lng)&navigate=yes")!
            UIApplication.shared.open(url)
        }
    }
}
