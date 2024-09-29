public class ParkLocator {
    public static String[] country(String country) {
        ParkService.ParksImplPort parkservice = new  ParkService.ParksImplPort();

        return parkservice.byCountry(country);
    }
}