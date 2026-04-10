Always work inside a git worktree, never in the main working tree.

When delegating to sub-agents, inherit the parent's CWD.
Never use `isolation: "worktree"` for sub-agents.

There is no local `main` branch in worktree-based workflows.
Always reference `origin/main` (or `origin/HEAD`)
for diff, log, merge-base, and PR base operations.
