# -*- coding: utf-8 -*-
"""
Created on Thu Aug 15 13:49:10 2019
update: 9.20.19 9.55
@author: SECRECTS LAB - ANIK
"""
from Crypto.Cipher import AES
import binascii


import random

key_str='37d0d724d00a1248db0fead349f1c09b'

filename='key_pt_ct_random.txt'
fo=open(filename,"a")

x_var=0;

while (x_var<100000):

    hash = random.getrandbits(128)
    pt=str(hex(hash))[2:]
    
    if (len(pt)==32):    
        #print(pt)
        #print(list1)
        key = binascii.unhexlify(key_str)
        #print(key)
        encryptor = AES.new(key, AES.MODE_ECB)
        text = binascii.unhexlify(pt)
        ciphertext = encryptor.encrypt(text)
        pct=binascii.hexlify(ciphertext).lower()          
        pct2=str(pct)[2:len(pct)+2]
        print(pt+'  :  '+ pct2)            
        ctstr= key_str+" "+pt+" "+pct2+"\n"
        fo.write(ctstr)
        x_var=x_var+1

fo.close()