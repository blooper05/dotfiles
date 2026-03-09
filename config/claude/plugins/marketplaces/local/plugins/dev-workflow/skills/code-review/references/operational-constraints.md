# Operational Constraints

These constraints apply to all agents
and to the orchestrator.

- Do NOT run build, linter, typechecker, or test commands.
  Assume CI runs these separately.
- Do NOT use web fetch.
  Use `gh` CLI for all GitHub interactions.
- Always include PR title and description in agent context
  so agents understand the author's intent.
- Use full git SHA for code links (not shell substitution).
  Never use `$(git rev-parse HEAD)` in Markdown URLs —
  it will not be evaluated.
  Correct format:
  `https://github.com/<owner>/<repo>/blob/<full-sha>/<path>#L<start>-L<end>`
- All tools are functional —
  do not make exploratory or test tool calls.
- Every tool call must have a clear, specific purpose.
