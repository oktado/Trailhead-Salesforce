public with sharing class EnquiryClass {
    
    
    public static void createContactAccountBulkified(Enquiry__c[] newList){
        Map<String,Enquiry__c> enquiryEmailMap = new Map<String,Enquiry__c>();
        List<Contact> contactToSearch = new List<Contact>();
        
       

        for(Enquiry__c e : newList){
            enquiryEmailMap.put(e.Email__c,e);
        }
        
      	contactToSearch = [SELECT Id,Email,lastName,AccountId FROM Contact WHERE Email =: enquiryEmailMap.keySet() AND AccountId <> null];
        
        if(contactToSearch.size() > 0){
            //if contact exist, tag them into enquiry
            for(Enquiry__c e: newList){
                e.Contact_Record__c = contactToSearch[0].Id;
                e.Account_Record__c = contactToSearch[0].AccountId;
            }
        } else {
            Map<String,Contact> contactMap = new Map<String,Contact>();
          	Map<String,Account> accountMap = new Map<String,Account>();
            
            //if contact doesn't exist, create account
              for(Enquiry__c e: newList){
                 Account acc = new Account(Name = e.Lastname__c +' Household', 
                                           Main_Email__c = e.Email__c
                                          );
                
                accountMap.put(e.Email__c, acc);
            }
            insert accountMap.values();
            
            // create contact
            for(Enquiry__c e: newList){
                Contact c = new Contact();
                c.Salutation = e.Salutation__c;
                c.FirstName = e.Firstname__c;
                c.LastName = e.Lastname__c;
                c.Email = e.Email__c;
                c.AccountId = accountMap.get(e.Email__c).Id;
                contactMap.put(e.Email__c,c);
            }
            
           insert contactMap.values();
                       
         
            
                    
            for(Enquiry__c e: newList){
                e.Account_Record__c = accountMap.get(e.Email__c).Id;
                e.Contact_Record__c = contactMap.get(e.Email__c).Id;
            }
            
            
        }

        
    }
   
   
}