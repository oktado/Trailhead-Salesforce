@isTest
private class AccountManagerTest {
    @isTest static void getAccountTest() {
        id AccountId = createTestRecord();

        RestRequest request = new RestRequest();
        request.requestUri =
            'https://resourceful-narwhal-e4dz6v-dev-ed.trailblaze.lightning.force.com/services/apexrest/Accounts/'
            +AccountId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        Assert.isTrue(thisAccount != null);
        Assert.areEqual('Test Account', thisAccount.Name);
    }


    static Id createTestRecord() {
        // Create test record
        Account AccountTest = new Account(
            Name= 'Test Account');
        insert AccountTest;

        Contact con = new Contact(Lastname='Test cont',AccountId=AccountTest.Id);
        insert con;
        return AccountTest.Id;
    }
}