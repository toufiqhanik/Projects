# -*- coding: utf-8 -*-
"""
Created on Wed Jul 24 15:49:59 2019

@author: SECRECTS LAB - ANIK
"""

import serial
ser = serial.Serial(port = "COM8", baudrate=9600, timeout=2, write_timeout=2, bytesize=8,  stopbits=serial.STOPBITS_ONE)

print("ser", ser)
#ser.send_break(duration=1)
#ser.open()
print("serial status", ser.is_open)
appendFile= open("fpgaoutput_aes_ct8.txt",'a')
chin=""
import time

#ser.write('X'.encode('utf-8'))
#time.sleep(4)

with open ("key_pt_dpa1_ctext.txt",'r') as outfile:
        lines= outfile.readlines()
        for ln in range (0, 1): 
            line1= str(lines[ln])
            list1= line1.split()

            for c in range (0, 32):
                    time.sleep(1.1)                 
                    chrc=list1[1][c].encode('utf-8')
                    #chrc='7'.encode('utf-8')
                    print(str(chrc)+"  Count:", c)
                    ser.write(chrc)
                
          
            #time.sleep(5)
            chin=""
            for cin in range (0, 32):
                chin_temp=ser.read(1).decode('utf-8')
                chin=chin+chin_temp
            
            print(chin)
            appendFile.write(chin)
            appendFile.write("\n")
                
            print("Finishe AES:", ln)
            #ser.write('X'.encode('utf-8'))
            #time.sleep(5)
            
            
            
    
appendFile.close()
        

ser.close()
