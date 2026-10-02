//
//  AppSettings.swift
//  HornsApp
//
//  Created by Yesferal Cueva on 10/12/25.
//

import Foundation

struct AppSettings {
    let appName = "HornsApp"
    let homePath = "concert"
    /// Official profiles — shown in Settings only (not home `app_render` web CTAs).
    let socialLinks: [AppSocialLink] = [
        AppSocialLink(
            network: .instagram,
            handle: "hornsapp.pe",
            url: URL(string: "https://www.instagram.com/hornsapp.pe/")!
        ),
        AppSocialLink(
            network: .tiktok,
            handle: "hornsapp.pe",
            url: URL(string: "https://www.tiktok.com/@hornsapp.pe")!
        ),
        AppSocialLink(
            network: .facebook,
            handle: "HornsApp",
            url: URL(string: "https://www.facebook.com/profile.php?id=100090226749195")!
        ),
        AppSocialLink(
            network: .spotify,
            handle: "HornsApp",
            url: URL(string: "https://open.spotify.com/user/vhx70zw6rpz3qm8u2fsplhwg1")!
        ),
    ]
}
