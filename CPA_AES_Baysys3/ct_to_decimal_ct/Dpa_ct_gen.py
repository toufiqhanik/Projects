# -*- coding: utf-8 -*-
"""
Created on Wed Jun  5 14:25:27 2019

@author: SECRECTS LAB - ANIK
"""


import os
path = '.'
#text_files = [f for f in os.listdir(path) if f.endswith('.csv')]
#print(text_files)



filename="key_pt_dpa1_ctext.txt"  
#readfile= open(filename,'r')  
appendFile= open("ct_anik_6_1557.txt",'a') 
    
with open (filename,'r') as outfile:
    linels=[]
    lines= outfile.readlines()
    
    for x_var in range (5, 1257):
        
        line1= str(lines[x_var])
        
        list1= line1.split()
        
        #power= round(float(list1[1][:-1])*1000,4)
        for byte in range (0,31,2):
            data=int(list1[2][byte:byte+2],16)
            print(data)
            
            appendFile.write(str(data))
            appendFile.write('\n')

appendFile.close()
print("******Done******")