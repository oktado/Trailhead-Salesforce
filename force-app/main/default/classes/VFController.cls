public with sharing class VFController {
    public string username {get;set;}
    public string password {get;set;}
    public string statusLogin {get;set;}
    public void submitValidation() {
        if(this.username == 'xxx' && this.password == 'yyy'){
            this.statusLogin = 'Success Login';
        }else this.statusLogin = 'Failed Login';
    }
}