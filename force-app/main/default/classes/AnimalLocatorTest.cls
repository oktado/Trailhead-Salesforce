@isTest
public class AnimalLocatorTest {

    @isTest
    public static void AnimalLocatorMockTest() {
        try {
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String result = AnimalLocator.getAnimalNameById(1);
        System.assertEquals(result, 'chicken');
        } catch (Exception exc) {
           System.debug(exc.getMessage()); 
        } 
    }
}