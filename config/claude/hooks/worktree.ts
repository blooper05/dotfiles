#!/usr/bin/env -S deno run --allow-read --allow-env --allow-run

import $ from "jsr:@david/dax";

type CommonInputFields = {
  session_id: string;
  transcript_path: string;
  cwd: string;
  permission_mode: string;
  hook_event_name: string;
};

type WorktreeCreateInput = CommonInputFields & {
  hook_event_name: "WorktreeCreate";
  name: string;
};

type WorktreeRemoveInput = CommonInputFields & {
  hook_event_name: "WorktreeRemove";
  worktree_path: string;
};

type WorktreeInput = WorktreeCreateInput | WorktreeRemoveInput;

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
const input: WorktreeInput = JSON.parse(stdin);

switch (input.hook_event_name) {
  case "WorktreeCreate":
    await createWorktree(input);
    break;
  case "WorktreeRemove":
    await removeWorktree(input);
    break;
}
