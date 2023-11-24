"""Written By:  Md Toufiq hasan Anik

CSEE, UMBC JV38613
Email: toufiqhanik@umbc.edu
Date: 5.18.19(2.19 am)
"""

import os

def makemydir(new):
  try:
    os.makedirs(new)
  except OSError:
    pass

#
path = "./sim1"
os.makedirs(path);
for vdd in range (100,141,4):

  #makemydir("V"+str(vdd/100))
  
  #path = "./V"+str(vdd/100)+"/sim1"
  

  
  for tmp in range (0,41,4):
        s = open("npna_buffer_frame.sp").read()
        
        #s = s.replace('thalfn', thalfn)
        #s = s.replace('tfulln', tfulln)

        s = s.replace('tempvar',str(tmp))
        s = s.replace('vddvar', str(vdd/100))
        s = s.replace('vddhalfvar', str(vdd/200))
        #pa=s
        #s = s.replace('MONTE_MODE', str("5"))
        #s = s.replace('SIM_MODE',str("0"))    

        
    

        filename="npna_buff_v"+str(vdd/100)+"_t"+str(tmp)
        filename_sim=filename#"_sim0"
        filenamesp= filename_sim+".sp"
        f = open(filenamesp, 'w')
        f.write(s)
        f.close()


        """pa= pa.replace('SIM_MODE',str("1"))

        
            
        #pam = pam.replace('MONTE_MODE', str("1"))
        #pam = pam.replace('**FIRSTRUN= FIRSTRUN_MODE',"FIRSTRUN= "+str(paf))
        pa = pa.replace('**radegfile',".option radegfile='./"+filename_sim+".radeg0'")
        pf= open(path+"/"+filename+"_sim1.sp",'w')
        pf.write(pa)
        pf.close()"""
