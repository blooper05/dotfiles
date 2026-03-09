# False-Positive Exclusion Rules

These rules apply to all analysis agents
and to the orchestrator when evaluating issues.

Do **not** flag any of the following:

- Pre-existing issues not introduced by the current change
- Correct code that merely looks suspicious
- Nitpicks a senior engineer would not mention in review
- Issues already caught by linters, type checkers, or compilers
  (assume CI runs these separately)
- General code quality issues not explicitly required by CLAUDE.md
- Code with explicit suppression comments
  (lint-ignore, disable comments, etc.)
- Intentional behavioral changes aligned with the PR/commit purpose
- Issues on lines the author did not modify

## Guidance for Determining Pre-existing Issues

### Do not report (exclude as false positive)

- Issues that pre-existed before the change
  and are not affected by it
  - Example: A bug in an unrelated function
    adjacent to the modified function

### Report (do not exclude as false positive)

- Pre-existing bugs that become **newly reachable**
  due to the change
  - Example: A refactoring alters a conditional branch,
    making a previously unreachable code path
    with a null reference now reachable
- Cases where the change **expanded the impact scope**
  of a pre-existing bug
  - Example: A function with missing input validation
    is now called from a new external API endpoint
