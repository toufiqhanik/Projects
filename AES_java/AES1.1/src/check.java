
public class check {

	public static void main(String[] args) {
		
		String inputbyte = "00101101";
		String mixbyte;
		if (inputbyte.charAt(0)=='1') {
			//if fist bit is 1, then shift left one bit and pad 0 to the last bit and xor with 00011011
			   mixbyte =inputbyte.substring(1,8)+"0";				   		    
				
			   mixbyte= AES.XOR(AES.digitarray (mixbyte), AES.digitarray ("00011011"));   	   
			   System.out.println("xored");
		   }
		   else {
			 //if fist bit is 0, then shift left one bit and pad 0 to the last bit
			   mixbyte =inputbyte.substring(1,8)+"0";
		   }
		
		System.out.println(mixbyte);
	}
	
}
