# Release process

How versions are managed for HornsApp and MuvinApp.

---

## Version fields

Each app target has two version values in Xcode:

| Field | Xcode setting | Example | Purpose |
|-------|---------------|---------|---------|
| Marketing version | `MARKETING_VERSION` | `1.0.1` | User-facing App Store version |
| Build number | `CURRENT_PROJECT_VERSION` | `2` | Internal build counter (must increase per upload) |

Both targets (`HornsApp`, `MuvinApp`) should stay in sync unless there is a deliberate reason to diverge.

---

## HornsAppCore dependency

The shared KMP pod version is pinned in `Podfile`:

```ruby
pod 'HornsAppCore', '~> 1.5.0'
```

When bumping core:

1. Update `Podfile` constraint
2. Run `pod update HornsAppCore`
3. Verify both targets build
4. Note the core version in [CHANGELOG](./CHANGELOG.md)

---

## Release checklist

### Before release

- [ ] All planned tasks for the release are done or deferred
- [ ] Both schemes build: `HornsApp`, `Muvin`
- [ ] Smoke test on simulator: onboarding, home, upcoming, favorites, event detail
- [ ] Update [CHANGELOG](./CHANGELOG.md) with release notes
- [ ] Bump `MARKETING_VERSION` and/or `CURRENT_PROJECT_VERSION` in Xcode

### App Store

- [ ] Archive each target separately (different bundle IDs)
- [ ] Upload to App Store Connect
- [ ] Submit for review

### After release

- [ ] Tag the git commit: `git tag v1.0.1`
- [ ] Push tag: `git push origin v1.0.1`

---

## Changelog format

Add a new section at the top of [CHANGELOG.md](./CHANGELOG.md):

```markdown
## [1.0.2] — 2026-XX-XX

### Added
- ...

### Changed
- ...

### Fixed
- ...
```

Reference task keys where helpful: `(#feat-1-lineup)`.

---

## Git tags

Recommended tag format:

```
v{MARKETING_VERSION}
```

Example: `v1.0.1`

If build numbers matter for internal tracking:

```
v1.0.1-build2
```

---

## Related docs

- [Setup](../SETUP.md) — build instructions
- [Architecture](../ARCHITECTURE.md) — codebase overview
- [ROADMAP](../ROADMAP.md) — pendings + Depends on
