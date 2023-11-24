import java.sql.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;


 
public class AES {
	public static void main(String[] args) {
		
		// Round 0
		//Taking Plain text as input
		ArrayList<String> boxArray = new ArrayList<String>();
		//CNG here
		boxArray= Fileinput("planetextEx1.txt"); //("input.txt");//("CipherTextcheck.txt");//
		
		//Taking Key as input
		ArrayList<String> keyboxArray = new ArrayList<String>();
		keyboxArray= Fileinput ("keytextEx1.txt");//("key.txt");//("CipherTextcheckkey.txt");//
		
		// Putting the input to Box Array
		String [] [] Mainbox = putintobox (boxArray);
		// Putting the input to Key Box Array
		String [] [] keybox = putintobox (keyboxArray);
		
		//Round 0 Key XOR
		Mainbox = inputXorwithkey (Mainbox,keybox);
		
		for (int i=1; i<10; i++) {
				
		//Round 1 to 9
		
		//Start of Round
		
		//System.out.println("Mainbox :");
		//print(Mainbox);
		
		//Sub Bytes
			
		//System.out.println("Sub Byte Box :");
		Mainbox =replaceMainboxtoSubbox (Mainbox);
		//print(Mainbox);
		
		//Shift Row
		
		Mainbox = shift(Mainbox);
		//System.out.println("After shift Byte Box :");
		//print(Mainbox);
		
		//mix column
		
		Mainbox = mixcolumn(Mainbox);
		//System.out.println("After Mixcolumn Box :");
		//print(Mainbox);
		//if (i==1) {break;}
		//Round Key
		
		keybox =RoundKey(keybox, i);
		
		//System.out.println("After RoundKEy keyBox :");
		//print(keybox);
		
		Mainbox = inputXorwithkey (Mainbox,keybox);
		if (i==9) {break;}
		
		}
		
		
		//System.out.println("Final AES encryption After mix column box Box in hex :");
		//PrintBoxInHex(Mainbox);
		
		//Round 10
		
		//S-BoX
		Mainbox =replaceMainboxtoSubbox (Mainbox);
		
		//Shift Row
		Mainbox = shift(Mainbox);
		
		keybox =RoundKey(keybox, 10);
		//Key Xor
		Mainbox = inputXorwithkey (Mainbox,keybox);
		
		//final AES Encryption
		System.out.println("Final AES encryption Box :");
		print(Mainbox);
		
		System.out.println("Final AES encryption Box in hex :");
		PrintBoxInHex(Mainbox);
		
		//System.out.println("Final AES encryption Key Box in hex :");
		//PrintBoxInHex(keybox);
		
		printCipherText(Mainbox);
	}
	
	
	
	
	
	
	public static String[][] RoundKey(String[][] box, int roundnumber){
		String[][] RoundKeybox = new String[4][4];
		
		//Flipping the first byte to last byte
		String[][] sKeybox = new String[4][1];
		sKeybox[0][0]= box[1][3];
		sKeybox[1][0]= box[2][3];
		sKeybox[2][0]= box[3][3];
		sKeybox[3][0]= box[0][3];
		
		// Sub byte box of Skey box					
		sKeybox[0][0]= hextobin (Sbox(Integer.parseInt(sKeybox[0][0].substring(0, 4), 2), Integer.parseInt(sKeybox[0][0].substring(4, 8), 2)));
		sKeybox[1][0]= hextobin (Sbox(Integer.parseInt(sKeybox[1][0].substring(0, 4), 2), Integer.parseInt(sKeybox[1][0].substring(4, 8), 2)));
		sKeybox[2][0]= hextobin (Sbox(Integer.parseInt(sKeybox[2][0].substring(0, 4), 2), Integer.parseInt(sKeybox[2][0].substring(4, 8), 2)));
		sKeybox[3][0]= hextobin (Sbox(Integer.parseInt(sKeybox[3][0].substring(0, 4), 2), Integer.parseInt(sKeybox[3][0].substring(4, 8), 2)));
		
		
		
		//System.out.println("sKeybox[0][0]: "+ sKeybox[0][0] + "  sKeybox[1][0]: "+sKeybox[1][0]);
		//System.out.println("sKeybox[2][0]: "+ sKeybox[2][0] + "  sKeybox[3][0]: "+sKeybox[3][0]);
		
		String [] RC= {"0", "00000001", "00000010", "00000100","00001000", "00010000", "00100000", "01000000","10000000","00011011","00110110"};
		
		for (int i =0; i<4; i++) {
			if (i==0) {
				//Adding RC to the S-key
				RoundKeybox[0][i]= XOR (digitarray(XOR (digitarray(box [0][i]), digitarray (sKeybox[0][i]))), digitarray(RC[roundnumber]));
				RoundKeybox[1][i]= XOR (digitarray(box [1][i]), digitarray (sKeybox[1][i]));
				RoundKeybox[2][i]= XOR (digitarray(box [2][i]), digitarray (sKeybox[2][i]));
				RoundKeybox[3][i]= XOR (digitarray(box [3][i]), digitarray (sKeybox[3][i])); 
				
			}
			
			else {
			RoundKeybox[0][i]= XOR (digitarray(box [0][i]), digitarray (RoundKeybox[0][i-1]));
			RoundKeybox[1][i]= XOR (digitarray(box [1][i]), digitarray (RoundKeybox[1][i-1]));
			RoundKeybox[2][i]= XOR (digitarray(box [2][i]), digitarray (RoundKeybox[2][i-1]));
			RoundKeybox[3][i]= XOR (digitarray(box [3][i]), digitarray (RoundKeybox[3][i-1]));
			}
			
			
		}
		
		
		
		//System.out.println("After Round Key");
		//print(RoundKeybox);
		return RoundKeybox;
		
	}
	
	
	
	
	
	
	public static String [][] mixcolumn (String[][] box) {
		
		/**String[][] matrix=new String[][]
			    {{"02","03","01","01"},
			     {"01","02","03","01"},
			     {"01","01","02","03"},
			     {"03","01","01","02"},
			    };
		**/
	   String[][] mixcolumbox=new String[4][4];
	    
		   
		   for (int i =0; i<4; i++) {
			   
			   // For U0		   
			   String byte00= TwoMultiplication (box[0][i]); // multiply with 02
			   String byte01= XOR (digitarray(TwoMultiplication (box [1][i])), digitarray (box[1][i]));// multiply with 03
			   String byte02= box[2][i];// multiply with 01 is same as before
			   String byte03= box[3][i];// multiply with 01 is same as before
			   
			   //Adding All the byte for U0
			   mixcolumbox[0][i]= XorAll( byte00, byte01, byte02, byte03);
			   
			   // For U1
			   String byte10= box[0][i]; 
			   String byte11= TwoMultiplication(box[1][i]);
			   String byte12= XOR (digitarray(TwoMultiplication (box [2][i])), digitarray (box[2][i]));
			   String byte13= box[3][i];
			   
			 //Adding All the byte for U1
			   mixcolumbox[1][i]= XorAll( byte10, byte11, byte12, byte13);
			   
			   // For U2
			   String byte20= box[0][i];
			   String byte21= box[1][i];
			   String byte22= TwoMultiplication(box[2][i]);
			   String byte23= XOR (digitarray(TwoMultiplication (box [3][i])), digitarray (box[3][i]));
			   
			 //Adding All the byte for U2
			   mixcolumbox[2][i]= XorAll( byte20, byte21, byte22, byte23);
			   
			   // For U3
			   String byte30= XOR (digitarray(TwoMultiplication (box [0][i])), digitarray (box[0][i]));
			   String byte31= box[1][i];
			   String byte32= box[2][i];
			   String byte33= TwoMultiplication (box [3][i]);
			   
			 //Adding All the byte for U3
			   mixcolumbox[3][i]= XorAll( byte30, byte31, byte32, byte33);
			   
			   
		   }
		    
		   return mixcolumbox;  
		  
		
	}
	

