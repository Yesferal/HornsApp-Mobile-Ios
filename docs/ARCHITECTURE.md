# Architecture

Overview of how HornsApp iOS is structured, which patterns are used, and how to extend the app safely.

---

## High-level design

The app follows **Clean Architecture with a Kotlin Multiplatform shared core**:

```
┌─────────────────────────────────────────────────────────┐
│  SwiftUI (Views, ViewModels, Navigation, Theme)         │
│  BaseApp/presentation/                                  │
├─────────────────────────────────────────────────────────┤
│  Platform adapters (Alamofire, SwiftData, JSON file)    │
│  BaseApp/framework/ + BaseApp/di/                       │
├─────────────────────────────────────────────────────────┤
│  HornsAppCore (KMP) — Use Cases, Repositories, Models   │
└─────────────────────────────────────────────────────────┘
```

**Why this split:** business rules live in KMP and can be shared with Android. iOS only handles UI, platform APIs, and data-source implementations.

---

## App entry and navigation

```
Application
  └── NavigationStack (Router)
        └── ContentView
              ├── OnboardingView (first launch)
              └── HomeView (TabView — hardcoded tabs for now)
                    ├── Home tab    → ScreenRenderView
                    ├── Upcoming    → UpcomingView
                    └── Favorites   → FavoriteView
```

- **Router** (`BaseApp/presentation/router/`) — global `NavigationPath` for push navigation (detail, web). Tab routes (`.home`, `.upcoming`, `.favorite`) update `selectedTab` instead of pushing.
- **Route enum** — typed destinations consumed by `navigationDestination(for:)`. Tab routes must not be pushed; they switch `TabView` selection.
- **NavigatorCoordinator** — maps KMP `NavigatorRender` → `Route` via adapter chain (`AppNavigatorAdapter`, `ExternalNavigatorAdapter`). Tab-vs-push behavior is **deferred** (`#arch-6b-tab-switching`).

SDUI navigation flow:

```
NavigatorRender (from JSON)
  → NavigatorCoordinator.route(from:)  → Route? (embedded in ViewItem)
  → router.navigate(to:)               → tab switch OR push (detail / web)
```

Concert card taps still use direct `.details(...)` until `#arch-6d-nav-view-data`.

---

## Dependency injection

All infrastructure wiring goes through **`AppDependencies`** (`BaseApp/di/AppDependencies.swift`).

Created once in `Application` and injected via SwiftUI Environment:

```swift
.environment(\.dependencies, dependencies)
```

Views resolve use cases from the container:

```swift
@Environment(\.dependencies) var dependencies
@Environment(\.modelContext) var context

dependencies.makeGetConcertsUseCase(context: context)
```

**Rule:** do not construct `ConcertRepositoryImpl` or `AlamoFireWrapper` inside Views. Add a factory method to `AppDependencies` instead.

---

## Data layer

### Remote API

| Class | Role |
|-------|------|
| `AlamoFireWrapper` | Implements `ConcertRemoteDataSource` — fetches concerts/events |
| DTOs (`GetEvents`, `GetEventDetail`, …) | Decodable API models mapped to KMP `Concert` |

### Local render config (SDUI)

| Class | Role |
|-------|------|
| `HaFileReaderManager` | Reads bundled `app_render.json` |
| `SocketManager` | Implements `RenderRemoteDataSource` (local today; remote later) |

Home screen layout (carousels, cards, sections, navigation keys) is driven by JSON, not hardcoded SwiftUI.

### Local persistence

| Class | Role |
|-------|------|
| `SwiftDataManager` | Implements `ConcertStorageDataSource` |
| `SwiftDataConcert` | SwiftData model for **favorites** |

Concert list caching is planned but not yet implemented.

---

## Presentation layer

### ViewModels

Located under `BaseApp/presentation/ui/*/`. Responsibilities:

- Call use cases
- Map results to UI state
- Expose `@Published` properties to Views

**Current state:** `ScreenRenderViewModel` uses `ViewState<T>`; other ViewModels use `isLoading` + `data`. Standardizing on `ViewState<T>` is tracked in `#arch-3-standardize-viewmodels`.

### View components

Server-driven home sections map to `ViewData` enum cases (`carousel`, `upcoming`, `seeMore`, …) rendered by `render(_:)` in `ViewData.swift`.

### Theming

- `Theme` struct + `@Environment(\.theme)`
- Per-target colors in `HornsApp/presentation/theme/ThemeExt.swift` and `MuvinApp/...`

---

## Feature modules (by screen)

| Screen | ViewModel | Use cases |
|--------|-----------|-----------|
| Home | `ScreenRenderViewModel` | `GetHomeRenderUseCase`, `GetConcertsUseCase` |
| Upcoming | `UpcomingViewModel` | `GetUpcomingConcertsUseCase`, category filter |
| Favorites | `FavoriteViewModel` | `GetFavoriteConcertsUseCase` |
| Event detail | `EventDetailViewModel` | `GetConcertUseCase`, `UpdateFavoriteConcertUseCase` |

### Event detail platform features

Handled in Swift (not KMP):

- Calendar integration (`CalendarPermissionManager`)
- Maps launcher (`MapLauncherManager`)
- Local notifications (`RemindersSection`)
- In-app WebView for ticketing / external links

---

## Multi-target (white-label) pattern

| Concern | Shared (`BaseApp`) | Per target |
|---------|-------------------|------------|
| UI & navigation | Yes | — |
| Business logic | HornsAppCore pod | — |
| API path / app name | — | `AppSettings` |
| Colors | Theme struct | `ThemeExt` |
| Home layout | Render engine | `app_render.json` |
| Icons / onboarding | — | Assets catalog |

---

## Patterns in use

| Pattern | Status | Location |
|---------|--------|----------|
| Clean Architecture | ✅ | KMP core + iOS adapters |
| Repository | ✅ | `ConcertRepositoryImpl`, `RenderRepositoryImpl` |
| Use Case | ✅ | HornsAppCore |
| MVVM | ⚠️ Partial | ViewModels exist; conventions vary |
| SDUI | ✅ | `app_render.json` |
| DI (composition root) | ✅ | `AppDependencies` |
| Coordinator / Router | ✅ | `Router` + `Route` |

---

## Scaling guidelines

When adding a new feature:

1. **Domain logic** → add or extend use cases in HornsAppCore (KMP).
2. **API mapping** → add DTO + mapper in `BaseApp/framework/alamofire/models/`.
3. **Use case factory** → add method to `AppDependencies`.
4. **UI** → View + ViewModel under `BaseApp/presentation/ui/`.
5. **Track work** → add or update an entry in [todo/TODO.md](./todo/TODO.md).

When adding a new home section type:

1. Add key handling in `ScreenRenderViewModel` (or future `ScreenRenderMapper`).
2. Add `ViewData` case + render view.
3. Update `app_render.json` for each target that needs it.

---

## Known gaps

Tracked in [todo/TODO.md](./todo/TODO.md). 

See the TODO doc for keyed tasks and status.
