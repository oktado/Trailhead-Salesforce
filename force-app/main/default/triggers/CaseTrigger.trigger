trigger CaseTrigger on Case (before insert, before update, after update) {
  if(trigger.isBefore){
    CaseClass.DefaultEntitlement(trigger.new);
  }

  if(trigger.isAfter){
    if(trigger.isUpdate){
      if (UserInfo.getUserType() == 'Standard'){
        DateTime completionDate = System.now(); 
            List<Id> updateCases = new List<Id>();
            for (Case c : Trigger.new){
                    if (((c.isClosed == true)||(c.Status == 'Closed'))&&((c.SlaStartDate 
                        <= completionDate)&&(c.SlaExitDate == null)))
        updateCases.add(c.Id);
        }
    if (updateCases.isEmpty() == false)
    CaseClass.completeMilestone(updateCases, 'Resolution Time', completionDate);
    }
    }
  }
}