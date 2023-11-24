# -*- coding: utf-8 -*-
"""
Created on Wed Jun  5 14:25:27 2019

@author: SECRECTS LAB - ANIK
"""


import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('.lis')]
print(text_files)

filename="aes_power_f6_1255_v6.txt"

appendfile=open(filename,'a')
    
def volt_conversion(x):
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
           
        return v


powerfile=6  #startnumber
while(powerfile<1256):    #last file+1
    for f in range (len(text_files)):
        analogfile= text_files[f]
        for t in range (0, len(analogfile)):
            if (analogfile[t]=="_"):
                if(analogfile[t+1]=="f"):
                    if(analogfile[t+2]=="i"):
                        if(analogfile[t+3]=="l"):
                            tstart=t+2+4
                    
    
            if (analogfile[t]=="_"):
                if(analogfile[t+1]=="k"):
                    if(analogfile[t+2]=="e"):
                        if(analogfile[t+3]=="y"):
                             tln=t
                             astart =t+2
        #print("filen str:", analogfile[tstart:tln])            
        file_number=int(analogfile[tstart:tln])
        print("file :", file_number)
        print("Powerfile :", powerfile)
        

        if (powerfile == file_number):            
            with open (analogfile,'r') as outfile:
                linels=[]
                lines= outfile.readlines()          
                
                #for x_var in range (441326, 455527):
                for x_var_f in range (441000, 442000):
                    line2= str(lines[x_var_f])                    
                    list2= line2.split()
                    #print(list2)
                    try:
                        if (list2[0]== "n3" and list2[1]=="vdd"):    
                            startline= x_var_f+1
                    except: 
                        jj=100
                        
                #print(startline)        
                for x_var in range (startline, startline+14201):        
                    line1= str(lines[x_var])
                    
                    list1= line1.split()
                    
                    vdd=list1[2].strip("\n")
                    vdd= volt_conversion(vdd)
                    appendfile.write(str(vdd))
                    appendfile.write(" ")        
                #print(analogfile ,power)
                    #print(list1[0])
                appendfile.write("\n")
            print("Done:", powerfile)
            powerfile=powerfile+1
      
appendfile.close()       
print("Done......................")