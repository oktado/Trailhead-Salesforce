trigger TaskTrigger on Task (before update) {
  TaskClass.createReminderTask(trigger.new, trigger.oldMap);
}