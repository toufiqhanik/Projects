"""Written By:  Md Toufiq hasan Anik

CSEE, UMBC JV38613
Email: toufiqhanik@umbc.edu
Date: 2.12.19 (3:52pm)"""

vtln=[]

appendFile= open('npna_base_re_clockhm_middle_data_alarm.txt','a')


with open ("npna_base_clockhm_middle_data_alarm.txt",'r') as outfile:
    lines= outfile.readlines()
    for vdd in range (100,141,4):

      vt=str(vdd/100)
       

      for n in range(len(lines)):

        linen=lines[n].split()

        if (linen[0]== vt):

          vtln.append(n)

      for tmp in range (0,41,4):            

        for lm in vtln:

          linem=lines[lm].split()

          if (linem[1] == str(tmp)):
            appendFile.write(lines[lm])
            print(lines[lm])
      vtln=[]

        
                




appendFile.close()
print("done")

      

                

            

            
            

            

            

          
          

      
