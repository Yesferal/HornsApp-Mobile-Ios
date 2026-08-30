# TODO Backlog

Living task list for HornsApp iOS. See [README](./README.md) for how to use task keys.

**Last updated:** 2026-08-30

---

## Summary

### Foundation

| Status | Key | Task |
|--------|-----|------|
| [x] | [`#arch-1-app-dependencies`](#arch-1-app-dependencies) | Create `AppDependencies` composition root |
| [x] | [`#arch-2-fix-network-errors`](#arch-2-fix-network-errors) | Fix network layer error handling |
| [x] | [`#arch-3-standardize-viewmodels`](#arch-3-standardize-viewmodels) | Standardize ViewModels (init injection + `ViewState<T>`) |
| [ ] | [`#arch-4-screen-render-mapper`](#arch-4-screen-render-mapper) | Extract `ScreenRenderMapper` |
| [ ] | [`#arch-5-unit-tests`](#arch-5-unit-tests) | Add ViewModel and mapper unit tests |

### Features

| Status | Key | Task |
|--------|-----|------|
| [ ] | [`#feat-1-lineup`](#feat-1-lineup) | Implement Lineup feature |
| [ ] | [`#feat-2-related-events`](#feat-2-related-events) | Wire related events on event detail |
| [ ] | [`#feat-3-carousel-cta`](#feat-3-carousel-cta) | Native carousel CTA |
| [ ] | [`#feat-4-concert-cache`](#feat-4-concert-cache) | Concert cache in SwiftData |
| [ ] | [`#feat-5-dynamic-tabs`](#feat-5-dynamic-tabs) | Dynamic tabs from render config |

### Quality

| Status | Key | Task |
|--------|-----|------|
| [ ] | [`#qual-1-logging`](#qual-1-logging) | Logging abstraction |
| [ ] | [`#qual-2-localization`](#qual-2-localization) | Fix remaining localization gaps |
| [x] | [`#qual-3-favorite-rollback`](#qual-3-favorite-rollback) | Revert favorite toggle on failure |
| [ ] | [`#qual-4-remote-render`](#qual-4-remote-render) | Remote SDUI render updates |
| [ ] | [`#qual-5-naming-cleanup`](#qual-5-naming-cleanup) | File/type naming cleanup |

---

## Task details

### `#arch-1-app-dependencies`

**Status:** done

Centralize dependency wiring in `BaseApp/di/AppDependencies.swift`. Inject via `Application` → `.environment(\.dependencies)`.

**Files:** `AppDependencies.swift`, `AppDependenciesKey.swift`, `Application.swift`, screen views.

---

### `#arch-2-fix-network-errors`

**Status:** done

`AlamoFireWrapper` now returns `HaResultError.shared` on API failure. `mapCoreResultAsUiResult` explicitly handles `HaResultError` vs `HaResultSuccess`.

**Files:** `AlamoFireWrapper.swift`, `UiResult.swift`

---

### `#arch-3-standardize-viewmodels`

**Status:** done

All ViewModels use init injection (no optional `configure()`). All use `ViewState<T>` for loading/success/error. Views create ViewModels via init + `@StateObject` or `AppRootView` for the shared `FavoriteViewModel`.

**Files:** `EventDetailViewModel`, `UpcomingViewModel`, `FavoriteViewModel`, `ScreenRenderViewModel`, corresponding views, `Application.swift`

---

### `#arch-4-screen-render-mapper`

**Status:** pending

Extract `[ViewItem].addViewItem` from `ScreenRenderViewModel` into `ScreenRenderMapper`.

**Files:** `ScreenRenderViewModel.swift`, new `ScreenRenderMapper.swift`

---

### `#arch-5-unit-tests`

**Status:** pending

Add tests with mock use cases and mappers once DI is stable.

**Files:** `HornsAppTests/`

---

### `#feat-1-lineup`

**Status:** pending

Implement `GetLineup` model, enable `.addLineup()` in mapper, update `LineupSection`.

**Files:** `GetLineup.swift`, `GetEventDetail.swift`, `LineupSection.swift`

---

### `#feat-2-related-events`

**Status:** pending

Fetch and display related events in `RelatedEventSection` (currently always empty).

**Files:** `EventDetailView.swift`, `EventDetailViewModel.swift`

---

### `#feat-3-carousel-cta`

**Status:** pending

Add native carousel action (calendar or favorite). Ticket CTA is currently hidden.

**Files:** `CarouselViewData.swift`

---

### `#feat-4-concert-cache`

**Status:** pending

Implement `getConcertCached` / `updateConcertCached` in `SwiftDataManager`.

**Files:** `SwiftDataManager.swift`, `SwiftDataConcert.swift`

---

### `#feat-5-dynamic-tabs`

**Status:** pending

Drive `HomeView` tabs from `app_render.json` instead of hardcoded `TabView`.

**Files:** `HomeView.swift`, `app_render.json`

---

### `#qual-1-logging`

**Status:** pending

Replace `print()` and `// TODO: Logger` with a logging abstraction.

---

### `#qual-2-localization`

**Status:** pending

Fix hardcoded navigation titles and remaining non-localized strings.

**Files:** `ScreenRenderView.swift`, `FavoriteView.swift`, others

---

### `#qual-3-favorite-rollback`

**Status:** done

Revert `isFavorite` to the previous value when `UpdateFavoriteConcertUseCase` fails. Show alert to the user. Refresh favorites tab only after a successful update.

**Files:** `EventDetailViewModel.swift`, `EventDetailView.swift`, `HaAlert.swift`, `Localizable.xcstrings`

---

### `#qual-4-remote-render`

**Status:** pending

Implement `HaFileReaderManager.updateAppRender()` for live SDUI updates.

**Files:** `HaFileReaderManager.swift`, `SocketManager.swift`

---

### `#qual-5-naming-cleanup`

**Status:** pending

Align mismatched names: `DetailView` / `EventDetailView`, `UpcomingList`, `*ViewData`, `SocketManager`.

---
