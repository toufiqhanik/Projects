# -*- coding: utf-8 -*-
"""
Created on Mon Aug 12 16:20:22 2019

@author: SECRECTS LAB - ANIK
"""

import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('.v')]
print(text_files)

appendfile=open("aes_hspice.sp",'a')

for f in range (len(text_files)):
    
    analogfile= text_files[f]
    
    with open (analogfile,'r') as outfile:
        linels=[]
        lines= outfile.readlines()
        
        #for x_var in range (0, len(lines)):
        for x_var in range (9648,9655):
        
            
            line1= str(lines[x_var])
            
            list1= line1.split()
            print(list1)
            
            try:               
#                if (list1[0]=="BUF_X1"):
#                    print(list1)
#                if (list1[0]=="INV_X1"):
#                    print(line1)
                #if (list1[0][length(list1[0])-3:length(list1[0])]=="2_X1"):
                #if(list1[0][length(list1[0])]=="x"):
                lolth=len(list1[0])
                #print(lolth)
                gate_type=list1[0][lolth-4:lolth]
                print(line1)
                if (gate_type== "2_X1"):
                    inp1 = list1[3][2:len(list1[3])-1].strip(" ")
                    inp1 =inp1.strip("()")                    
                    bkin11= inp1.find("[")
                    if(bkin11>-1):
                        bkin21 = inp1.find("]")
                        inp1= inp1[0:bkin11]+"_"+inp1[bkin11+1:bkin21]
                        print(inp1)
                    
                    
                    
                    inp2 = list1[4][2:len(list1[4])-1].strip(" ")
                    inp2 =inp2.strip("()")
                    bkin12= inp2.find("[")
                    if(bkin12>-1):
                        bkin22 = inp2.find("]")
                        inp2= inp2[0:bkin12]+"_"+inp2[bkin12+1:bkin22]
                        print(inp2)
                    
                    outp = list1[5][2:len(list1[5])-1].strip(" ")
                    if (list1[5][1:3]=="ZN"):
                        outp = list1[5][3:len(list1[5])-1].strip(" ")                        
                    outp =outp.strip("()")
                    bkout1= outp.find("[")
                    if(bkout1>-1):
                        bkout12 = inp2.find("]")
                        outp= outp[0:bkin12]+"_"+outp[bkin12+1:bkin22]
                        print(outp)
                    
                    
                    gatename= list1[1]                    
                    hpgate = "x"+gatename+" "+inp1+" "+inp2+" "+outp+" "+"VDD GND "+list1[0]+"\n"
                    print("x2:", hpgate)
                    #print(list1)
                    
                elif (gate_type[2:4]== "X1"):
                    inp1 = list1[3][2:len(list1[3])-1].strip(" ")
                    inp1 =inp1.strip("()")                    
                    bkin21= inp1.find("[")
                    if(bkin21>-1):
                        bkin22 = inp1.find("]")
                        inp1= inp1[0:bkin21]+"_"+inp1[bkin21+1:bkin22]
                        print(inp1)
                    
                    
                    outp = list1[4][2:len(list1[4])-1].strip(" ")
                    if (list1[4][1:3]=="ZN"):
                        outp = list1[4][3:len(list1[4])-1].strip(" ") 
                    outp =outp.strip("()")
                    bkout21= outp.find("[")
                    if(bkout21>-1):
                        bkout22 = outp.find("]")
                        outp= outp[0:bkin21]+"_"+outp[bkin21+1:bkin22]
                        print(outp)
                    gatename= list1[1]                    
                    hpgate = "x"+gatename+" "+inp1+" "+outp+" "+"VDD GND "+list1[0]+"\n"
                    print("x1:", hpgate)
#                if (list1[0]=="NOR2_X1"):
#                    print(line1)
#                if (list1[0]=="NAND2_X1"):
#                    print(line1)
#                if (list1[0]=="AND2_X1"):
#                    print(line1)                    
#                if (list1[0]=="DFF_X1"):
#                    print(line1)
#                if (list1[0]=="XOR2_X1"):
#                    print(line1)
                    
                    appendfile.write(hpgate)
            except:
                k=100


appendfile.close()
                
        #print("lines:", linels)