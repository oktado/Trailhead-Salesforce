public with sharing class OpportunityClass {
    public static void closeOpp(Opportunity[] newRecordList) {
        List<Opportunity> oppClosedWon = new List<Opportunity>();
        List<Task> taskList = new List<Task>();
        for(Opportunity opp : newRecordList){
            if(opp.StageName == 'Closed Won'){
               Task taskToCreate = new Task(WhatId = opp.Id, Subject = 'Follow Up Test Task');
               taskList.add(taskToCreate);
        }

        insert taskList;
        }
    }

}