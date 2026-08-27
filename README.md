# HornsApp — iOS

Concert/events iOS app published on the App Store. Includes a white-label variant (**MuvinApp**) built from the same codebase.

## Documentation

Full project docs live in **[docs/](./docs/README.md)**:

| Doc | Description |
|-----|-------------|
| [Setup](./docs/SETUP.md) | Clone, CocoaPods, build, and run |
| [Architecture](./docs/ARCHITECTURE.md) | Code structure, patterns, and conventions |
| [TODO](./docs/todo/TODO.md) | Backlog with task keys (`#arch-1`, `#feat-2`, …) |
| [Releases](./docs/releases/CHANGELOG.md) | Version history and release notes |

## Quick start

```bash
pod install
open HornsApp.xcworkspace
```

Select the **HornsApp** or **Muvin** scheme and run (Cmd + R).

## Targets

| Target | Description |
|--------|-------------|
| `HornsApp` | Main concert app |
| `MuvinApp` | White-label variant (different theme, assets, API path) |

Shared code: `BaseApp/` · Shared business logic: [HornsAppCore](https://github.com/Yesferal/HornsApp-PodSpecs) (KMP pod)

## License

Copyright 2025 HornsApp Contributors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
