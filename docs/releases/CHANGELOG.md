# Changelog

All notable releases of HornsApp and MuvinApp iOS.

Format based on [Keep a Changelog](https://keepachangelog.com/).  
Versioning follows [Semantic Versioning](https://semver.org/).

---

## [Unreleased]

### Added
- `AppDependencies` composition root for centralized DI (`#arch-1-app-dependencies`)
- Project documentation under `docs/` (Setup, Architecture, **ROADMAP**)
- Related events on detail via KMP `GetRelatedConcertsUseCase` (shared categories) (`#feat-2-related-events`)
- Event detail shows About section from API (`#store-2-event-about`)
- Empty states for Favorites and Upcoming (filter + clear) (`#store-3-empty-states`)
- Native Share on event detail toolbar (`#store-4-share-event`)
- iPad adaptive layout (`#store-6-ipad-layout`):
  - `readableContentWidth()` (~720pt) on list / detail / onboarding / empty roots
  - `NavigationSplitView` sidebar (Home / Upcoming / Favorite) + detail stack on regular size class; `TabView` on iPhone
- Upcoming search by event name or artist (`#store-5-search`): circular search control expands in-place over category chips (filters the same list)
- About row favorite CTA (pink heart button, same chrome as former Save-date `+`)

### Changed
- Views resolve use cases from `@Environment(\.dependencies)` instead of inline wiring
- Network failures propagate as `HaResultError` instead of success-with-nil (`#arch-2-fix-network-errors`)
- ViewModels standardized: init injection + `ViewState<T>` everywhere (`#arch-3-standardize-viewmodels`)
- Upcoming and Favorites screens show error UI with retry on network failure
- Favorite toggle reverts and shows alert when persistence fails (`#qual-3-favorite-rollback`)
- Home SDUI mapping extracted to `ScreenRenderMapper` (`#arch-4-screen-render-mapper`)
- Navigation aligned with Android/KMP: `NavigatorCoordinator`, shared app-level `Router` (`#arch-6a`, `#arch-6c`). Tab switching deferred (`#arch-6b`).
- Localization gaps fixed: tab labels, map picker, detail sections (`#qual-2-localization`)
- Naming cleanup Phase 1–2: `EventDetailView`, `UpcomingListView`, `HaTitleSubtitle`, `BundledRenderRemoteDataSource` (`#qual-5-naming-cleanup`)
- Local `HornsAppCore` path pod for Core 1.6.0 development (switch back after publish)
- Event detail section order: About → Save date / Maps / Tickets → Reminders → Activities → Related
- About laid out like other detail rows (info icon + title + description) with heart CTA on the trailing edge
- Save date uses chevron row (`HaEventLink`) like Maps / Tickets (no pink `+` button)
- Onboarding does **not** prompt for ATT yet; `#store-8` (ATT + ads) waits until ≥1 App Store version is live
- Backlog tracking: Bet-style `docs/ROADMAP.md` (Active / Next / **Depends on**); removed `docs/todo/`

### Fixed
- iPad list/detail alignment: constrain whole screen roots with `readableContentWidth()` so titles and cards share one leading edge
- About body text aligns with Maps / Tickets text column; section titles stay on the timeline like Related Events

## [1.0.1] — 2026-08-20

**Build:** 2 · **HornsAppCore:** ~1.5.0

### Added
- Activities section on event detail
- Notification reminders (1 day / 2 hours before event)
- Category filter chips on Upcoming screen

### Changed
- Event detail primary CTA: add to calendar (replacing buy button)
- Updated calendar copy and InfoPlist localized permission strings
- Bumped HornsAppCore to 1.5.0

### Fixed
- Activity card two-line text layout
- Favorite navigation from home render config
- Upcoming card view filter

### Removed / Hidden
- Carousel ticket CTA temporarily hidden

---

## [1.0.0] — 2026-02

**HornsAppCore:** earlier 1.x

### Added
- Onboarding flow with ATT permission
- Home screen with server-driven UI (`app_render.json`)
- Upcoming events list with date sorting
- Event detail: maps, ticketing link, favorites
- Add event to calendar
- Favorites tab with SwiftData persistence
- Open in Maps (Apple Maps, Google Maps, Waze)
- EN / ES localization
- MuvinApp white-label target

---

## Version matrix

| App version | Build | HornsAppCore | Notes |
|-------------|-------|--------------|-------|
| 1.0.1 | 2 | ~1.5.0 | Current release |
| 1.0.0 | 1 | ~1.4.x | Initial App Store release |

---

[Unreleased]: ../ROADMAP.md
[1.0.1]: #101--2026-08-20
[1.0.0]: #100--2026-02
