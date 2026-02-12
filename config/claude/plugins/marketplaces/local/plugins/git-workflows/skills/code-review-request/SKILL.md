---
name: Code Review Request
allowed-tools: Bash(git checkout -b:*), Bash(git add:*), Bash(git status:*), Bash(git push:*), Bash(git commit:*), Bash(gh pr create:*)
description: Commit, push, and open a PR
---

# Code Review Request

Commit, push, and open a GitHub pull request in a single operation.

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`
- PR template: !`cat .github/pull_request_template.md 2>/dev/null || echo "No template found"`

## Workflow

### Step 1: Branch Creation (Conditional)

- If the current branch is main or master, create a new branch.
- If already on a non-default branch, skip this step.

### Step 2: Stage and Commit

- Stage related files with `git add`.
- Create a single commit with an appropriate message.
  - Match the style of recent commits shown in Context above.
  - Write in English.

### Step 3: Push

- Push the branch with `git push -u origin <branch-name>`.

### Step 4: Create Pull Request

- Create a pull request with `gh pr create`.
- Write the title and body in English.
- If a PR template is found in Context above, use it as the base for the body.

## Execution Constraints

- Complete all operations in a single tool-call response.
- Issue tool calls only — do not emit any conversational text or messages.
