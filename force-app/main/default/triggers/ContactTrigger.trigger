trigger ContactTrigger on Contact (after insert, after update, after delete,after undelete) {

    switch on Trigger.operationType {
        when BEFORE_INSERT{
        }
        when AFTER_INSERT {
            ContactClass.contactAfterInsert(trigger.new);
            ContactClass.createWishTask(trigger.new);

        }
        when AFTER_UPDATE {
            ContactClass.contactAfterUpdate(trigger.new, trigger.oldMap);
        }
        when AFTER_DELETE {
            ContactClass.contactAfterDelete(trigger.old);
        }
        when AFTER_UNDELETE {
            ContactClass.contactAfterUndelete(trigger.new);
        }
    }
}