# -*- coding: utf-8 -*-
"""
Created on Thu Aug 15 13:49:10 2019

@author: SECRECTS LAB - ANIK
"""
from Crypto.Cipher import AES
import binascii

import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('key_pt_dpa2.txt')]
print(text_files)
filename='key_pt_dpa2_ctext.txt'
fo=open(filename,"a")
#s = open("aes_hspice_final_parameter.txt").read()


for f in range (len(text_files)):
    
    analogfile= text_files[f]
    
       
    with open (analogfile,'r') as outfile:
        
        linels=[]
        lines= outfile.readlines()
        for x_var in range (0, len(lines)):
            line1= str(lines[x_var])                
            list1= line1.split()
            #print(list1)
            key = binascii.unhexlify(list1[0])
            #print(key)
            encryptor = AES.new(key, AES.MODE_ECB)
            text = binascii.unhexlify(list1[1])
            ciphertext = encryptor.encrypt(text)
            pct=binascii.hexlify(ciphertext).upper()          
            pct2=str(pct)[2:len(pct)+2]
            print(pct2)            
            ctstr= list1[0]+" "+list1[1]+" "+pct2+"\n"
            fo.write(ctstr)

fo.close()