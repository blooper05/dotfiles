---
name: code-review
description: >-
  Comprehensive multi-agent code review.
  Use when the user says "review code", "code review",
  "review my changes", "review this PR",
  "review pull request", "check for bugs",
  "audit code quality", "review local changes",
  "review diff", or needs any form of code quality check.
  Supports both local changes and GitHub pull requests.
allowed-tools:
  - Bash(git diff:*)
  - Bash(git status:*)
  - Bash(git log:*)
  - Bash(git blame:*)
  - Bash(git branch:*)
  - Bash(gh pr diff:*)
  - Bash(gh pr view:*)
  - Bash(gh pr list:*)
  - Read
  - Glob
  - Grep
  - Task
---

# Code Review Skill

Run a comprehensive code review using 9 specialized parallel agents,
followed by post-validation through the `issue-validator` agent.

**Arguments**: "$ARGUMENTS"

Confidence scoring rules: see `references/confidence-scoring.md`
Output format template: see `references/output-format.md`

---

## Available Agents

| Agent                    | Model   | Color   | Focus Area                        |
| ------------------------ | ------- | ------- | --------------------------------- |
| `bug-detector`           | opus    | red     | Bugs, logic errors                |
| `security-reviewer`      | sonnet  | magenta | OWASP Top 10, secrets             |
| `claude-md-auditor`      | sonnet  | blue    | CLAUDE.md compliance              |
| `silent-failure-hunter`  | inherit | orange  | Error handling, silent failures   |
| `comment-analyzer`       | inherit | green   | Comment accuracy                  |
| `test-coverage-analyzer` | inherit | cyan    | Test coverage gaps                |
| `type-design-analyzer`   | inherit | pink    | Type design, invariants           |
| `code-simplifier`        | inherit | white   | Simplification                    |
| `performance-analyzer`   | inherit | purple  | Performance issues                |
| `issue-validator`        | inherit | yellow  | Post-validation gate, FP removal  |

---

## False-Positive Exclusion Rules

See `references/false-positive-rules.md` for the complete list.
These rules apply to all agents and to the orchestrator.

---

## Step 1: Review Mode Detection

Determine the review mode from the arguments.

### PR Mode

**Trigger**: argument contains a PR number (e.g. `42`)
or a GitHub PR URL.

1. Run `gh pr view <PR>` to check eligibility.
   Abort and stop if any of the following are true:
   - The PR is closed or a draft
   - The PR is trivially simple and obviously correct
     (e.g., automated PR, single-line typo fix)
   - Claude has already left a review comment
     (check `gh pr view <PR> --comments` for `claude` authored comments)

1. If eligible, fetch:
   - Diff: `gh pr diff <PR>`
   - Changed files: `gh pr diff <PR> --name-only`
   - PR metadata: `gh pr view <PR>` (title, body, branch names)

### Auto-detect PR Mode

**Trigger**: no PR number given, but current branch has an open PR.

1. Run `gh pr view` (no argument) to check if current branch
   has an associated open PR.
2. If found, treat as PR mode with that PR.
3. Apply the same eligibility checks as PR mode above.

### Local Mode

**Trigger**: no argument, no open PR found,
or argument is `--local`.

1. Run `git diff HEAD` to get the diff.
2. If `git diff HEAD` returns empty output,
   fall back to `git diff --cached`
   (staged but uncommitted changes).
3. If still empty, output:
   ```
   No changes to review.
   ```
   and stop — do not proceed.
4. Changed files: `git diff --name-only HEAD`
   (or `git diff --name-only --cached` if using staged fallback).
5. Branch info: `git branch --show-current` and `git log --oneline -1`.

---

## Step 2: Context Gathering

Using the changed file list from Step 1, collect:

### CLAUDE.md Discovery

1. For each changed file path,
   walk up the directory tree
   from the file's directory to the repository root,
   checking for a `CLAUDE.md` at each level.
   Collect all found paths.
2. Read the **contents** of each discovered `CLAUDE.md`.
3. Identify the **applicable scope** of each rule
   (which directories or file patterns it applies to).
