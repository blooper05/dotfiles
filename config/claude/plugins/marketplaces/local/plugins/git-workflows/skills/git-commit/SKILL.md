---
name: git-commit
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
description: >-
  This skill should be used when the user asks to "commit", "create a commit",
  "git commit", "stage and commit changes", "commit my changes",
  or needs to create a git commit from current working tree changes.
---

# Git Commit

Create a git commit from the current working tree changes.

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Workflow

1. Stage related files with `git add`.
2. Create a single commit with an appropriate message.
   - Match the style of recent commits shown in Context above.
   - Write in English.

## Execution Constraints

- Complete all operations in a single tool-call response.
- Issue tool calls only — do not emit any conversational text or messages.
