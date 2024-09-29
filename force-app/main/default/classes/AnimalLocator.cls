public class AnimalLocator {

    public static String getAnimalNameById(Integer Id) {
        Map<String, Object> animal = new Map<String, Object>();
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+Id);
        req.setMethod('GET');

        HttpResponse res =  http.send(req);

        if(res.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());

            animal = ( Map<String, Object>) results.get('animal');

        }

        return String.valueOf(animal.get('name'));
    }
}