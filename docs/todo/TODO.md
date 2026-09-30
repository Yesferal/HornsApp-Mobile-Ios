# TODO Backlog

Living task list for HornsApp iOS. See [README](./README.md) for how to use task keys.

**Last updated:** 2026-09-29

> **App Store:** Rejected 3× under **Guideline 4.2** (Minimum Functionality). See [App Store 4.2 plan](#store-app-review-42) — tackle `#store-*` tasks before the next submission.

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
| [x] | [`#feat-2-related-events`](#feat-2-related-events) | Wire related events on event detail |
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
| [ ] | [`#qual-5-naming-cleanup`](#qual-5-naming-cleanup) | File/type naming cleanup (Phase 1–2 done) |
| [ ] | [`#qual-6-voiceover`](#qual-6-voiceover) | Enable VoiceOver (labels, traits, audit) |

### App Store — Guideline 4.2 (Minimum Functionality)

Rejected on **iPad Air 11-inch** (v1.0.1). Goal: more **native depth** and **discoverable content**, not a thin event browser.

| Priority | Status | Key | Task |
|----------|--------|-----|------|
| P0 | [x] | [`#store-2-event-about`](#store-2-event-about) | Show event description on detail (API already returns `about`) |
| P0 | [x] | [`#feat-2-related-events`](#feat-2-related-events) | Related events on detail (currently hardcoded `[]`) |
| P0 | [x] | [`#store-3-empty-states`](#store-3-empty-states) | Empty states for Favorites, Upcoming, no results |
| P0 | [x] | [`#store-4-share-event`](#store-4-share-event) | Native Share sheet on event detail |
| P0 | [x] | [`#store-6-ipad-layout`](#store-6-ipad-layout) | iPad-adaptive layout (review device was iPad) |
| P0 | [~] | [`#store-8-att-onboarding`](#store-8-att-onboarding) | ATT on Get Started (ads planned); keep purpose string accurate |
| P1 | [ ] | [`#store-5-search`](#store-5-search) | Search concerts by name / headliner |
| P1 | [ ] | [`#store-7-settings-about`](#store-7-settings-about) | Settings / About screen (language, notifications, contact) |
| P1 | [ ] | [`#feat-3-carousel-cta`](#feat-3-carousel-cta) | Visible native carousel actions (calendar / favorite) |
| P2 | [ ] | [`#feat-1-lineup`](#feat-1-lineup) | Full lineup from API (section exists, model stubbed) |
| P2 | [ ] | [`#store-9-review-packaging`](#store-9-review-packaging) | Review notes, screenshots, App Store description |

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

**Status:** done · **App Store P0** (`#store-app-review-42`)

- **KMP:** `GetRelatedConcertsUseCase` + unit tests (HornsAppCore 1.6.0)
- **iOS:** `EventDetailViewModel` loads catalog after detail success and fills `RelatedEventSection`

Related events = concerts that share ≥1 category with the open event (exclude self, sort by date, take 4).

**Files:** `GetRelatedConcertsUseCase.kt`, `EventDetailViewModel.swift`, `EventDetailView.swift`, `Podfile` (local path while developing)

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

**Files:** `HaFileReaderManager.swift`, `BundledRenderRemoteDataSource.swift`

---

### `#qual-5-naming-cleanup`

**Status:** partial (Phase 1–2 done)

**Done:**
- `DetailView` → `EventDetailView` (+ `EventDetailViewBody`)
- `UpcomingList` → `UpcomingListView`
- `HaTittleSubTittle` → `HaTitleSubtitle`
- `SocketManager` → `BundledRenderRemoteDataSource`
- Fixed stale file headers on touched files

**Remaining (Phase 3):** Optional `*ViewData` naming convention review; batch-fix remaining stale headers in alamofire render mappers.

**Files:** `EventDetailView.swift`, `UpcomingListView.swift`, `HaTitleSubtitle.swift`, `BundledRenderRemoteDataSource.swift`, `AppDependencies.swift`, detail components, docs

---

### `#qual-6-voiceover`

**Status:** pending

Enable and polish **VoiceOver** across main flows (Home, Upcoming, Favorites, Event detail, Onboarding):

- Meaningful `accessibilityLabel` / hints on icon-only controls (favorite heart, share, calendar CTA, map/ticket chevrons, category chips)
- Correct traits (button, header, selected) and grouping so timeline rows read as one element where useful
- Audit with VoiceOver on **iPhone + iPad**; fix focus order and decorative images (`accessibilityHidden`)
- Add/restore localized a11y strings only where the spoken label differs from visible text

**Files:** detail sections (`EventAboutSection`, `HaEventLink`, `FavoriteButton`, …), list/home view data, `Localizable.xcstrings`

---

## App Store 4.2 plan

### `#store-app-review-42`

**Status:** in progress

Apple rejected v1.0.1 on **iPad** citing **Guideline 4.2 — Minimum Functionality**: the app feels too thin — limited content, weak native value, not sufficiently “app-like.”

**What a reviewer likely saw today:**

| Screen | Problem |
|--------|---------|
| Home | SDUI list + cards; several actions push tabs or web |
| Event detail | Calendar / maps / tickets work, but **no event description**, **no related events**, lineup is shallow |
| Favorites | Works, but **no empty-state guidance** when list is empty |
| Upcoming | Category chips OK; thin if few events |
| Onboarding | Asks for **ad tracking (ATT)** before the user sees value |
| iPad | Phone layout stretched on 11-inch display — looks like a placeholder |

**Strategy (no pivot):** Stay a concert companion app. Add **visible depth** and **native iOS utilities** Apple can exercise in review without relying on external web.

**Resubmit order:** P0 tasks → TestFlight on **iPad + iPhone** → P1 → `#store-9-review-packaging`.

**App Store Connect reply (after P0):** List native features: favorites, local reminders, calendar, maps picker, category filters, share, search, rich event detail.

---

### `#store-2-event-about`

**Status:** done

Display `Concert.about` on event detail. Data is fetched (`GetEventDetail`) but never shown in UI.

**Files:** `EventAboutSection.swift`, `EventDetailView.swift`, `Localizable.xcstrings`

---

### `#store-3-empty-states`

**Status:** done

Illustrated empty states with clear CTAs:

- **Favorites:** “No favorites yet” + Browse upcoming CTA
- **Upcoming:** message when list or category filter is empty (+ clear filter)
- **Errors:** existing retry path unchanged

**Files:** `EmptyStateView.swift`, `FavoriteListView.swift`, `UpcomingListView.swift`, `Localizable.xcstrings`

---

### `#store-4-share-event`

**Status:** done

Toolbar ShareLink on event detail — shares name, date, venue, ticketing URL.

**Files:** `EventDetailView.swift`, `Localizable.xcstrings`

---

### `#store-5-search`

**Status:** pending

Search upcoming/home concerts by event name or headliner. Can start client-side filter on loaded list; server search later if needed.

**Files:** `UpcomingView.swift` / `UpcomingListView.swift`, optionally `ScreenRenderListView.swift`, `Localizable.xcstrings`

---

### `#store-6-ipad-layout`

**Status:** done

Review was on **iPad Air 11-inch**.

1. **Readable width** — `readableContentWidth()` (max ~720pt on regular size class) on list/detail/onboarding/empty roots so content doesn’t stretch edge-to-edge.
2. **NavigationSplitView** — on regular size class, `HomeView` uses a sidebar (Home / Upcoming / Favorite) + detail `NavigationStack`. Compact (iPhone) keeps `TabView`.

**How readable width works:** `ReadableContentWidth` ViewModifier — on `.regular`, `frame(maxWidth: 720)` then `frame(maxWidth: .infinity)` to center; on `.compact`, full width. Prefer one call on the screen root (list/scroll), not per row.

**Docs:** comments in `ReadableContentWidth.swift`; [ARCHITECTURE.md](../ARCHITECTURE.md) → Theming / App entry.

**Files:** `HomeView.swift`, `Application.swift`, `ReadableContentWidth.swift`, `ScreenRenderListView.swift`, `EventDetailView.swift`, `FavoriteListView.swift`, `UpcomingListView.swift`, `OnboardingView.swift`, `EmptyStateView.swift`

---

### `#store-7-settings-about`

**Status:** pending

User-facing Settings (not Android dev settings): app version, language note, open Notification Settings, About HornsApp, contact / feedback link. Entry via toolbar or SDUI `SETTING_SCREEN` when ready.

**Files:** new `SettingsView.swift`, `Route.swift`, `NavigatorCoordinator.swift`, `Localizable.xcstrings`

---

### `#store-8-att-onboarding`

**Status:** in progress (product choice)

ATT is requested on **Get Started** again because personalized ads are planned and `NSUserTrackingUsageDescription` is in Info.plist. Onboarding finishes **after** the system prompt so the alert can show.

**Review risk:** 4.2 previously flagged ATT before the user sees app value. Mitigate by shipping ads soon and keeping the usage description accurate. Alternative later: move ATT to first ad load / Settings.

**Files:** `OnboardingView.swift`, `HornsApp-Info.plist`, `Muvin-Info.plist`

---

### `#store-9-review-packaging`

**Status:** pending

Non-code submission checklist:

- Refresh screenshots (detail with about + related, favorites, reminders, iPad layout)
- App Review notes: step-by-step path to demonstrate native features
- Description highlights: “save favorites, reminders, calendar, filters, share”
- Confirm demo API has enough events for review

**Files:** App Store Connect only (+ optional `docs/APP_REVIEW_NOTES.md`)

---
