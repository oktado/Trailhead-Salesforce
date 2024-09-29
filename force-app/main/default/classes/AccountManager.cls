@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {

    @HttpGet
    global static Account getAccount() {
        RestRequest req = RestContext.request;
        String idAcc = req.requestURI.substringBetween('/Accounts/','/contacts');


        Account result =  [SELECT Id,Name,(select Id,Firstname,Lastname from Contacts)
                                    FROM Account
                                    WHERE Id = :idAcc];
        return result;
    }
}