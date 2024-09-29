public with sharing class LeadProcessor implements Database.Batchable<SObject>, Database.stateful {
    public Integer recordProcessed = 0;
    public String query;


    public Database.QueryLocator start(Database.BatchableContext bc) {
        query = 'SELECT Id,LeadSource FROM Lead';

        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Lead> scope){
        List<Lead> leadToUpdate = new List<Lead>();
            for(Lead ld: scope){
                ld.LeadSource = 'Dreamforce';
                leadToUpdate.add(ld);
                recordProcessed ++;

            }
            update leadToUpdate;
    } 


    public void finish(Database.BatchableContext bc){
        system.debug(recordProcessed +' recordProcessed');
    }
}