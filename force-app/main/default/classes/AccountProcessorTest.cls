@IsTest
public with sharing class AccountProcessorTest {
    @IsTest
    public static void countContacts() {

        List<Account> accToInsert = new List<Account>();
        List<Contact> cToInsert = new List<Contact>();
        List<Id> IdToSeacrh = new List<Id>();

        Account a = new Account(
            Name = 'test acc'
        );
        accToInsert.add(a);
        Insert accToInsert;

        Contact c = new Contact(
            FirstName = 'firstname',
            LastName = 'lastname',
            AccountId = a.Id
        );
        cToInsert.add(c);
        Insert c;

        IdToSeacrh.add(a.Id);
        Test.startTest();

        AccountProcessor.countContacts(IdToSeacrh);
        Test.stopTest();

        List<Contact> contacts = [SELECT Id,AccountId FROM Contact WHERE AccountId  =:a.Id];
        system.debug('contacs ===>'+contacts);        
        System.assertEquals(1, contacts.size());
    }
}