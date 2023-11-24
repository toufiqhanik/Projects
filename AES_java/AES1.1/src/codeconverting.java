
public class codeconverting {
	public static void main(String[] args) {

	
	String [][] shiftnum = new String [4][4]; //= {{"","","",""},{"","","",""},{"","","",""},{"","","",""},{"","","",""}};

	
	shiftnum [0][0] ="54";//"54";//"32";
	shiftnum [0][1] ="4F";//"73";//"88";
	shiftnum [0][2] ="4E";//"20";//"31";
	shiftnum [0][3] ="20";//"67";//"E0";
	
	// Shifting Second row to left by 1 Byte
	shiftnum [1][0] ="77";//"68";//"43";
	shiftnum [1][1] ="6E";//"20";
	shiftnum [1][2] ="69";//"4B";
	shiftnum [1][3] ="54";//"20";
	
	// Shifting Third row to left by 2 Byte
	shiftnum [2][0] ="6F";//"61";
	shiftnum [2][1] ="65";//"6D";
	shiftnum [2][2] ="6E";//"75";
	shiftnum [2][3] ="77";//"46";
	
	// Shifting Fourth row to left by 2 Byte
	shiftnum [3][0] ="20";//"74";
	shiftnum [3][1] ="20";//"79";
	shiftnum [3][2] ="65";//"6E";
	shiftnum [3][3] ="6F";//"75";
	
	AES.print (shiftnum);
	
	for (int i=0; i< shiftnum.length; i++ ) {
		for (int j=0; j< shiftnum.length; j++) {
			// here to cng
			shiftnum[i][j] = AES.hextobin(shiftnum[i][j]); 
			//System.out.println("Box_location: Row: "+ i +" Column: "+j + " Value: "+ printelement);
		}
	}
	AES.print (shiftnum);
	AES.printCipherText(shiftnum);
}
}
