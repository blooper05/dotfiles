# Model Assignment Strategy

Each agent is assigned a model tier
based on its reasoning requirements.

## Tiers

| Tier     | Model             | Use Case                                    |
| -------- | ----------------- | ------------------------------------------- |
| Deep     | claude-opus-5-5   | Multi-step logic, bug verification, history |
| Pattern  | claude-sonnet-5-5 | Rule matching, pattern scanning             |
| Standard | claude-sonnet-5-5 | Straightforward, template-based analysis    |

## Agent Assignments

| Agent                  | Model             | Rationale                                  |
| ---------------------- | ----------------- | ------------------------------------------ |
| bug-detector           | claude-opus-5-5   | Multi-phase reasoning across diff + history |
| issue-validator        | claude-opus-5-5   | Dispatches to opus/sonnet per issue type   |
| security-reviewer      | claude-sonnet-5-5 | OWASP pattern matching + secret scanning   |
| claude-md-auditor      | claude-sonnet-5-5 | Rule scoping and text matching             |
| silent-failure-hunter  | claude-sonnet-5-5 | Error-pattern recognition                  |
| comment-analyzer       | claude-sonnet-5-5 | Comment-to-code cross-reference            |
| test-coverage-analyzer | claude-sonnet-5-5 | Behavioral gap identification              |
| type-design-analyzer   | claude-sonnet-5-5 | Structural analysis                        |
| code-simplifier        | claude-sonnet-5-5 | Complexity pattern detection               |
| performance-analyzer   | claude-sonnet-5-5 | Performance anti-pattern detection         |

## Issue Validator Internal Dispatch

The issue-validator uses sub-agents with model selection:

- **Bug and logic issues** → `model: "opus"`
  (stronger reasoning for verifying code correctness)
- **CLAUDE.md violations** → `model: "sonnet"`
  (sufficient for rule-matching and scope verification)
- **Ambiguous category** → default to `model: "opus"`
