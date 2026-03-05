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

type NotificationInput = CommonInputFields & {
  message: string;
  title?: string;
  notification_type: string;
};

type StopInput = CommonInputFields & {
  stop_hook_active: boolean;
  last_assistant_message: string;
};

const flags = parseArgs(Deno.args, {
  string: ["event"],
});

async function notifyOnNotificationEvent() {
  const stdin = await new Response(Deno.stdin.readable).text();
  const input: NotificationInput = JSON.parse(stdin)
  await $`terminal-notifier -title "Claude Code" -message ${input.message} -sound funk`;
}

async function notifyOnStopEvent() {
  await $`terminal-notifier -title "Claude Code" -message "✓ Task completed. Awaiting next action." -sound funk`;
}

switch (flags.event) {
  case "notification":
    await notifyOnNotificationEvent();
    break;
  case "stop":
    await notifyOnStopEvent();
    break;
}
