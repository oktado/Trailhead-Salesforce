@isTest
private class LeadProcessorTest {
    @TestSetup
    static void setup(){
        List<Lead> Leads = new List<Lead>();
        for(Integer i = 0;i < 200;i++){
            Leads.add(new Lead(FirstName = 'Test Lead', LastName = 'Lastname'+i, MobilePhone= '12212'+i, Company= 'Company'+i));
        }
        insert Leads;
    }
    
    @isTest 
    static void test() {
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();

        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);

    }
}