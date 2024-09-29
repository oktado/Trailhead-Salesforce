public class TaskClass {
    public static void createReminderTask(Task[] newTaskList, Map<Id,Task> oldMap){
        Set<Id> idContact = new Set<Id>();
        Map<Id,Task> taskMap = new Map<Id,Task>();
        for(Task t : newTaskList){
            if(t.Status == 'Completed' && oldMap.get(t.Id).Status != 'Completed'){
                taskMap.put(t.WhoId,t);
            }
        }

        // query contact to check document verified
        if(taskMap.size() > 0){
            system.debug('createReminder Task');
            Task t = new Task();
            List<Task> listTaskToAdd = new List<Task>();
            for(Contact cList : [SELECT Id,Document_Verified__c FROM Contact WHERE Id IN:taskMap.keySet()]){
                if(!cList.Document_Verified__c){
                    t.WhoId = cList.Id;
                    t.Subject = taskMap.get(cList.id).Subject;
                    t.ActivityDate = date.today()+2;
                }
            }
            listTaskToAdd.add(t);
            system.debug('listTaskToAdd '+ listTaskToAdd);
            if(!listTaskToAdd.isEmpty()){
                insert listTaskToAdd;
            }
        }
    }
}