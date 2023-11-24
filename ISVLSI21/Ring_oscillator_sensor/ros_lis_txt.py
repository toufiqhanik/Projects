# -*- coding: utf-8 -*-
"""
Created on Wed Jun  5 14:25:27 2019

@author: SECRECTS LAB - ANIK
"""


import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('.lis')]
print(text_files)


for f in range (len(text_files)):
    analogfile= text_files[f]
    for t in range (0, len(analogfile)):
        if (analogfile[t]=="_"):
            if(analogfile[t+1]=="t"):
                tstart=t+2
                

        if (analogfile[t]=="."):
            if(analogfile[t+1]=="l"):
                 tln=t
                 
    temp=int(analogfile[tstart:tln])
    print("Temperature:", temp)
    
    with open (analogfile,'r') as outfile:
        linels=[]
        lines= outfile.readlines()
        
        for x_var in range (0, len(lines)):
            
            line1= str(lines[x_var])
            
            list1= line1.split()
            
            try:               
                if (list1[0]=="qr0"):
                    if (list1[1]=="qr1"):
                        if (list1[2]=="qr2"):
                            linels.append(x_var+2)
            except:
                k=100
                
        print("lines:", linels)