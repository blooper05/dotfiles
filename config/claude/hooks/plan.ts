#!/usr/bin/env -S deno run --allow-read --allow-env --allow-run

import $ from "jsr:@david/dax";
import { globToRegExp } from "jsr:@std/path/glob-to-regexp";

type CommonInputFields = {
  session_id: string;
  transcript_path: string;
  cwd: string;
  permission_mode: string;
  hook_event_name: string;
};

type WriteToolInput = {
  file_path: string;
  content: string;
};

type EditToolInput = {
  file_path: string;
  old_string: string;
  new_string: string;
  replace_all: boolean;
};

type ToolResponse = {
  filePath: string;
};

type PostToolUseInput = CommonInputFields & {
  hook_event_name: "PostToolUse";
  tool_name: "Write" | "Edit";
  tool_input: WriteToolInput | EditToolInput;
  tool_response: ToolResponse;
  tool_use_id: string;
};

const stdin = await new Response(Deno.stdin.readable).text();
const input: PostToolUseInput = JSON.parse(stdin);

const pattern = globToRegExp(`${Deno.env.get("XDG_CONFIG_HOME")}/claude/plans/*.md`);
const filePath = input.tool_response.filePath;

if (!pattern.test(filePath)) Deno.exit(0);

await $`mo ${filePath}`
  .noThrow()
  .quiet();
