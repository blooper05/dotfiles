#!/usr/bin/env -S deno run --allow-read --allow-env --allow-run

import $ from "jsr:@david/dax";

type CommonInputFields = {
  session_id: string;
  transcript_path: string;
  cwd: string;
  permission_mode: string;
  hook_event_name: string;
};

type NotificationInput = CommonInputFields & {
  hook_event_name: "Notification";
  message: string;
  title?: string;
  notification_type: string;
};

type StopInput = CommonInputFields & {
  hook_event_name: "Stop";
  stop_hook_active: boolean;
  last_assistant_message: string;
};

type NotifyInput = NotificationInput | StopInput;

async function notifyOnNotificationEvent(input: NotificationInput) {
  await $`terminal-notifier -title ${input.title ?? "Claude Code"} -message ${input.message} -sound funk`;
}

async function notifyOnStopEvent(_input: StopInput) {
  await $`terminal-notifier -title "Claude Code" -message "✓ Task completed. Awaiting next action." -sound funk`;
}

const stdin = await new Response(Deno.stdin.readable).text();
const input: NotifyInput = JSON.parse(stdin);

switch (input.hook_event_name) {
  case "Notification":
    await notifyOnNotificationEvent(input);
    break;
  case "Stop":
    await notifyOnStopEvent(input);
    break;
}
