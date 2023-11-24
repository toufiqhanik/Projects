
"""Written By:  Md Toufiq hasan Anik

CSEE, UMBC JV38613
Email: toufiqhanik@umbc.edu
Date: 2.21.19 (2.27 pm"""



import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('npa_clockhm_data.txt')]
print(text_files)


    
tolerance= 5
uprange=18+tolerance
lowrange=18-tolerance



for f in range (len(text_files)):

    datafile= text_files[f]
    alarmfile=datafile[0:len(datafile)-4]+"_alarm.txt"
    
    with open (datafile,'r') as outfile:
        appendFile= open(alarmfile,'a')
        lines= outfile.readlines()

        x_var=0

        while (x_var<len(lines)):
                
            line1= str(lines[x_var])
                
            list0= line1.split()
            list1=list0

            clocknumber=float(list1[3])

            if(uprange>=clocknumber>=lowrange):
                 list1.append("0")
            else:
                list1.append("1")

            linestring= list1[0]+" "+list1[1]+" "+list1[2]+" "+list1[3]+" "+list1[4]+"\n"

                
            appendFile.write(linestring)
            x_var=x_var+1
                
    appendFile.close()

            
