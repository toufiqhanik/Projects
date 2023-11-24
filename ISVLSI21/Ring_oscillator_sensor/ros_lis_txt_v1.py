# -*- coding: utf-8 -*-
"""
Created on Wed Jun  5 14:25:27 2019

@author: SECRECTS LAB - ANIK
"""


import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('.lis')]
print(text_files)

def digitalv(x):
    for m in range (1,len(list1)):       
        v_str= x
        if( v_str[len(v_str)-1]=="m"):
            v_str=v_str.strip("m")
            v=float(v_str)/1000
        elif( v_str[len(v_str)-1]=="u"):
            v_str=v_str.strip("u")
            v=float(v_str)/1000000
        elif( v_str[0]=="-"):
            v_str=v_str.strip("u")
            v=0
        elif( v_str[len(v_str)-1]=="n"):
            v_str=v_str.strip("n")
            v=float(v_str)/1000000000
        else:
            v=float(v_str)
            
        if (v >=0.9):
            v_value= "1"
        elif(v >=0.3 and v <0.9):            
            v_value= "x"                
        else:
            v_value= "0"           
            
        return v_value
    
    
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
        
        for pv in range (0, len(linels)):
            
           
            filename="RO_Sensor_PV_"+str(pv)+".txt"
            
            bitout=""
            lnnum=int(linels[pv])
            for reg in range (0,4):
                
                if(reg<3):                    
                    line2= str(lines[lnnum])         
                    list2= line2.split()
                    bitout=bitout+digitalv(list2[1])+digitalv(list2[2])+digitalv(list2[3])
                elif(reg==3):
                    line2= str(lines[lnnum])        
                    list2= line2.split()
                    bitout=bitout+digitalv(list2[1])
                lnnum=lnnum+8  
                
        
            print("Register output",bitout)
                
            appendFile= open(filename,'a')
            appendFile.write(str(temp))
            appendFile.write(' ')
            appendFile.write(bitout)
            appendFile.write(' ')
            appendFile.write(str(int(bitout,2)))
            appendFile.write('\n')
            appendFile.close()
            