4. Include CLAUDE.md contents and scope information
   in the context package passed to agents in Step 3.

Example: for `src/api/handlers/auth.ts`, check:

```
src/api/handlers/CLAUDE.md
src/api/CLAUDE.md
src/CLAUDE.md
CLAUDE.md
```

### Change Summary

- **PR mode**: PR title, PR body (description),
  and the base/head branch names.
- **Local mode**: current branch name, latest commit message,
  and a brief description of what the diff changes.

### Context Package

Pass the following to all agents in Step 3:

- Full diff text
- List of changed file paths
- CLAUDE.md contents with scope information
  (not just paths — include the actual rules
  and which directories/patterns they apply to)
- Change summary (PR metadata or branch/commit info)

---

## Step 3: Launch 9 Agents in Parallel

**Launch all 9 agents simultaneously in a single message**
using the Task tool.
This is critical for performance — do NOT launch them sequentially.

Each agent receives the full context package from Step 2,
plus this instruction:

> All tools are functional and will work without error.
> Do not make exploratory or test tool calls.
> Every tool call must have a clear, specific purpose.
> Return your findings as a JSON array.
> If nothing in the diff falls within your domain, return `[]`.

### Agent Dispatch

Each agent receives the full context package from Step 2.
Agent-specific instructions are in their `.md` files
under the `agents/` directory.

| #  | Agent                  | Model   |
| -- | ---------------------- | ------- |
| 1  | bug-detector           | opus    |
| 2  | security-reviewer      | sonnet  |
| 3  | claude-md-auditor      | sonnet  |
| 4  | silent-failure-hunter  | inherit |
| 5  | comment-analyzer       | inherit |
| 6  | test-coverage-analyzer | inherit |
| 7  | type-design-analyzer   | inherit |
| 8  | code-simplifier        | inherit |
| 9  | performance-analyzer   | inherit |

---

## Step 4: Issue Validator Post-Verification

After all 9 agents complete,
collect all issues with confidence >= 80.

If no issues meet this threshold, skip to Step 5
with an empty validated list.

Otherwise, launch the **`issue-validator`** agent (opus)
with:

- The full diff text
- All collected issues (combined from all 9 agents)
- The change summary

The `issue-validator` will:

1. Re-verify each issue independently against the actual diff
2. Remove false positives that do not hold up to scrutiny
   (apply the False-Positive Exclusion Rules above)
3. De-duplicate overlapping issues reported by multiple agents:
   keep the highest-confidence version,
   but record all discovering agents in the output
4. Adjust confidence scores where evidence warrants
5. Return the final validated JSON array

For validation subagents inside `issue-validator`:
use **Opus** for bugs and logic issues,
use **Sonnet** for CLAUDE.md violations.

Filter out any issue with confidence < 80 after validation.

---

## Step 5: Result Aggregation and Output

Format the final review output
following the template in `references/output-format.md`.

### Issue Classification

| Confidence | Category   | ID Prefix |
| ---------- | ---------- | --------- |
| 91–100     | Critical   | `CRI-`    |
| 80–90      | Important  | `IMP-`    |
| 80 (edge)  | Suggestion | `SUG-`    |

### Verdict

- **APPROVE**: No issues found,
  or only suggestions (confidence 80)
- **WARNING**: Important issues found (confidence 80–90),
  but no critical issues
- **BLOCK**: One or more critical issues found
  (confidence 91–100)

### No Issues Found

If the validated list is empty after Step 4, output:

```
# Code Review Results

**Mode**: [Local Changes | PR #NNN: <title>]
**Branch**: <branch-name>
**Files Changed**: N files
**Review Agents**: 9 launched, 0 issues after validation

No issues found.
Checked for bugs, security vulnerabilities,
CLAUDE.md compliance, silent failures,
comment accuracy, test coverage, type design,
simplification opportunities, and performance issues.
```

---

## Operational Constraints

See `references/operational-constraints.md` for the full list.
