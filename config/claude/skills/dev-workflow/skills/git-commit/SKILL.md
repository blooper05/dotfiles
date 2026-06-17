---
name: git-commit
description: >-
  Use when the user wants to commit working tree changes to git,
  stage files for commit, or save changes to version history.
allowed-tools: Bash(git add:*) Bash(git commit:*)
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
