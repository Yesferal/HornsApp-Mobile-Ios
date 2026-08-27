# Changelog

All notable releases of HornsApp and MuvinApp iOS.

Format based on [Keep a Changelog](https://keepachangelog.com/).  
Versioning follows [Semantic Versioning](https://semver.org/).

---

## [Unreleased]

### Added
- `AppDependencies` composition root for centralized DI (`#arch-1-app-dependencies`)
- Project documentation under `docs/`

### Changed
- Views resolve use cases from `@Environment(\.dependencies)` instead of inline wiring

---

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

[Unreleased]: ../todo/TODO.md
[1.0.1]: #101--2026-08-20
[1.0.0]: #100--2026-02
