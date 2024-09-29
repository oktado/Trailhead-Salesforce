public with sharing class AccountProcessor {
    @future(callout=true)
    public static void countContacts(List<Id> AccountIds) {
            List<Account> AccToUpdate = new List<Account>();
            List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId IN:AccountIds];
            system.debug(contacts.size());
            for(Account acc:[SELECT Id,Number_Of_Contacts__c FROM Account WHERE Id IN:AccountIds]){
                    
                    acc.Number_Of_Contacts__c = contacts.size();
                    AccToUpdate.add(acc);
            }
            Update AccToUpdate;
    }
}