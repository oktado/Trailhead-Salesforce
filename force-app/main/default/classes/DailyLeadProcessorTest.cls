@IsTest
private class DailyLeadProcessorTest {
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2042';
    @IsTest
    static void testScheduledJob() {
        // Create some out of date Lead records
        List<Lead> opptys = new List<Lead>();
        for (Integer i=0; i<=200; i++) {
            Lead o = new Lead(
                Company = 'Company ' + i,
                LastName = ' Name '+i
            );
            opptys.add(o);
        }
        upsert opptys;
        // Get the IDs of the opportunities we just inserted
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new DailyLeadProcessor ());
        // Verify the scheduled job has not run yet.
        // Stopping the test will run the job synchronously
        Test.stopTest();
        // Now that the scheduled job has executed,
        // check that our tasks were created
     
    }
}