	//This function is for multiplying byte with 02
	public static String TwoMultiplication (String inputbyte) {
		
		String mixbyte="";
		if (inputbyte.charAt(0)=='1') {
			//if fist bit is 1, then shift left one bit and pad 0 to the last bit and xor with 00011011
			   mixbyte =inputbyte.substring(1,8)+"0";				   		    
				
			   mixbyte= XOR (digitarray (mixbyte), digitarray ("00011011"));   	   
			   
		   }
		   else {
			 //if fist bit is 0, then shift left one bit and pad 0 to the last bit
			   mixbyte =inputbyte.substring(1,8)+"0";
		   }
		
		return mixbyte;
	}
	
	
	//This function is for Adding all four bytes
	public static String XorAll(String xor1,String xor2,String xor3,String xor4) {
		String xorall1 = XOR (digitarray (xor1), digitarray (xor2));
		
		String xorall2 = XOR (digitarray (xor3), digitarray (xor4));
		
			
		String xorall = XOR (digitarray (xorall1), digitarray (xorall2));
		
		return xorall;
		
		
	}
	
	
	//This function is for S-box which replace the value of main box array from Rijndael box according the value
	public static String [][] replaceMainboxtoSubbox (String [] [] inputbox){
		
		String [][] box = new String [4][4];
		
		for (int i=0; i< box.length; i++ ) {
			for (int j=0; j< box.length; j++) {
				String inputbinary =inputbox [i][j];
				
				//Selecting the row and colum for S-box from binary value
				int row = Integer.parseInt(inputbinary.substring(0, 4), 2);
				int column =Integer.parseInt(inputbinary.substring(4, 8), 2);
				
				String hex = Sbox (row, column);
				
				String outputbinary = hextobin (hex);
								
				box[i][j]=outputbinary;
				
			}
		}
		return box;
			
		
		
	}
	
	
	
	
	//This function is for performing Xor between MainArray and Key Array
	public static String [] [] inputXorwithkey (String [] [] inputbox, String [] [] keyinputbox){
		
		String [][] Xorbox = new String [4][4];
		
		for (int i=0; i< Xorbox.length; i++ ) {
			for (int j=0; j< Xorbox.length; j++) {
				ArrayList<String> box1 =  digitarray (inputbox[i][j]);
				
				ArrayList<String> box2 = digitarray (keyinputbox[i][j]);
				 
				
				
				Xorbox[i][j] = XOR (box1, box2);
				//System.out.println("XOR output: "+ i +j +" " + Xorbox[i][j]);
				
			}
		}
		return Xorbox;
		
		
	}
	
	
		
		
	//This function is for putting the inputs to the Box Array 
	public static String [][] putintobox (ArrayList<String> subboxArray ) {
	String [][] box = new String [4][4];
	int boxarraylocation=0;
	for (int i=0; i< box.length; i++ ) {
		for (int j=0; j< box.length; j++) {
			box[j][i]= subboxArray.get(boxarraylocation);
			boxarraylocation++;
			
		}
	}
		
	
	return box;
	
	}
	
	
	/// //This function is for taking input from text files
	public static ArrayList<String> Fileinput (String inFile) {
		
		
		ArrayList<String> boxArray1 = new ArrayList<String>();
				File inputfile =new File(inFile);
				try {
					Scanner input =new Scanner (inputfile);
					String inputPlaintext = input.nextLine();
							
					//System.out.println(inputPlaintext);
								
					
								
					for (int i =0; i<128; i=i+8) {
						//int digit =Integer.parseInt( String.valueOf(inputPlaintext).substring(i,i+8));
						String digit =String.valueOf(inputPlaintext).substring(i,i+8);
					    //System.out.println("digit arrays"+ i + " is: "+digit);
					    
					    boxArray1.add(digit);
					    }
					
					System.out.println(boxArray1);
					input.close();
					
				} catch (FileNotFoundException ex){
					System.out.printf("Error:   %s\n", ex);
				}
				
				return boxArray1;
	}
	
	
	
	

	
	
	
	
	
	/// Separate the byte into array for calculation
	public static ArrayList<String> digitarray (String byteValue) {
		
		//int [] byteArray = new int [8];
		ArrayList<String> byteArray = new ArrayList<String>();
		
		for (int i =0; i<8; i++) {
			String digit = String.valueOf(byteValue).substring(i,i+1);
		    //System.out.println("digit"+ i + " is: "+digit);
		    byteArray.add(digit);
		}
		
		//System.out.println(byteArray);
		
		return byteArray;
	}
	
	
	
	
	
