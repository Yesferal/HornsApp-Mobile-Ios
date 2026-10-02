//
//  AppSocialLink.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/2/26.
//

import SwiftUI

/// Official social profile for Settings (`#store-7`). Kept out of home `app_render` web CTAs.
struct AppSocialLink: Identifiable {
    enum Network: String {
        case instagram
        case tiktok
        case facebook
        case spotify
        case youtube
    }

    let network: Network
    /// Display handle (no @).
    let handle: String
    let url: URL

    var id: String { network.rawValue }

    var titleLocalizationKey: String {
        switch network {
        case .instagram: return "settings_social_instagram"
        case .tiktok: return "settings_social_tiktok"
        case .facebook: return "settings_social_facebook"
        case .spotify: return "settings_social_spotify"
        case .youtube: return "settings_social_youtube"
        }
    }

    var systemImage: String {
        switch network {
        case .instagram: return "camera"
        case .tiktok: return "music.note"
        case .facebook: return "person.2"
        case .spotify: return "music.note.list"
        case .youtube: return "play.rectangle"
        }
    }
}
