public with sharing class LeadClass {
    public final String API_STREET = 'https://www.smarty.com/products/single-address?street=';
    public static void getTokenSetupPassword(Lead[] newRecordList){
        String LeadId;
        String City;
        String Street;
        String Country;
        for(Lead l: newRecordList){
            LeadId = l.Id;
            if(l.City <> NULL)
            {
                City = l.City;
            }
            if(l.Street <> NULL)
            {
                Street = l.Street;
            }
            if(l.Country <> NULL)
            {
                Country = l.Country;
            }
        }

        if(Street <> null && City <> null){
            getApiStreet(Street,City,LeadId);
        }
    }


    @future (callout=true)
    public static void getApiStreet(String Street,String City, String LeadId){
        List<Lead> LeadToUpdate = new List<Lead>();
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://www.smarty.com/products/single-address?street='+Street+'&address-type=us-street-freeform');
            request.setMethod('GET');
            HttpResponse response = http.send(request);

            Map<String, Object> resultMap =   (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

            system.debug('token ===>'+response.getBody());

            /*if(){
                for(Lead l: [SELECT Id,Address_Verified__c FROM Lead WHERE Id =: Lead]){
                    l.Address_Verified__c = true;
                    LeadToUpdate.add(l);
                }

                update LeadToUpdate;
            }*/
        } catch (Exception error) {
            System.debug('The following exception has occurred: ' + error.getMessage());
        }
    }
}