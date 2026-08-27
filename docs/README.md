# HornsApp iOS — Documentation

Central documentation for the HornsApp-Mobile-Ios project.

## Guides

| Document | Description |
|----------|-------------|
| [Setup](./SETUP.md) | Prerequisites, clone, CocoaPods, build, and run both app targets |
| [Architecture](./ARCHITECTURE.md) | How the app is structured, patterns, data flow, and scaling guidelines |

## Project tracking

| Document | Description |
|----------|-------------|
| [TODO](./todo/TODO.md) | Living backlog with stable task keys (`#arch-1`, `#feat-2`, …) |
| [Releases](./releases/CHANGELOG.md) | Version history and release notes |
| [Release process](./releases/README.md) | How to bump versions and publish |

## Quick links

- **HornsApp target** — concert app (`HornsApp/`)
- **MuvinApp target** — white-label variant (`MuvinApp/`)
- **Shared code** — UI, networking, DI (`BaseApp/`)
- **Shared core** — [HornsAppCore](https://github.com/Yesferal/HornsApp-PodSpecs) (Kotlin Multiplatform pod)

## Conventions

- Reference tasks by key in commits, PRs, and chat: e.g. `#arch-2-fix-network-errors`
- Update [TODO](./todo/TODO.md) when starting or finishing a task
- Add a release entry in [CHANGELOG](./releases/CHANGELOG.md) when shipping a new version
