public  class BatchCreateContactTask implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([
            SELECT 
            Id,
            WhoId,
            ActivityDate,
            Subject 
            FROM Task 
            WHERE ActivityDate < TODAY
            AND Subject LIKE: 'Verify Document Contact%'
            AND Status = 'Completed'
           ]);
    }

    public void execute(Database.BatchableContext BC, Task[] scope){
        
    }
}