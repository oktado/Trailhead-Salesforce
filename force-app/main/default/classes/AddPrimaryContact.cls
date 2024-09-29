public with sharing class AddPrimaryContact implements Queueable {
   
        private Contact contacts;
        private String state;

        public AddPrimaryContact(Contact contacts, String state) {
            this.contacts = contacts;
            this.state = state;
        }

        
        public void execute (QueueableContext context) {
            List<Account> accList =  [SELECT Id,BillingState FROM Account WHERE BillingState =:state LIMIT 200];

            List <Contact> conList = new List <Contact>();
            
            for(Account acc : accList){
                Contact contactClone = contacts.Clone();
                contactClone.AccountId = acc.id;
                conList.add(contactClone);
            }
            insert  conList;
        }
        
}