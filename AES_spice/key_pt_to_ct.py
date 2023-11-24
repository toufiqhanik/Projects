# -*- coding: utf-8 -*-
"""
Created on Thu Aug 15 13:49:10 2019

@author: SECRECTS LAB - ANIK
"""

"""import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('key_pt_dpa1.txt')]
print(text_files)
filename='ct_key_pt_dpa1.txt'
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
            print(list1)
            for byte in range (0,32,2):  
                #print("byte :", byte)
               
                ct_str= list1[1][byte:byte+2]
                print(ct_str)
                fo.write(ct_str+"\n")
                
fo.close()"""
#import base64
#import pyaes
#key = bytes.fromhex('37d0d7').decode('utf-8')
#plaintext = bytes.fromhex('1820c11e35b95b77e4b94941aa953ba3').decode('utf-8')
#print("key: ", key)
#print("pt: ", plaintext)
"""
key = key.encode('utf-8')

aes = pyaes.AESModeOfOperationECB(key)    
ciphertext = aes.encrypt(plaintext)"""

from Crypto.Cipher import AES
import binascii
import os
key = binascii.unhexlify('37d0d724d00a1248db0fead349f1c09b')
print(key)
IV = os.urandom(16)
binascii.hexlify(IV).upper()
encryptor = AES.new(key, AES.MODE_ECB )
text = binascii.unhexlify('1820c11e35b95b77e4b94941aa953ba3')
ciphertext = encryptor.encrypt(text)
print(binascii.hexlify(ciphertext).upper())