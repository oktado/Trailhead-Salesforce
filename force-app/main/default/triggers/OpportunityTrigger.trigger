trigger OpportunityTrigger on Opportunity (after insert, after update) {
  OpportunityClass.closeOpp(Trigger.new);
}