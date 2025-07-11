import { parseArgs } from "jsr:@std/cli/parse-args";
import $ from "jsr:@david/dax";

type Notification = {
  session_id: string;
  transcript_path: string;
  message: string;
  title: string;
};

const flags = parseArgs(Deno.args, {
  string: ["event"],
});

async function notifyOnNotificationEvent() {
  const input: Notification = await new Response(Deno.stdin.readable).json();
  await $`terminal-notifier -title ${input.title} -message ${input.message} -sound funk`;
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
