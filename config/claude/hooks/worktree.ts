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

async function createWorktree(input: WorktreeCreateInput) {
  const path = (await $`git wt ${input.name} --nocd`
    .stderr("null")
    .lines())
    .at(-1);
  if (path) console.log(path);
}

async function removeWorktree(input: WorktreeRemoveInput) {
  await $`git wt --delete ${input.worktree_path}`
    .noThrow()
    .quiet();
}

const stdin = await new Response(Deno.stdin.readable).text();

switch (flags.event) {
  case "create":
    await createWorktree(JSON.parse(stdin) as WorktreeCreateInput);
    break;
  case "remove":
    await removeWorktree(JSON.parse(stdin) as WorktreeRemoveInput);
    break;
}
