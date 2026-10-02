//
//  AppSettings.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/12/25.
//

import Foundation

struct AppSettings {
    let appName = "Muvin"
    let homePath = "event"
    /// Official profiles — shown in Settings only (not home `app_render` web CTAs).
    let socialLinks: [AppSocialLink] = [
        AppSocialLink(
            network: .instagram,
            handle: "muvinapp.pe",
            url: URL(string: "https://www.instagram.com/muvinapp.pe/")!
        ),
        AppSocialLink(
            network: .tiktok,
            handle: "muvinapp",
            url: URL(string: "https://www.tiktok.com/@muvinapp")!
        ),
        AppSocialLink(
            network: .facebook,
            handle: "muvinapp.pe",
            url: URL(string: "https://www.facebook.com/muvinapp.pe")!
        ),
        AppSocialLink(
            network: .spotify,
            handle: "HornsApp",
            url: URL(string: "https://open.spotify.com/user/vhx70zw6rpz3qm8u2fsplhwg1")!
        ),
    ]
}
