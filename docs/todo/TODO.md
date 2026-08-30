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
| [x] | [`#arch-4-screen-render-mapper`](#arch-4-screen-render-mapper) | Extract `ScreenRenderMapper` |
| [ ] | [`#arch-5-unit-tests`](#arch-5-unit-tests) | Add ViewModel and mapper unit tests |
| [ ] | [`#arch-6-unify-navigation`](#arch-6-unify-navigation) | Align iOS navigation with Android/KMP adapter pattern |

#### `#arch-6-unify-navigation` subtasks

| Status | Key | Task |
|--------|-----|------|
| [x] | [`#arch-6a-navigator-coordinator`](#arch-6a-navigator-coordinator) | `NavigatorCoordinator` + adapter chain (App / External) |
| [ ] | [`#arch-6b-tab-switching`](#arch-6b-tab-switching) | Tab switch for home / upcoming / favorite (partial — no per-tab stack yet) |
| [x] | [`#arch-6c-remove-duplicate-router`](#arch-6c-remove-duplicate-router) | Remove duplicate `Router` in `ScreenRenderView` |
| [ ] | [`#arch-6d-nav-view-data`](#arch-6d-nav-view-data) | `NavViewData` for concert/detail taps via KMP `Navigator` |
| [ ] | [`#arch-6e-external-actions`](#arch-6e-external-actions) | Calendar, maps, share via `ExternalNavigatorAdapter` |
| [ ] | [`#arch-6f-screen-type-coverage`](#arch-6f-screen-type-coverage) | Map remaining `ScreenRender.Type` values (settings, lineup, …) |

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
| [x] | [`#qual-2-localization`](#qual-2-localization) | Fix remaining localization gaps |
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

**Status:** done

Moved SDUI-to-`ViewItem` mapping from `[ViewItem]` extension on `ScreenRenderViewModel` into `ScreenRenderMapper`. ViewModel injects mapper (default instance) and calls `mapper.map(views:events:)`.

**Files:** `ScreenRenderMapper.swift`, `ScreenRenderViewModel.swift`

---

### `#arch-5-unit-tests`

**Status:** pending

Add tests with mock use cases and mappers once DI is stable.

**Files:** `HornsAppTests/`

---

### `#arch-6-unify-navigation`

**Status:** in progress

Align iOS navigation with the Android adapter chain and KMP `Navigator` / `NavigatorRender` model. iOS keeps `Router` + `Route` as the SwiftUI execution layer; mapping and tab-vs-push decisions move to `NavigatorCoordinator`.

**Reference:** Android `AppNavigator` → `DialogNavigator` → `ExternalNavigator`; KMP `Navigator.Builder().to(key).with(render).build()`.

**Subtasks:** `#arch-6a` … `#arch-6f` (see summary table above).

---

### `#arch-6a-navigator-coordinator`

**Status:** done

Introduce `NavigatorCoordinator` with `AppNavigatorAdapter` (in-app screens + tabs) and `ExternalNavigatorAdapter` (web). Move `ScreenRenderMapper.getRoute()` logic into the coordinator.

**Files:** `NavigatorCoordinator.swift`, `ScreenRenderMapper.swift`

---

### `#arch-6b-tab-switching`

**Status:** partial

Tab routes (`.home`, `.upcoming`, `.favorite`) switch `TabView` selection instead of pushing duplicate screens on `NavigationPath`. Does **not** clear the push stack yet — full per-tab stack design still pending.

**Files:** `Router.swift`, `HomeTab.swift`, `HomeView.swift`, `Route.swift`

---

### `#arch-6c-remove-duplicate-router`

**Status:** done

`ScreenRenderView` creates its own `@StateObject Router()` — remove it; use the app-level `Router` from `environmentObject`.

**Files:** `ScreenRenderView.swift`

---

### `#arch-6d-nav-view-data`

**Status:** pending

Route concert/carousel taps through KMP `Navigator` + `param_parcelable_view_data` instead of hardcoded `.details(...)`.

**Files:** `CarouselViewData.swift`, `UpcomingViewData.swift`, `UpcomingCompactViewData.swift`, new `NavViewData.swift`

---

### `#arch-6e-external-actions`

**Status:** pending

Handle `CALENDAR_SCREEN`, `MAP_SCREEN`, `MESSAGE_SCREEN` in `ExternalNavigatorAdapter` using existing iOS managers.

**Files:** `NavigatorCoordinator.swift`, `CalendarManager.swift`, `MapApp.swift`

---

### `#arch-6f-screen-type-coverage`

**Status:** pending

Add iOS handling for settings, lineup, profile, render screen, etc. Blocked partially by `#feat-1-lineup` and missing screens.

**Files:** `NavigatorCoordinator.swift`, `Route.swift`

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

Drive `HomeView` tabs from `app_render.json` instead of hardcoded `TabView`. Depends on `#arch-6b-tab-switching` tab infrastructure.

**Files:** `HomeView.swift`, `app_render.json`

---

### `#qual-1-logging`

**Status:** pending

Replace `print()` and `// TODO: Logger` with a logging abstraction.

---

### `#qual-2-localization`

**Status:** done

Removed stale FIXME comments. Standardized SwiftUI strings on `LocalizedStringKey`. Localized map app picker names. Documented when to use `HaLocalizedStringWrapper` vs `LocalizedStringKey`.

**Files:** `Localizable.xcstrings`, `HomeView.swift`, `ScreenRenderView.swift`, `FavoriteView.swift`, `EventDetailView.swift`, detail sections, `MapApp.swift`, `HaLocalizedStringWrapper.swift`

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
