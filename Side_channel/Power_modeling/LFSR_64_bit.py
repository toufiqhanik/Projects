# -*- coding: utf-8 -*-
"""
Created on Thu Nov  3 10:38:37 2022

@author: Md Toufiq Hasan Anik
"""


bits=64
scale = 16 ## equals to hexadecimal
memory_str="5205D6F95EED44CB"
memory=bin(int(memory_str, scale))[2:].zfill(bits)

file=open("Present_LFSR_12345_20k_205D6F95EED44CB_23_22_21_16_100K_all.txt","a")

l=[]
c=0
print(memory)

file.write(memory_str+"\n")
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
    print(lfsr)
    file.write(lfsr+"\n")
    
print(c)

file.close()