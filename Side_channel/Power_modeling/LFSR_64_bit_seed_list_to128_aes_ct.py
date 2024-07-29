# -*- coding: utf-8 -*-
"""
Created on Thu Nov  3 10:38:37 2022

@author: Md Toufiq Hasan Anik
"""

import aes

#mk = 0x37d0d724d00a1248db0fead349f1c09b
mk = 0x0000000000008F31A1F39DD7CEE38C3B
cipher = aes.aes(mk, 128)

repeat=1000
bits=64
scale = 16 ## equals to hexadecimal
#memory_str="9205D6F95EED44CB" #h205D6F95EED44CB
#memory=bin(int(memory_str, scale))[2:].zfill(bits)

seed_file=open("seed_list.txt","r")

file=open("AES_HOST_24_LFSR_seed_list_1000_repeat_20k_pt.csv","w")
filcte=open("AES_HOST_24_LFSR_seed_list_1000_repeat_20k_ct_all.csv","w")



l=[]
c=0

seeds=seed_file.readlines()

for ln in range(20): # this value multiply by repeat
    memory_str=seeds[ln][0:-1]
    print(memory_str)
    #memory_str="9205D6F95EED44CB" #h205D6F95EED44CB
    memory=bin(int(memory_str, scale))[2:].zfill(bits)
    print(memory)
#%%
    file.write(memory_str+"\n")
    ct = cipher.enc_once(int(memory_str+memory_str,16))
    print(ct)
    chipher=hex(aes.utils.arr8bit2int(ct))[2:].zfill(32)
    print(chipher)
    filcte.write(chipher+"\n")
    
    for t in range (0, repeat-1):    
        #feedback=int(memory[0]) ^ int(memory[10]) ^ int(memory[3]) ^ int(memory[5])  
        feedback=int(memory[23]) ^ int(memory[22]) ^ int(memory[21]) ^ int(memory[16])  
        memory=str(feedback)+memory[0:-1]
        
        lfsr= hex(int(memory, 2))[2:].zfill(int(bits/4)).upper()
        if lfsr in l:
            print("error")
            c=c+1
            print(c)
        l.append(lfsr)
        plaintext=lfsr+lfsr
        #print(plaintext)
        ct = cipher.enc_once(int(plaintext,16))
        #print(ct)
        chipher=hex(aes.utils.arr8bit2int(ct))[2:].zfill(32)
        
        #file.write(lfsr+"\n")
        file.write(plaintext+"\n")
        filcte.write(chipher+"\n")
    
print(c)

file.close()
filcte.close()