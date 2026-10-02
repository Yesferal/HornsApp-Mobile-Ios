# Tech Setup

Guide to clone, configure, build, and run the HornsApp iOS project from scratch.

---

## Prerequisites

| Tool | Version | Notes |
|------|---------|-------|
| macOS | Latest stable | Required for Xcode |
| Xcode | 16+ | iOS 17 SDK |
| CocoaPods | 1.15+ | `sudo gem install cocoapods` |
| Git | 2.x | |

**Optional (local core development):**

- Kotlin Multiplatform project at `../../Kotlin/HornsApp-Core` if you want to use the local pod path instead of the published pod.

---

## Project structure

```
HornsApp-Mobile-Ios/
├── BaseApp/              # Shared SwiftUI code (UI, DI, networking, SwiftData)
├── HornsApp/             # HornsApp target (assets, theme, app_render.json, AppSettings)
├── MuvinApp/             # Muvin target (assets, theme, app_render.json, AppSettings)
├── HornsApp.xcodeproj    # Xcode project (both targets)
├── HornsApp.xcworkspace  # Open this (not .xcodeproj) after pod install
├── Podfile               # CocoaPods dependencies
└── docs/                 # Project documentation
```

### Targets

| Target | Scheme | Bundle role |
|--------|--------|-------------|
| HornsApp | `HornsApp` | Main concert app — API path `concert` |
| MuvinApp | `Muvin` | White-label variant — API path `event` |

Both targets share `BaseApp/` and differ in:

- `AppSettings` (app name, API path)
- `Theme` colors
- Assets (icons, onboarding image)
- `resources/app_render.json`

---

## First-time setup

### 1. Clone the repository

```bash
git clone <repository-url>
cd HornsApp-Mobile-Ios
```

### 2. Install CocoaPods dependencies

```bash
pod install
```

If pods fail to resolve, update the spec repos:

```bash
pod repo update
pod install
```

**HornsAppCore** is pulled from the custom spec repo:

```
https://github.com/Yesferal/HornsApp-PodSpecs.git
```

Current pinned version: `~> 1.5.0` (see `Podfile`).

### 3. Open the workspace

Always open the **workspace**, not the project:

```bash
open HornsApp.xcworkspace
```

### 4. Select a scheme and run

| App | Scheme | Simulator |
|-----|--------|-----------|
| HornsApp | `HornsApp` | Any iOS 17+ simulator |
| Muvin | `Muvin` | Any iOS 17+ simulator |

Press **Cmd + R** to build and run.

---

## Build from CLI

```bash
# HornsApp
xcodebuild -workspace HornsApp.xcworkspace -scheme HornsApp -sdk iphonesimulator build

# MuvinApp
xcodebuild -workspace HornsApp.xcworkspace -scheme Muvin -sdk iphonesimulator build
```

---

## Dependencies (Podfile)

| Pod | Purpose |
|-----|---------|
| `HornsAppCore ~> 1.5.0` | Shared KMP business logic (use cases, domain models, repositories) |
| `Alamofire ~> 5.10.2` | HTTP client for concert/event API |

### Using local HornsAppCore (optional)

Uncomment in `Podfile`:

```ruby
#pod 'HornsAppCore', :path => '../../Kotlin/HornsApp-Core'
```

Then run `pod install` again.

---

## Configuration per app

Each target defines its own `AppSettings`:

**HornsApp** (`HornsApp/presentation/environment/AppSettings.swift`):

```swift
struct AppSettings {
    let appName = "HornsApp"
    let homePath = "concert"
    let socialLinks: [AppSocialLink] = [/* Instagram, TikTok, Facebook, Spotify */]
}
```

**MuvinApp** (`MuvinApp/presentation/environment/AppSettings.swift`):

```swift
struct AppSettings {
    let appName = "Muvin"
    let homePath = "event"
    let socialLinks: [AppSocialLink] = [/* Instagram, TikTok, Facebook, Spotify */]
}
```

API base URL and authorization come from the KMP layer via `hapk_wrapper()` using `appName`.

---

## Localization

- Strings: `BaseApp/Localizable.xcstrings` (EN / ES)
- Info.plist permission strings: `BaseApp/en.lproj/InfoPlist.strings`, `BaseApp/es.lproj/InfoPlist.strings`

---

## Server-driven UI config

Home layout is defined in bundled JSON:

- HornsApp: `HornsApp/resources/app_render.json`
- MuvinApp: `MuvinApp/resources/app_render.json`

Read at runtime by `HaFileReaderManager` → `BundledRenderRemoteDataSource` → render repository.

---

## Troubleshooting

### `HornsApp.xcworkspace` not found

Run `pod install` first. CocoaPods generates the workspace.

### Pod install fails on HornsAppCore

Ensure you have access to the custom spec repo and network connectivity:

```bash
pod repo add hornsapp-specs https://github.com/Yesferal/HornsApp-PodSpecs.git
pod install
```

### Signing errors on device

Configure your Team ID and provisioning profiles in Xcode → Target → Signing & Capabilities.

### SwiftData / ModelContext issues

The app uses `@Environment(\.modelContext)` and `.modelContainer(for: SwiftDataConcert.self)` in `Application.swift`. Always test on iOS 17+.

---

## Adding a new white-label app (outline)

1. Duplicate target in Xcode (e.g. from `MuvinApp`)
2. Add target to `Podfile` under `abstract_target 'SharedPods'`
3. Create app folder with `AppSettings`, `ThemeExt`, assets, and `app_render.json`
4. Run `pod install`
5. Configure signing, bundle ID, and App Store metadata

See [Architecture](./ARCHITECTURE.md) for code conventions when extending shared `BaseApp/` code.
