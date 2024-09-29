@isTest
public class ParkLocatorTest {

    @isTest
    public static void testCallout() {
        try {
            Test.setMock(WebServiceMock.class, new ParkServiceMock());

            String country = 'India';
            String[] result = ParkLocator.country(country);
    
            List<String> expected = new List<String>{'Anamudi Shola National Park','Anshi National Park','Bandipur National Park'};
    
            Assert.areEqual(expected, result);
     
        } catch (Exception exc) {
            System.debug(exc.getMessage());
        } 

    }
}