@isTest
public with sharing class AddPrimaryContactTest {
    @isTest
    private static void setup() {
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < 500; i++){
            if(i < 250){
                accList.add(new Account(
                name = 'Test Account NY'+i,
                BillingState = 'NY'
            ));
            }else {
                accList.add(new Account(
                    name = 'Test Account CA'+ i,
                    BillingState = 'CA'
                ));
            }
        }
        

        insert accList;
        
        Contact contact = new Contact(FirstName='John', LastName='Doe');
        insert contact;

        // Create our Queueable instance
        AddPrimaryContact updater = new AddPrimaryContact(contact, 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();
        Id jobId = System.enqueueJob(updater);
        Test.stopTest();
        // Validate the job ran. Check if record have correct parentId now
        List<Contact> contacts = [select Id from Contact where Contact.Account.Billingstate = 'CA'];
        System.assertEquals(200, contacts.size(), 'Error');
    }
}