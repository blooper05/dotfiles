#!/usr/bin/env -S deno run --allow-read --allow-env --allow-run

import { parseArgs } from "jsr:@std/cli/parse-args";
import $ from "jsr:@david/dax";

type CommonInputFields = {
  session_id: string;
  transcript_path: string;
  cwd: string;
  permission_mode: string;
  hook_event_name: string;
};

type WorktreeCreateInput = CommonInputFields & {
  name: string;
};

type WorktreeRemoveInput = CommonInputFields & {
  worktree_path: string;
};

const flags = parseArgs(Deno.args, {
  string: ["event"],
});

async function createWorktree() {
  const stdin = await new Response(Deno.stdin.readable).text();
  const input: WorktreeCreateInput = JSON.parse(stdin);
  const path = (await $`git wt ${input.name} --nocd`
    .stderr("null")
    .lines())
    .at(-1);
  if (path) console.log(path);
}

async function removeWorktree() {
  const stdin = await new Response(Deno.stdin.readable).text();
  const input: WorktreeRemoveInput = JSON.parse(stdin);
  await $`git wt --delete ${input.worktree_path}`
    .noThrow()
    .quiet();
}

switch (flags.event) {
  case "create":
    await createWorktree();
    break;
  case "remove":
    await removeWorktree();
    break;
}
