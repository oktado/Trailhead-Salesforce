public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext ctx) {
        List<Lead> leads = [SELECT Id, LeadSource 
            FROM Lead
            WHERE LeadSource  = null];
        // Create a task for each opportunity in the list
        List<Lead> leadToUpdate = new  List<Lead>();
        for(Lead l: leads){
           l.LeadSource = 'Dreamforce';
           leadToUpdate.add(l);
        }
        update leadToUpdate;
        
    }
}