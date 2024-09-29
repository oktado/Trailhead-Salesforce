public with sharing class AccountContactService {
    
    
    public static void updateActiveContact(Set<Id> accId) {
        List<AggregateResult> results = [Select AccountId, 
                                        COUNT(Id) totalContacts 
                                        From Contact 
                                        WHERE Active__c = TRUE 
                                        AND AccountId IN: accId 
                                        GROUP BY AccountId];
        Map<Id,Account> accounToUpdate = new Map<Id,Account>();
        for(AggregateResult result : results ) {
            system.debug('total active ct =====>' + Integer.valueOf(result.get('totalContacts')));

            String accountId = String.valueOf(result.get('AccountId'));
            Integer totalContactActv = Integer.valueOf(result.get('totalContacts'));

            Account acc = new Account(Id=accountId,Active_Contacts__c = totalContactActv);
            accounToUpdate.put(accountId,acc);
        }
       

      for(Id accIds : accId) {
        if(!accounToUpdate.containsKey(accIds)) {
            accounToUpdate.put(accIds, new Account(Id=accIds,Active_Contacts__c = 0));
        }
      }
        update accounToUpdate.values();
    }
}