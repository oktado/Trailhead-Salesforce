public class OpportunityBatch implements Database.Batchable<sObject> {
  
    public Database.QueryLocator start(Database.BatchableContext bc) {
         return Database.getQueryLocator([
         SELECT 
         Id 
         FROM Opportunity 
         WHERE StageName = 'Closed Won' 
         AND CreatedDate = LAST_WEEK 
        ]);
        
    }

    public void execute(Database.BatchableContext BC, Opportunity[] scope){
        List<Opportunity> oppListToDelete = new List<Opportunity>();
        try {
            for(Opportunity opps:scope){
                oppListToDelete.add(opps);
            }
            database.emptyRecycleBin(oppListToDelete); 
        } catch (Exception error) {
            system.debug(error.getMessage());
        } 
    }


    public void finish(Database.BatchableContext BC){
        
    }
}