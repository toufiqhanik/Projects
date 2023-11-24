"""Written By:  Md Toufiq hasan Anik

CSEE, UMBC JV38613
Email: toufiqhanik@umbc.edu
Date: 5.18.19(2.19 am)
Update :6.5.19 12.54 ro sensor generation
"""


  
for tmp in range (0,91):    
    s = open("ros_frame.sp").read()   
    
    s = s.replace('tempvar',str(tmp))
    filename="ros"+"_t"+str(tmp)
    
    filenamesp= filename+".sp"
    f = open(filenamesp, 'w')
    f.write(s)
    f.close()


