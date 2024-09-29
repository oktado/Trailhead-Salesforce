public class OpportunitySchedule Implements Schedulable{
    public void execute(SchedulableContext sc) {
        OpportunityBatch oppBatch = new OpportunityBatch();
        Id BatchId = Database.executeBatch(oppBatch);
    }
}