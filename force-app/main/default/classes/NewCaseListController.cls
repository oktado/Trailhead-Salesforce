public with sharing class NewCaseListController {
    public Case[] getNewCases() {

        List<Case>result = [Select Id,CaseNumber,Status From Case Where Status = 'New' ];
        return result;

    }
}