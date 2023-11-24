# -*- coding: utf-8 -*-
"""
Created on Wed Jun  5 14:25:27 2019

@author: SECRECTS LAB - ANIK
"""


import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('.csv')]
print(text_files)



filename="power_all_anik.txt"  
appendFile= open(filename,'a')  
    

for f in range (len(text_files)):
    analogfile= text_files[f]
    for t in range (len(analogfile)-11, len(analogfile)):
        if (analogfile[t]=="-"):
            if(analogfile[t+1]=="-"):
                tstart=t+2
                

        if (analogfile[t]=="."):
            if(analogfile[t+1]=="c"):
                 tln=t
                 
    trace_number=int(analogfile[tstart:tln])
    print("trace_number:", trace_number+1)
    
    with open (analogfile,'r') as outfile:
        linels=[]
        lines= outfile.readlines()
        
        for x_var in range (5, len(lines)):
            
            line1= str(lines[x_var])
            
            list1= line1.split(',')
            
            power= round(float(list1[1][:-1])*1000,4)
                
            #print("lines:", power)
            appendFile.write(str(power))
            appendFile.write(' ')
        appendFile.write('\n')

appendFile.close()