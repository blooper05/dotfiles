# Output Format

Use this template for the final review output.

## Template

~~~
# Code Review Results

**Mode**: [Local Changes | PR #NNN: <title>]
**Branch**: <branch-name>
**Files Changed**: N files
**Review Agents**: 9 launched, N reported issues

---

## Critical Issues (N found)

### [CRI-1] <brief title>
- **Agent**: <agent-name> | **Confidence**: NN/100
- **File**: path/to/file:line
- **Description**: <what is wrong and why>
- **Fix**: <concrete suggestion>

---

## Important Issues (N found)

### [IMP-1] <brief title>
- **Agent**: <agent-name> | **Confidence**: NN/100
- **File**: path/to/file:line
- **Description**: <what is wrong>
- **Fix**: <concrete suggestion>

---

## Suggestions (N found)

### [SUG-1] <brief title>
- **Agent**: <agent-name> | **Confidence**: NN/100
- **File**: path/to/file:line
- **Description**: <what could be improved>
- **Suggestion**: <how to improve>

---

## Strengths
- <positive observations from agents>

---

## Summary

| Agent                   | Issues | Validated | Critical | Important |
| ----------------------- | ------ | --------- | -------- | --------- |
| bug-detector            | N      | N         | N        | N         |
| claude-md-auditor       | N      | N         | N        | N         |
| silent-failure-hunter   | N      | N         | N        | N         |
| comment-analyzer        | N      | N         | N        | N         |
| test-coverage-analyzer  | N      | N         | N        | N         |
| type-design-analyzer    | N      | N         | N        | N         |
| code-simplifier         | N      | N         | N        | N         |
| security-reviewer       | N      | N         | N        | N         |
| performance-analyzer    | N      | N         | N        | N         |
| **Total**               | **N**  | **N**     | **N**    | **N**     |

**Verdict**: [APPROVE | WARNING | BLOCK]
~~~

## Notes

- Use `CRI-` prefix for critical issues (confidence 91–100).
- Use `IMP-` prefix for important issues (confidence 80–90).
- Use `SUG-` prefix for suggestions (confidence 80, borderline).
- The **Strengths** section collects positive observations from all agents.
- The **Summary** table aggregates counts per agent.
- **Verdict** is APPROVE when no important or critical issues exist,
  WARNING when important issues exist but no critical,
  BLOCK when any critical issues exist.
