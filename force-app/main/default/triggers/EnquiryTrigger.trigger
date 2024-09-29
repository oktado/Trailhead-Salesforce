trigger EnquiryTrigger on Enquiry__c (before insert) {
		EnquiryClass.createContactAccountBulkified(trigger.new);
}