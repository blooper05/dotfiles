# Agent Output Schema

All agents return a JSON array of issue objects.
If no issues meet the confidence threshold,
return an empty array `[]`.

## Common Fields

Every issue object must include these fields:

| Field         | Type                       | Description                            |
| ------------- | -------------------------- | -------------------------------------- |
| `file`        | string                     | Relative file path from repo root      |
| `line`        | number                     | Line number in the new/changed file    |
| `title`       | string                     | Short, specific title (≤ 80 chars)     |
| `description` | string                     | Full explanation with evidence         |
| `suggestion`  | string                     | Concrete, actionable recommendation    |
| `confidence`  | number (0–100)             | Confidence score (only report >= 80)   |
| `severity`    | CRITICAL \| HIGH \| MEDIUM | Impact level                           |

## Example

```json
[
  {
    "file": "src/auth/login.ts",
    "line": 42,
    "title": "SQL injection via unsanitized user input",
    "description": "The `username` parameter is interpolated directly
      into the SQL query string without parameterization.",
    "suggestion": "Use parameterized queries:
      `db.query('SELECT * FROM users WHERE username = ?', [username])`",
    "confidence": 95,
    "severity": "CRITICAL"
  }
]
```

## Agent-Specific Extensions

Some agents include additional fields
beyond the common schema.

### claude-md-auditor

| Field            | Type   | Description                            |
| ---------------- | ------ | -------------------------------------- |
| `claude_md_rule` | string | Exact quoted text of the violated rule |

### security-reviewer

| Field   | Type   | Description                      |
| ------- | ------ | -------------------------------- |
| `owasp` | string | OWASP category ID (e.g., "A03") |

### type-design-analyzer

| Field        | Type   | Description                            |
| ------------ | ------ | -------------------------------------- |
| `dimensions` | object | Four-dimension scores (see agent docs) |

The `dimensions` object contains:

```json
{
  "encapsulation": 7,
  "invariant_expression": 4,
  "invariant_usefulness": 8,
  "invariant_enforcement": 3
}
```

### issue-validator

| Field                  | Type     | Description                               |
| ---------------------- | -------- | ----------------------------------------- |
| `validated_confidence` | number   | Re-assessed confidence after validation   |
| `validator_notes`      | string   | Explanation of verification outcome       |
| `discovering_agents`   | string[] | Names of all agents that found this issue |
