"""Written By:  Md Toufiq hasan Anik

CSEE, UMBC JV38613
Email: toufiqhanik@umbc.edu
Date: 4.3.19 12.27am for checking alarm with new defination of intial and middle change"""


import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('data_digital.txt')]
print(text_files)

filename="pa_clockhm_middle_data_alarm.txt"

for f in range (len(text_files)):

    
    analogfile= text_files[f] #file

    #data collect from name tag
    for v in range (0, len(analogfile)):
        if (analogfile[v]=="_"):
            if(analogfile[v+1]=="t"):
                vln=v

        if (analogfile[v]=="_"):
            if(analogfile[v+1]=="v"):
                vstart=v+2
                
                    
    voltage=float(analogfile[vstart:vln])
    print("V:", voltage)
    
    for t in range (4, 20):
        if (analogfile[t]=="_"):
            if(analogfile[t+1]=="d"):
                if(analogfile[t+2]=="a"):
                    tmp=t
    
    
    temperature=int(analogfile[(vln+2):tmp])
    print("t:", temperature)

    """for t in range (15, 37):
        if (analogfile[t]=="_"):
            if(analogfile[t+1]=="d"):
                if(analogfile[t+2]=="a"):
            
                    mnt=t

    month=int(analogfile[(tmp+12):mnt])
    print("Month:", month)"""

  

    alarm=0  
    
    with open (analogfile,'r') as outfile:
        
        lines= outfile.readlines()
        

        line0= str(lines[0])
        list0= line0.split()
        line16= str(lines[16])
        list16= line16.split()

        for clk in range (3, len(list0)):
            
            initial=list0[clk] #checking initial          

            middle=list16[clk]
            print("Clk:", clk)
            print("Initial:", initial)
            print("middle:", middle)

            if (initial!=middle):
                if (alarm==0):
                    alarm=1
  
    appendFile= open(filename,'a')
    appendFile.write(str(voltage))
    appendFile.write(' ')
    appendFile.write(str(temperature))
    appendFile.write(' ')
    #appendFile.write(str(month))
    #appendFile.write(' ')
    
    if (alarm==1):                    
        appendFile.write("1")
    else:
        appendFile.write("0")

    appendFile.write('\n')
        



appendFile.close()
#dappendFile.close()
print("*******Done********")



