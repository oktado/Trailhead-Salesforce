public class TaskScheduleCreateReminder implements Schedulable{
    public void execute(SchedulableContext sc) { 
        List<Task> completedTaskOverdue = new  List<Task>();
        List<Task> taskToCreate = new  List<Task>();
        List<Contact> contactVerified = new  List<Contact>();
        Set<Id> conId = new Set<Id>();
        for(Task t: [
            SELECT 
            Id,
            WhoId,
            ActivityDate,
            Subject 
            FROM Task 
            WHERE ActivityDate < TODAY
            AND Subject LIKE: 'Verify Document Contact%'
            AND Status = 'Completed'
           ]){
            completedTaskOverdue.add(t);
            conId.add(t.WhoId);
           }


           for(Contact c: [Select Id From Contact Where Id IN:conId AND Document_Verified__c = FALSE]){
                contactVerified.add(c);
           }

           if(contactVerified.size() > 0){
                for(Contact c : contactVerified){
                    Task t = new Task(WhoId = cList.Id,
                                    Subject = 'Verify Document Contact',
                                    ActivityDate = date.today()+2);

                taskToCreate.add(t);
                }
                
           }
           insert taskToCreate;
    }
}