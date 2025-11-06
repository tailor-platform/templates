import {
  createExecutor,
  recordCreatedTrigger,
} from "@tailor-platform/tailor-sdk";
import { task } from "../db/task";

export default createExecutor(
  "new-task-slack-notification",
)
  .on(
    recordCreatedTrigger(task),
  )
  .executeWebhook({
    url: ({ newRecord }) => "https://hooks.slack.com/services/yourSlackWebhookURL",
    headers: {
        "Content-Type": "application/json",
    },
    body: ({ newRecord }) => ({
         "text": "New Task created :tada: " + newRecord.name
    }),
  });