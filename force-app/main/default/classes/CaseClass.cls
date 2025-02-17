public with sharing class CaseClass {
    public static void DefaultEntitlement  (Case[] newCase) {
        Set<Id> contactIds = new Set<Id>();
        Set<Id> acctIds = new Set<Id>();
        for (Case c : newCase) {
            contactIds.add(c.ContactId);
            acctIds.add(c.AccountId);
        }
        List <EntitlementContact> entlContacts = 
                    [Select e.EntitlementId,e.ContactId,e.Entitlement.AssetId 
                    From EntitlementContact e
                    Where e.ContactId in :contactIds
                    And e.Entitlement.EndDate >= Today 
                    And e.Entitlement.StartDate <= Today];
        if(entlContacts.isEmpty()==false){
            for(Case c : newCase){
                if(c.EntitlementId == null && c.ContactId != null){
                    for(EntitlementContact ec:entlContacts){
                        if(ec.ContactId==c.ContactId){
                            c.EntitlementId = ec.EntitlementId;
                            if(c.AssetId==null && ec.Entitlement.AssetId!=null)
                                c.AssetId=ec.Entitlement.AssetId;
                            break;
                        }
                    } 
                }
            } 
        } else{
            List <Entitlement> entls = [Select e.StartDate, e.Id, e.EndDate, 
                    e.AccountId, e.AssetId
                    From Entitlement e
                    Where e.AccountId in :acctIds And e.EndDate >= Today 
                    And e.StartDate <= Today];
            if(entls.isEmpty()==false){
                for(Case c : newCase){
                    if(c.EntitlementId == null && c.AccountId != null){
                        for(Entitlement e:entls){
                            if(e.AccountId==c.AccountId){
                                c.EntitlementId = e.Id;
                                if(c.AssetId==null && e.AssetId!=null)
                                    c.AssetId=e.AssetId;
                                break;
                            }
                        } 
                    }
                } 
            }
        }
    }
    
    
    public static void completeMilestone(List<Id> caseIds, 
            String milestoneName, DateTime complDate) {  
            List<CaseMilestone> cmsToUpdate = [select Id, completionDate
            from CaseMilestone cm
            where caseId in :caseIds and cm.MilestoneType.Name=:milestoneName 
            and completionDate = null limit 1];
    if (cmsToUpdate.isEmpty() == false){
        for (CaseMilestone cm : cmsToUpdate){
            cm.completionDate = complDate;
            }
        update cmsToUpdate;
        }
    }
   

}