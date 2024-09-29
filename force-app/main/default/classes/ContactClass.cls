public with sharing class ContactClass {
    public static void contactAfterInsert(Contact[] newList) {
        Set<Id> accId = new Set<Id>();
        for(Contact con : newList) {
            if(String.isNotBlank(con.AccountId)) {
                accId.add(con.AccountId);
            }
        }

        AccountContactService.updateActiveContact(accId);
        
    }


    public static void contactAfterUpdate(Contact[] newList, Map<Id,Contact> oldMap) {
        Set<Id> accId = new Set<Id>();
        for(Contact con : newList) {
            if(String.isNotBlank(con.AccountId) && oldMap.get(con.Id).Active__c != con.Active__c) {
                accId.add(con.AccountId);
            } else if (oldMap.get(con.Id).AccountId != con.AccountId) {
                accId.add(con.AccountId);
                accId.add(oldMap.get(con.Id).AccountId);
            }
        }

        AccountContactService.updateActiveContact(accId);
    }

    
    public static void contactAfterDelete(Contact[] oldList) {
        Set<Id> accId = new Set<Id>();
        for(Contact con : oldList) {
            if(String.isNotBlank(con.AccountId)) {
                accId.add(con.AccountId);
            }
        }

        AccountContactService.updateActiveContact(accId);
    }


    public static void contactAfterUndelete(Contact[] newList) {
        Set<Id> accId = new Set<Id>();
        for(Contact con : newList) {
            if(String.isNotBlank(con.AccountId)) {
                accId.add(con.AccountId);
            }
        }

        AccountContactService.updateActiveContact(accId);
    }
    
    
    public static void handlePrimaryContact(Contact[] newList, Map<Id,Contact> oldMap){
        
    }

    public static void createWishTask(Contact[] newList){
        Task t = new Task();
        List<Task> taskList = new List<Task>();
        for(Contact con : newList){
            switch on con.Wish_Type__c {
                when 'Primary'  {
                    t.WhoId = con.Id;
                    t.Subject = 'Follow up with '+con.FirstName+' '+con.LastName;
                    t.Description = 'High Priority Follow up with Management Team';
                    t.Priority = 'High';
                    t.ActivityDate = date.today()+7;
                }
                when 'Secondary' {
                    t.WhoId = con.Id;
                    t.Subject = 'Follow up with '+con.FirstName+' '+con.LastName;
                    t.Description = 'Medium Priority Follow up with Wish Manager';
                    t.Priority = 'Medium';
                    t.ActivityDate = date.today()+14;
                }
                
                when else {
                    t.WhoId = con.Id;
                    t.Subject = 'Follow up with '+con.FirstName+' '+con.LastName;
                    t.Description = 'Low Priority Follow up with with Wish Agent';
                    t.Priority = 'Low';
                    t.ActivityDate = date.today()+21;
                }
            }
            taskList.add(t);
        }

        insert tasklist;
    }
    
 



}