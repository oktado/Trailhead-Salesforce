@isTest
public with sharing class TestRestrictContactByName {
    @isTest
    public static void TestRestrictContactByName1() {
        Test.startTest();
        Account acct = new Account(Name='Test Account');
        insert acct;
        Contact ct = new Contact(
            Firstname = 'Johnny',
            LastName = 'INVALIDNAME',
            AccountId = acct.Id
        );

        insert ct;
        
        Test.stopTest();
        Database.SaveResult ct_insert = Database.insert(ct);

        System.assert(!ct_insert.isSuccess());
        System.assert(ct_insert.getErrors().size() > 0);
        System.assertEquals('The Last Name "'+ct.LastName+'" is not allowed for DML',
                             ct_insert.getErrors()[0].getMessage());

    }

 
}