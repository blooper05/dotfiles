# Model Assignment Strategy

Each agent is assigned a model tier
based on its reasoning requirements.

## Tiers

| Tier     | Model   | Use Case                                    |
| -------- | ------- | ------------------------------------------- |
| Deep     | opus    | Multi-step logic, bug verification, history |
| Pattern  | sonnet  | Rule matching, pattern scanning             |
| Standard | inherit | Straightforward, template-based analysis    |

## Agent Assignments

| Agent                  | Model   | Rationale                                  |
| ---------------------- | ------- | ------------------------------------------ |
| bug-detector           | opus    | Multi-phase reasoning across diff + history |
| issue-validator        | inherit | Dispatches to opus/sonnet per issue type   |
| security-reviewer      | sonnet  | OWASP pattern matching + secret scanning   |
| claude-md-auditor      | sonnet  | Rule scoping and text matching             |
| silent-failure-hunter  | inherit | Error-pattern recognition                  |
| comment-analyzer       | inherit | Comment-to-code cross-reference            |
| test-coverage-analyzer | inherit | Behavioral gap identification              |
| type-design-analyzer   | inherit | Structural analysis                        |
| code-simplifier        | inherit | Complexity pattern detection               |
| performance-analyzer   | inherit | Performance anti-pattern detection         |

## Issue Validator Internal Dispatch

The issue-validator uses sub-agents with model selection:

- **Bug and logic issues** → `model: "opus"`
  (stronger reasoning for verifying code correctness)
- **CLAUDE.md violations** → `model: "sonnet"`
  (sufficient for rule-matching and scope verification)
- **Ambiguous category** → default to `model: "opus"`
