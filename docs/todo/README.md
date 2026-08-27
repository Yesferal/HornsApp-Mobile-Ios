# TODO — How to use

This folder tracks planned work for the iOS app. Tasks use **stable keys** so they can be referenced consistently in chat, commits, PRs, and code reviews.

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

Edit [TODO.md](./TODO.md) and change the status column:

| Symbol | Meaning |
|--------|---------|
| `[ ]` | Pending |
| `[~]` | In progress |
| `[x]` | Done |
| `[-]` | Cancelled / deferred |

When a task is done, also update the **Status** line in its detail section at the bottom of the file.

## Adding a new task

1. Pick a prefix: `arch-`, `feat-`, or `qual-`
2. Assign the next number in that category
3. Add a row to the summary table
4. Add a detail section with anchor `#your-key-name`

Example key: `#feat-6-search`

## Categories

| Prefix | Purpose |
|--------|---------|
| `arch-` | Architecture, DI, patterns, tests |
| `feat-` | User-facing features |
| `qual-` | Quality, bugs, naming, logging, localization |