	// Shift box
	public static String [][] shift ( String num[] [] ) {
		
		String [][] shiftnum = new String [4] [4];
		
		shiftnum [0][0] =num[0][0];
		shiftnum [0][1] =num[0][1];
		shiftnum [0][2] =num[0][2];
		shiftnum [0][3] =num[0][3];
		
		// Shifting Second row to left by 1 Byte
		shiftnum [1][0] =num[1][1];
		shiftnum [1][1] =num[1][2];
		shiftnum [1][2] =num[1][3];
		shiftnum [1][3] =num[1][0];
		
		// Shifting Third row to left by 2 Byte
		shiftnum [2][0] =num[2][2];
		shiftnum [2][1] =num[2][3];
		shiftnum [2][2] =num[2][0];
		shiftnum [2][3] =num[2][1];
		
		// Shifting Fourth row to left by 2 Byte
		shiftnum [3][0] =num[3][3];
		shiftnum [3][1] =num[3][0];
		shiftnum [3][2] =num[3][1];
		shiftnum [3][3] =num[3][2];
		
		
		return shiftnum;
		
			}
	
	
	
	//XOR or Add the bytes
	public static String XOR (ArrayList<String> num1 , ArrayList<String> num2) {
		String  xorbyte="" ;
		String Zero = "0";
		String One = "1";
		//System.out.println("Xor num one: "+num1);
		//System.out.println("Xor num Two: "+num2);
		
		//int [] xorbyte = new int [8];
				for (int i =0; i < 8; i++  ) {
					
					int bit1= Integer.parseInt (num1.get(i));
					int bit2= Integer.parseInt (num2.get(i));
					//System.out.println("Xor bit1for i"+i+": is: "+ bit1 );
					//System.out.println("Xor bit1for i"+i+": is: "+ bit2 );
					if (bit1==1 & bit2==1) {
						xorbyte+= Zero;
					}
					else if (bit1==0 & bit2==1) {
						xorbyte+= One;
					}
					else if (bit1==1 & bit2==0) {
						xorbyte+= One;
					}
					else if (bit1==0 & bit2==0) {
						xorbyte+= Zero;
					}
				}
				//System.out.println("Xor value: "+xorbyte);
				return xorbyte;
						
	}
	
	
	// This Function returns the hex value from Rijndael S-box
	public static String Sbox (int row, int column) {
	
	String sbox[][]=new String[][]
		    {{"63" ,  "7C"  ,  "77" ,  "7B"  , "F2"  , "6B"  ,  "6F" , "C5"  ,  "30"  , "01"  ,  "67"   , "2B" ,   "FE"  ,   "D7" ,   "AB"  ,   "76"},
		     {"CA" ,  "82" ,   "C9" ,  "7D" , "FA" ,  "59"  ,  "47" ,   "F0" ,   "AD",   "D4",   "A2" ,   "AF" ,   "9C" ,   "A4"  ,  "72"   ,  "C0"},
		     {"B7" ,   "FD",  "93"  ,  "26" , "36" ,  "3F"  ,  "F7"  ,  "CC"  , "34"  ,  "A5" ,   "E5" ,    "F1" ,   "71" ,  "D8"  ,   "31"  ,  "15"},
		     {"04"  ,   "C7",   "23" ,   "C3",  "18",   "96" ,  "05" ,   "9A" ,  "07"  ,  "12"  ,  "80" ,   "E2" ,    "EB"  ,  "27" ,    "B2"  ,  "75"},
		     {"09"  ,   "83",   "2C",    "1A",  "1B" ,  "6E" ,   "5A"  , "A0"  , "52" ,  "3B"  ,  "D6" ,   "B3"   ,  "29"  ,  "E3"  ,   "2F"  ,  "84" },
		     {"53" ,    "D1",   "00",    "ED",  "20"  , "FC"  ,  "B1"   , "5B" ,  "6A"  ,  "CB" ,  "BE"  ,   "39"  ,  "4A"  ,  "4C" ,    "58"  ,  "CF" },
		     {"D0" ,    "EF" ,  "AA" ,   "FB",   "43",   "4D",   "33"  ,  "85",   "45",    "F9" ,   "02"  ,   "7F" ,   "50" ,   "3C",     "9F" ,   "A8"},
		     {"51" ,    "A3" ,  "40"  ,  "8F" ,  "92" ,  "9D" ,  "38"  ,  "F5" ,   "BC" ,  "B6" ,   "DA"   ,"21"   , "10"  ,  "FF"  ,    "F3" ,   "D2"},
		     {"CD" ,    "0C" ,   "13" ,    "EC" , "5F"  ,  "97" ,  "44"  ,  "17" ,   "C4" ,  "A7" ,  "7E"   ,  "3D"   , "64" ,   "5D"  ,  "19" ,   "73"},
		     {"60" ,    "81" ,   "4F" ,   "DC" , "22" ,  "2A"  , "90" ,   "88"  ,  "46" ,  "EE"  ,  "B8"  ,   "14"  ,  "DE",   "5E"  ,   "0B" ,   "DB"},
		     {"E0" ,    "32",    "3A" ,   "0A",  "49",   "06" ,  "24"  ,  "5C"  ,  "C2" ,  "D3" ,  "AC"   ,  "62",    "91" ,  "95"   ,  "E4",    "79"},
		     {"E7" ,    "C8" ,   "37" ,   "6D",  "8D" ,  "D5"  , "4E" ,   "A9"  ,  "6C",   "56"  ,  "F4"  ,   "EA"  ,  "65",   "7A" ,    "AE" ,   "08"},
		     {"BA" ,    "78" ,   "25",    "2E",   "1C",   "A6",   "B4" ,   "C6",    "E8" ,  "DD"   ,"74" ,    "1F"   , "4B" ,  "BD",     "8B",    "8A"},
		     {"70"  ,   "3E",   "B5"  ,  "66",   "48",  "03" ,  "F6" ,   "0E",     "61",   "35"   , "57"  ,   "B9",  "86" ,  "C1",     "1D" ,   "9E"},
		     {"E1",     "F8",     "98",    "11",   "69",   "D9"   ,"8E"   ,"94",    "9B",    "1E",    "87",    "E9",    "CE"  , "55",     "28"    ,"DF"},
		     {"8C" ,   "A1" ,   "89" ,   "0D" ,  "BF" ,  "E6"  ,  "42" ,   "68" ,   "41" ,  "99" ,   "2D" ,   "0F"  ,  "B0" ,  "54"  ,  "BB",    "16"}};
	
		        
		     return sbox [row][column];
	
	}
	
	
	// This Function Converts the String Hex Value to 8 bit String BInary value
	public static  String hextobin (String xy) {
		//String [] stringhexarray = xy.split("");
		
		String binarry ="";
		String nbinarry="";
		for (int i=0; i <xy.length(); i++) {
			
			switch(xy.charAt(i))
            {
                case '0':nbinarry="0000";break;
                case '1':nbinarry="0001";break;
                case '2':nbinarry="0010";break;
                case '3':nbinarry="0011";break;
                case '4':nbinarry="0100";break;
                case '5':nbinarry="0101";break;
                case '6':nbinarry="0110";break;
                case '7':nbinarry="0111";break;
                case '8':nbinarry="1000";break;
                case '9':nbinarry="1001";break;
                case 'A':nbinarry="1010";break;
                case 'B':nbinarry="1011";break;
                case 'C':nbinarry="1100";break;
                case 'D':nbinarry="1101";break;
                case 'E':nbinarry="1110";break;
                case 'F':nbinarry="1111";break;
                              
                 
                default:binarry="Error";break;
                }
			binarry=binarry+ nbinarry;
			//System.out.println("cahr"+ i+ "is :"+ nbinarry);
			
			
		}
		
		return binarry;
	}
	
	
	
