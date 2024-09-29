public  class BatchCreateContactTask implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([
            SELECT 
            Id 
            FROM Contact 
            WHERE StageName = 'Closed Won' 
            AND CreatedDate = LAST_WEEK 
           ]);
    }
}