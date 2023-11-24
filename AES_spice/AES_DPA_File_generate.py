# -*- coding: utf-8 -*-
"""
Created on Wed Aug 14 12:21:39 2019

@author: SECRECTS LAB - ANIK
"""

import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('key_pt_dpa1.txt')]
print(text_files)
num_of_bits=128
s = open("aes_hspice_frame _reduced_clock.sp").read()


for f in range (len(text_files)):
    
    analogfile= text_files[f]
    
       
    with open (analogfile,'r') as outfile:
        
        linels=[]
        lines= outfile.readlines()        
        for x_var in range (1250,1300):       
            
            line1= str(lines[x_var])
            
            list1= line1.split()
            print(list1)
            
            key_str= int(list1[0],16)
            key_bin=bin(key_str)[2:].zfill(num_of_bits)
            
            print("key_bin: %s, lengt: %s" % (key_bin, len(key_bin)))
            
            pt_str= int(list1[1],16)
            pt_bin=bin(pt_str)[2:].zfill(num_of_bits)
            print("pt_bin: %s, lengt: %s" % (pt_bin, len(pt_bin)))
            
            filename="hsprc/26/aes_hspice_file_"+str(x_var+1)+"_key_"+list1[0]+"_pt_"+list1[1]+"_.sp"
            f=open(filename,"w")
            
            k_parameter=""
            din_parameter=""            
            
            pt_bins=str(pt_bin)
            key_bins=str(key_bin)
            parameters=""
            
            idxn=127
            for idx in range(128):
                
                if (key_bins[idx]=="1"):
                    kvolt="VDD_VALUE"
                else:
                    kvolt="0"
                
                if (pt_bins[idx]=="1"):
                    Dvolt="VDD_VALUE"
                else:
                    Dvolt="0"
                
                k_parameter=k_parameter+"VKin_"+str(idxn)+" Kin_"+str(idxn)+" GND PWL (0 "+kvolt+")\n"
                din_parameter=din_parameter+"VDin_"+str(idxn)+" Din_"+str(idxn)+" GND PWL (0 "+Dvolt+")\n"
                idxn=idxn-1
        
            parameters=k_parameter+"\n"+din_parameter        
            print(parameters)
            
            p = s.replace('paramvar', parameters)
            f.write(p)
            f.close()

        
                
                
                
                
                
                