	// This Function Converts the String BInary value to 8 bit String Hex Value
	public static  String bintohex (String xy) {
		
		 
		 String [] charecters= {xy.substring(0,4), xy.substring(4,8)};
		 
		
		String hex ="";
		String newhex="";
		for (int i=0; i <charecters.length; i++) {
			
			switch(charecters[i])
            {
                case "0000":newhex="0";break;
                case "0001":newhex="1";break;
                case "0010":newhex="2";break;
                case "0011":newhex="3";break;
                case "0100":newhex="4";break;
                case "0101":newhex="5";break;
                case "0110":newhex="6";break;
                case "0111":newhex="7";break;
                case "1000":newhex="8";break;
                case "1001":newhex="9";break;
                case "1010":newhex="A";break;
                case "1011":newhex="B";break;
                case "1100":newhex="C";break;
                case "1101":newhex="D";break;
                case "1110":newhex="E";break;
                case "1111":newhex="F";break;
                              
                 
                default:newhex="Error";break;
                }
			hex=hex+ newhex;
			//System.out.println("hex"+ i+ "is :"+ newhex);
			
			
		}
		
		return hex;
	}
	
	
	
	
	
	// This function prints the Array Box into binary value 
	public static void print (String boxprint [] []) {
		
			//int [][] boxprint = new int [4][4];
			for (int i=0; i< boxprint.length; i++ ) {
				for (int j=0; j< boxprint.length; j++) {
					// here to cng
					String printelement = boxprint[i][j]; 
					System.out.println("Box_location: Row: "+ i +" Column: "+j + " Value: "+ printelement);
				}
			}
			
			
		
		
	}
	
