"""Written By:  Md Toufiq hasan Anik

CSEE, UMBC JV38613
Email: toufiqhanik@umbc.edu
Date: 2.12.19 (3:52pm)"""


import os

def makemydir(new):
  try:
    os.makedirs(new)
  except OSError:
    pass
  

makemydir("month_plots")

vtln=[]
mthln=[]
#appendFile= open('npa_re_clockhm_data_alarm.txt','a')
rearrfile=open ("npa_clockhm_re_ver1 _v1.0_1.4_t_0_40_data_alarm.txt",'a')

with open ("npa_clockhm_ver1 _v1.0_1.4_t_0_40_data_alarm.txt",'r') as outfile:
    lines= outfile.readlines()

    for month in range (2,85,2):
      month_plotfile="./month_plots/npa_month_"+str(month)+"_data.dat"
      appendFile= open(month_plotfile,'a')
      
      for n in range(len(lines)):
          linen=lines[n].split()

          if (linen[2]== str(month)):
            mthln.append(n)

      for vdd in range (100,141,4):
        
        vt=str(vdd/100)
        
        for lm in mthln:

            linem=lines[lm].split()

            if (linem[0] == str(vt)):

              vtln.append(lm)

        for tmp in range (0,41,4):            

          for lmt in vtln:

            linet=lines[lmt].split()

            if (linet[1] == str(tmp)):
                           
              appendFile.write(lines[lmt])
              rearrfile.write(lines[lmt])
              print(lines[lmt])
              
        vtln=[]
      mthln=[]
      appendFile.close()

      
        

                
    """for vdd in range (100,141,4):

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
      vtln=[]"""

        
                




rearrfile.close()
print("done")

      

                

            

            
            

            

            

          
          

      
