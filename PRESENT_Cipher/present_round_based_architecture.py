# -*- coding: utf-8 -*-
"""
Created on Wed Sep  2 00:09:43 2020

@author: Md Toufiq Hasan Anik
email : toufiqhanik@umbc.edu
read paper: https://iacr.org/archive/ches2007/47270450/47270450.pdf

Note: This code is written for practice and debug purpose of hardware inplementation of PRESENT-80 chipher
"""

#import os
path = '.'
analogfile = 'Present_PLAIN.txt'
write_file="Present_ciphertext.txt"

w_file=open(write_file,'w')

key_num_of_bits=80
data_num_of_bits=64


#        0   1   2   3   4   5   6   7   8   9   a   b   c   d   e   f
Sbox= [0xc,0x5,0x6,0xb,0x9,0x0,0xa,0xd,0x3,0xe,0xf,0x8,0x4,0x7,0x1,0x2]
Sbox_inv = [Sbox.index(x) for x in range(16)]
PBox = [0,16,32,48,1,17,33,49,2,18,34,50,3,19,35,51,
        4,20,36,52,5,21,37,53,6,22,38,54,7,23,39,55,
        8,24,40,56,9,25,41,57,10,26,42,58,11,27,43,59,
        12,28,44,60,13,29,45,61,14,30,46,62,15,31,47,63]
PBox_inv = [PBox.index(x) for x in range(64)]

def bin_list_to_hex(state):
    state="".join(state)
    state=hex(int(state, 2))
    #print("binTohex:", state)
    return state[2:]


def rotate(inp,r):
   #print ("rotate IN: ", bin_list_to_hex(inp))
   d=61
   Lfirst = inp[0 : d]
   #print("Lfirst:",bin_list_to_hex(Lfirst))
   Lsecond = inp[d :]
   #print("Lsecond:",bin_list_to_hex(Lsecond))
   Rfirst = inp[0 : len(inp)-d]
   Rsecond = inp[len(inp)-d : ]
   lr=(Lsecond + Lfirst)
   rr=(Rsecond + Rfirst)
   if (r=="l"):
       #print ("Left Rotation : ", bin_list_to_hex(lr))
       return lr
   else:
       #print ("Right Rotation : ", bin_list_to_hex(rr) )
       return rr
   

def arddRondKeys(state,key):
   # print("arddRondKeysIn:", bin_list_to_hex(state))
    for ind in range (0, len(state)):
        state[ind]=str(int(state[ind])^int(key[ind]))
    #print("arddRondKeysOut:", bin_list_to_hex(state))
    return state
    

def sBoxLayer(state): ## Not done in loop just to make it look like round based 16 parallel sbox.
    #print("SboxIn", bin_list_to_hex(state))
    boxlength=4
    init=0
    final=4
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(4))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    
    
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    
    
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    
    
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))
    init= init+boxlength
    final=final+boxlength
    state[init:final]= list(bin(Sbox[int("".join(state[init:final]),2)])[2:].zfill(boxlength))

    #print("SboxOut", bin_list_to_hex(state))
    return state

def pLayer(state):
    #print("pLayerIn:", bin_list_to_hex(state))
    state2=list("0000000000000000000000000000000000000000000000000000000000000000")
    for ind in range (len(state)):
        state2[PBox[ind]]=state[ind]
        
    #print("pLayerOut:", bin_list_to_hex(state2))
    return state2

def keySchedule(key_reg,counter):
    #counter
    #print("keyScheduleIn:", bin_list_to_hex(key_reg))
    c_bin=list(bin(counter)[2:].zfill(5))
    #print("C_bin", c_bin)
    
    #Key_schedule
    key_reg=rotate(key_reg,"l")
    #print("Output State:",bin_list_to_hex(key_reg))
    
    key_reg[0:4]=list(bin(Sbox[int("".join(key_reg[0:4]),2)])[2:].zfill(4))
    
    #print("pre_key_reg[19:15]", bin_list_to_hex(key_reg[79-19:79-15]))
    key_reg[79-19]=str(int(key_reg[79-19])^int(c_bin[0]))
    key_reg[79-18]=str(int(key_reg[79-18])^int(c_bin[1]))
    key_reg[79-17]=str(int(key_reg[79-17])^int(c_bin[2]))
    key_reg[79-16]=str(int(key_reg[79-16])^int(c_bin[3]))
    key_reg[79-15]=str(int(key_reg[79-15])^int(c_bin[4]))
            
    #print("key_reg[19:15]", key_reg[79-19:79-14])
    #print("keyScheduleOut:", bin_list_to_hex(key_reg))
    return key_reg
    
with open (analogfile,'r') as outfile:

    lines= outfile.readlines()
    for x_var in range (0, len(lines)): # change l to the len(G:\My Drive\SECRETS_LAB_Anik\Research\NSF\Present\Python)
                
        line1= str(lines[x_var])
        
        list1= line1.split()
        #print(list1)
        
        #key_str= int(list1[0],16)
        #key_str= int("8F31A1F39DD7CEE38C3B",16)
        key_str= int("0123456789ABCDEF0123",16) # Input the key hex here
        key_bin=bin(key_str)[2:].zfill(key_num_of_bits)
        #print("key_bin: %s, lengt: %s" % (key_bin, len(key_bin)))     
        #print("KeyIn:", bin_list_to_hex(key_bin))   
        #print(lines[x_var])
        pt_str= int(lines[x_var],16) #uncomment this one to read from the file.
        #pt_str= int("0123456789ABCDEF",16) ## Give input here

        pt_bin=bin(pt_str)[2:].zfill(data_num_of_bits)
        #print("pt_bin: %s, lengt: %s" % (pt_bin, len(pt_bin)))
        #print("PtIn:", bin_list_to_hex(pt_bin))   
        
        n_reset=0
        key_reg=[]
        pt_reg=[]
        
        if (n_reset==0 ):
            key_reg = list(key_bin)
            pt_reg = list(pt_bin)
        else:
            key_reg = key_reg 
            pt_reg = pt_reg
        
        
        for counter in range (1,32):
            #print("************************************************************************")
            print("Round:", counter)
            
            #addRoundKey()
            pt_reg=arddRondKeys(pt_reg,key_reg[0:64])
            print("Output State:",bin_list_to_hex(pt_reg))
            
            #sBoxLayer
            pt_reg=sBoxLayer(pt_reg)
            
            #pLayer
            pt_reg=pLayer(pt_reg)
            
            #keySchedule
            key_reg=keySchedule(key_reg,counter)
            
            #print("Output key_reg:",bin_list_to_hex(key_reg))
            
            
            
        
            #print("************************************************************************")
            
            #print("Output State:",bin_list_to_hex(pt_reg))
            #print("************************************************************************")
        
        #32th round
        #print("************************************************************************")
        #print("Round:", 32)
        pt_reg=arddRondKeys(pt_reg,key_reg)    
        #print("************************************************************************")            
        print("Encrypted:"+str(x_var)+": ",bin_list_to_hex(pt_reg).zfill(16))
        #print("************************************************************************")
        w_file.write(bin_list_to_hex(pt_reg).zfill(16)+"\n")
        
w_file.close()
            
            