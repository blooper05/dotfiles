# Confidence Scoring Rubric

All agents use a unified 0–100 confidence scale.
Only issues scoring **>= 80** are included in the final output.

## Scale

| Score   | Meaning                                                        |
| ------- | -------------------------------------------------------------- |
| 0       | False positive. Does not survive scrutiny, or pre-existing.    |
| 25      | Possible. May be false positive. Style issue not in CLAUDE.md. |
| 50      | Real but minor. Nitpick, rarely encountered in practice.       |
| 75      | Verified. Encountered in practice. Directly affects function.  |
| **80**  | **Reporting threshold** — only this and above in final output. |
| 91–100  | Critical. Certain issue. Syntax/type error, security vuln.     |

## Classification

| Confidence | Category  |
| ---------- | --------- |
| 91–100     | Critical  |
| 80–90      | Important |
| 80         | Threshold |
| < 80       | Excluded  |

## False-Positive Exclusion Rules

See `references/false-positive-rules.md` for the complete list.
