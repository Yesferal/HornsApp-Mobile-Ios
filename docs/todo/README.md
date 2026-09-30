# TODO — How to use

This folder holds **detailed** task write-ups for HornsApp iOS. For the living **pending list** (Bet-style Active / Next / Depends on), use **[../ROADMAP.md](../ROADMAP.md)**.

Tasks use **stable keys** so they can be referenced in chat, commits, PRs, and code reviews.

## Referencing a task

Use the key inline:

```
Let's work on #arch-2-fix-network-errors next.
```

In commit messages:

```
fix(network): propagate HaResult failures (#arch-2-fix-network-errors)
```

## Updating status

1. Update **[ROADMAP.md](../ROADMAP.md)** — move the row (Active → Done, or Next → Active). Fill **Depends on** (`—` if this repo only).
2. Update **[TODO.md](./TODO.md)** — status column + **Status** line in the detail section.

| Symbol | Meaning |
|--------|---------|
| `[ ]` | Pending |
| `[~]` | In progress |
| `[x]` | Done |
| `[-]` | Cancelled / deferred |

## Adding a new task

1. Pick a prefix: `arch-`, `feat-`, `qual-`, or `store-`
2. Assign the next number in that category
3. Add a row to [ROADMAP.md](../ROADMAP.md) (Next / Later / Nice) with **Depends on**
4. Add a detail section in [TODO.md](./TODO.md) with anchor `#your-key-name`

Example key: `#feat-6-search`

## Depends on (other projects)

| Value | Meaning |
|-------|---------|
| `—` | This repo only (ship anytime) |
| `Core` / `HornsApp-Core` | Needs KMP change + pod bump |
| `API` / `HornsApp-NodeJS` | Needs API deploy |
| `Admin` / `HornsApp-React` | Needs admin/content |
| `Core → API` | Chain: Core publish, then API, then iOS |

## Categories

| Prefix | Purpose |
|--------|---------|
| `arch-` | Architecture, DI, patterns, tests |
| `feat-` | User-facing features |
| `qual-` | Quality, bugs, naming, logging, localization, a11y |
| `store-` | App Store review / 4.2 minimum functionality |
