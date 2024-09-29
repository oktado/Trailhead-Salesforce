public class isPrime {
    //code here 
    public static Boolean check(Integer num){      
        if(num <= 1){
            return false;
        } else {
             for(Integer i = 2;i <= num -1;i++){
        if(math.mod(num,i) == 0){
            return false;
        } 
    	}
    	return true;
        }
    }

}