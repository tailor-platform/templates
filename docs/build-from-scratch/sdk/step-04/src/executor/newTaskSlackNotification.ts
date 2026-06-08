import { createExecutor, recordCreatedTrigger } from "@tailor-platform/sdk";
import { task } from "../db/task";

export default createExecutor({
  name: "new-task-slack-notification",
  trigger: recordCreatedTrigger({ type: task }),
  operation: {
    kind: "webhook",
    url: () => "https://hooks.slack.com/services/yourSlackWebhookURL",
    headers: {
      "Content-Type": "application/json",
    },
    requestBody: ({ newRecord }) => ({
      text: "New Task created :tada: " + newRecord.name,
    }),
  },
});