	// This function prints the Array Box into Hex value 
	public static void PrintBoxInHex (String boxprint [] []) {
		
		
		for (int i=0; i< boxprint.length; i++ ) {
			for (int j=0; j< boxprint.length; j++) {
				
				String printelement = bintohex(boxprint[i][j]); 
				System.out.println("Box_location: Row: "+ i +" Column: "+j + " Value: "+ printelement);
			}
		}
		
		
	
     }
	
	
	public static void printCipherText(String boxprint [] []) {
		
		ArrayList<String> CipherArray = new ArrayList<String>();
		String CipherText ="";
		
		//puting box to a string array
		for (int i=0; i< boxprint.length; i++ ) {
			for (int j=0; j< boxprint.length; j++) {
				
				CipherArray.add ( boxprint[j] [i]); 
				
			}
		}
					
			for( int l=0; l<16; l++) {
				//adding string array 
				CipherText = CipherText + CipherArray.get(l);
				
			}					
		 			
	    // output as text file
			//hereto cng
		File outputfile = new File("ciphertextEx2.txt");
		try {
			PrintWriter output = new PrintWriter(outputfile);
			output.println ("Cipher Text in binary");
			output.println (CipherText);
			output.close();
		} catch (IOException ex){
			System.out.printf("Error:   %s\n", ex);
		}
		
	}
	
	
}
