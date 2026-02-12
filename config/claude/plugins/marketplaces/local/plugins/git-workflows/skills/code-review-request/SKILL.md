---
name: Code Review Request
allowed-tools: Bash(git checkout -b:*), Bash(git add:*), Bash(git status:*), Bash(git push:*), Bash(git commit:*), Bash(gh pr create:*)
description: Commit, push, and open a PR
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- PR template: !`cat .github/pull_request_template.md 2>/dev/null || echo "No template found"`

## Your task

Based on the above changes:

1. Create a new branch if on main
2. Create a single commit with an appropriate message
3. Push the branch to origin

### Step 4: Create Pull Request

- Create a pull request with `gh pr create`.
- Write the title and body in English.
- If a PR template is found in Context above, use it as the base for the body.

## Execution Constraints

- Complete all operations in a single tool-call response.
- Issue tool calls only — do not emit any conversational text or messages.
