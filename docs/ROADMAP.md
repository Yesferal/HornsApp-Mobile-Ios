# iOS roadmap (`HornsApp-Mobile-Ios`)

One **Active** item at a time. Prefer **easy app wins** first (no Core / API / admin change).

**Updated:** 2026-10-02

**App Store:** Rejected 3× under **Guideline 4.2** (iPad Air 11″). Stay a concert companion — add native depth Apple can exercise in review. Resubmit order: finish P0-adjacent Next items → TestFlight iPad + iPhone → `#store-9-review-packaging`.

**UI (current):**
- **Phone** — `TabView` (Home / Upcoming / Favorite) + `NavigationStack`
- **iPad** — `NavigationSplitView` sidebar + detail; `readableContentWidth()` (~720pt) on list/detail roots
- **Detail** — About, Save date / Maps / Tickets, Reminders, Activities, Related; share + favorite
- **Upcoming** — in-place search (glass field over chips) + category filter; search scoped to selected category
- **Settings** — Favorites footer → version, permissions, social profiles (Instagram / TikTok / Facebook / Spotify)
- **ATT / ads** — deferred until after first App Store release (`#store-8-att-onboarding`)

### How to use

- Pick keys like `#store-5-search` in commits / chat.
- Move rows: Next → Active → Done. One Active at a time.
- **Depends on:** `—` = this repo only; else name the blocker (Core, API, Admin, or another `#key`).

---

## Depends on

| iOS depends on | How |
|----------------|-----|
| HornsApp-Core (KMP) | Use cases, models, shared mappers (CocoaPods / PodSpecs) |
| HornsApp-NodeJS (API) | HTTPS events, venues, categories; new fields after API ships |
| HornsApp-React (admin) | Content ops (images, about text); not required for most UI tasks |

**Independent of other repos:** SwiftUI layout, VoiceOver, Settings UI, empty states, Share, ATT prompt chrome, AdMob wiring (once SDK chosen), bundled `app_render.json`, SwiftData cache.

**Two gotchas**
- Many UX / App Store items need **no** backend — ship them anytime.
- Core/API fields only reach the app after: **Core publish → pod bump → (if needed) API deploy → iOS release**.

---

## Active

| ID | Item | Effort | Depends on |
|----|------|--------|------------|
| `#feat-3-carousel-cta` | Native carousel actions (calendar / favorite) | Medium | — |

---

## Next — App Store / product (prefer these)

| ID | Item | Effort | Depends on |
|----|------|--------|------------|
| `#store-9-review-packaging` | Screenshots, review notes, App Store description | Small | Content ready in API/admin |
| `#feat-1-lineup` | Full lineup on detail (section exists, model stubbed) | Medium | Core + API if payload incomplete |
| `#qual-6-voiceover` | VoiceOver labels, traits, iPhone + iPad audit | Medium | — |

---

## Next — architecture (when unblocked)

| ID | Item | Effort | Depends on |
|----|------|--------|------------|
| `#arch-6b-tab-switching` | Per-tab navigation stacks (split sidebar done; phone stacks partial) | Medium | — |
| `#arch-6d-nav-view-data` | Concert taps via KMP `Navigator` / `NavViewData` | Medium | Core Navigator patterns |
| `#arch-6e-external-actions` | Calendar, maps, share via `ExternalNavigatorAdapter` | Medium | Core adapters (optional) |
| `#arch-6f-screen-type-coverage` | Map remaining `ScreenRender.Type` (settings, lineup, …) | Medium | `#feat-1-lineup`, `#store-7-settings-about` |
| `#arch-5-unit-tests` | ViewModel + mapper unit tests | Medium | — |
| `#feat-5-dynamic-tabs` | Tabs from `app_render.json` (not hardcoded) | Medium | `#arch-6b-tab-switching` |
| `#feat-4-concert-cache` | SwiftData `getConcertCached` / `updateConcertCached` | Medium | — |
| `#qual-4-remote-render` | Live SDUI via `updateAppRender()` | Medium | API/remote render source |
| `#qual-1-logging` | Logging abstraction (replace `print`) | Small | — |
| `#qual-5-naming-cleanup` | Phase 3 naming / stale headers | Small | — |

---

## Later

| ID | Item | Depends on |
|----|------|------------|
| `#store-8-att-onboarding` | ATT + personalized ads (AdMob or similar); restore prompt when tracking is real | **≥1 App Store version live** + ad unit IDs |
| Android parity | Keep feature parity with HornsApp-Android when Core advances | Core + Android as needed |

---

## Nice to have

| ID | Item | Depends on |
|----|------|------------|
| — | Three-column iPad (sidebar \| list \| detail) | — |
| — | Drop or relax `readableContentWidth()` where split detail is already narrow | — |

---

## Done (recent)

| ID | Note |
|----|------|
| `#store-7-settings-about` | Settings / About: version, notification status → system Settings, contact email |
| `#store-5-search` | Upcoming in-place search (glass field over chips); filter by event / headliner |
| `#store-6-ipad-layout` | `readableContentWidth()` + iPad `NavigationSplitView` (2026-09-30) |
| `#store-2-event-about` | About on detail + favorite CTA row |
| `#feat-2-related-events` | Related events via Core use case |
| `#store-3-empty-states` | Favorites / Upcoming empty states |
| `#store-4-share-event` | ShareLink on detail |
| `#arch-1` … `#arch-4` | DI, network errors, ViewModels, ScreenRenderMapper |
| `#arch-6a` / `#arch-6c` | NavigatorCoordinator; remove duplicate Router |
| `#qual-2-localization` | Localization pass |
| `#qual-3-favorite-rollback` | Favorite toggle rollback on failure |
