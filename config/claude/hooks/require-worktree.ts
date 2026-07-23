#!/usr/bin/env -S deno run --allow-read --allow-env --allow-run

type PreToolUseInput = {
  cwd: string;
  tool_input: { file_path: string };
};

function allow(): never {
  Deno.exit(0);
}

function block(message: string): never {
  console.error(message);
  Deno.exit(2);
}

const stdin = await new Response(Deno.stdin.readable).text();
const input: PreToolUseInput = JSON.parse(stdin);

const plansPrefix = `${Deno.env.get("XDG_CONFIG_HOME")}/claude/plans/`;
const filePath = input.tool_input.file_path;

if (filePath.startsWith(plansPrefix)) {
  const rest = filePath.slice(plansPrefix.length);
  if (!rest.includes("/") && rest.endsWith(".md")) allow();
}

const { success, stdout } = await new Deno.Command("git", {
  args: [
    "-C",
    input.cwd,
    "rev-parse",
    "--path-format=absolute",
    "--git-dir",
    "--git-common-dir",
  ],
  stdout: "piped",
  stderr: "inherit",
}).output();

// Fail open on detection errors: a false positive here would block every
// Write/Edit, not just the ones outside a worktree.
if (!success) allow();

const [gitDir, gitCommonDir] = new TextDecoder().decode(stdout).trim().split("\n");

if (gitDir === gitCommonDir) {
  block("Not in a git worktree. Call EnterWorktree first, then retry this edit using the worktree path.");
}

allow();
