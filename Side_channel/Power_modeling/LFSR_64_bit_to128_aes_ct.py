# -*- coding: utf-8 -*-
"""
Created on Thu Nov  3 10:38:37 2022

@author: Md Toufiq Hasan Anik
"""

import aes

mk = 0x37d0d724d00a1248db0fead349f1c09b
cipher = aes.aes(mk, 128)

bits=64
scale = 16 ## equals to hexadecimal
memory_str="9205D6F95EED44CB" #h205D6F95EED44CB
memory=bin(int(memory_str, scale))[2:].zfill(bits)

file=open("AES_LFSR_0to9_10k_205D6F95EED44CB_100K_all.csv","a")
filcte=open("AES_LFSR_0to9_10k_205D6F95EED44CB_100K_cipher_all.csv","a")

l=[]
c=0
print(memory)

file.write(memory_str+"\n")
ct = cipher.enc_once(int(memory_str+memory_str,16))
print(ct)
chipher=hex(aes.utils.arr8bit2int(ct))[2:].zfill(32)

filcte.write(chipher+"\n")

for t in range (0, 9999):    
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
    
    file.write(lfsr+"\n")
    filcte.write(chipher+"\n")
    
print(c)

file.close()
filcte.close()