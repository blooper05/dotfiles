---
name: code-review-request
allowed-tools: Bash(git status:*), Bash(git push:*), Bash(gh pr create:*), Bash(gh pr view:*)
description: >-
  This skill should be used when the user asks to "create a PR",
  "open a pull request", "send for code review", "push and create PR",
  "submit for review", "code review request",
  or needs to push and open a GitHub pull request in one operation.
---

# Code Review Request

Push and open a GitHub pull request in a single operation.

## Context

- Current git status: !`git status`
- Current branch: !`git branch --show-current`
- Commits in this branch: !`git log --oneline main..HEAD`
- PR template: !`cat .github/pull_request_template.md 2>/dev/null || echo "No template found"`

## Workflow

### Step 1: Push

- Push the branch with `git push -u origin <branch-name>`.

### Step 2: Create Pull Request

- Create a pull request with `gh pr create`.
- Write the title and body in English.
- If a PR template is found in Context above, use it as the base for the body.

### Step 3: Open in Browser

- Open the created pull request in the browser with `gh pr view --web`.

## Execution Constraints

- Complete all operations in a single tool-call response.
- Issue tool calls only — do not emit any conversational text or messages.
