# -*- coding: utf-8 -*-
"""
Created on Tue Aug 13 11:32:32 2019

@author: SECRECTS LAB - ANIK

"""
import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('aes_comp.v')]  #Input file
print(text_files)

fout=open("aes_hspice.sp",'a') #outputfile

def sigconv(x):
    x= x.strip(" ")
    x= x.strip("()")    
    bkin11= x.find("[")
    if(bkin11>-1):
        bkin21 = x.find("]")
        inp1= x[0:bkin11]+"_"+x[bkin11+1:bkin21]
        #print(inp1)
    else:
        inp1= x
        
    return inp1



for f in range (len(text_files)):
    
    analogfile= text_files[f]
    
    with open (analogfile,'r') as outfile:
        linels=[]
        lines= outfile.readlines()
        
        for x_var in range (0, len(lines)-1):
        #for x_var in range (5094,5114):
        #for x_var in range (6740,6742):
        
            
            line1= str(lines[x_var])
            
            items1 = line1.split()
            print("items1: ", items1)
            #gate_type=items[0].strip()
            
            #len_items=len(items)
            first_item = items1[0].strip()
            last_item1=items1[len(items1)-1].strip()
            #print (last_item)
            line=""
            if (first_item.endswith("X1")):                
                if (last_item1.endswith(');')==0):    
                    #print("line1: ", line1)
                    line2= str(lines[x_var+1])                    
                    #print("line2: ", line2)   
                    line=line1.strip("\n")+line2.strip()
                    #print("line1+ line2 : ", line1.strip("\n")+line2.strip())
                    #print("line)
                    
                else:
                    line=line1             
                    
            
            
                print("line", line)
                items = line.split()
                print("line items", items)
                print("\n")
                
                gate_type=items[0].strip()
                gate_name=sigconv(items[1].strip())
                
                if gate_type.endswith('DFF_X1'):
                    inD=items[3].strip()
                    inD_rm=inD[3:len(inD)-1]
                    inD_rm=sigconv(inD_rm)
        
                    inC=items[4].strip()
                    inC_rm=inC[4:len(inC)-1]
                    inC_rm=sigconv(inC_rm)
                    
                    inQ=items[5].strip()
                    inQ_rm= inQ[3:len(inQ)-1]
                    inQ_rm= sigconv(inQ_rm)
                    
                    
                    if (len(items)==8):
                        inQN=items[6].strip()
                        inQN_rm= inQN[4:len(inQN)-1]
                        inQN_rm= sigconv(inQN_rm)
                        
                    elif (len(items)==7):
                        inQN_rm="dummy"
                    else:
                        inQN_rm="dummy"
                        
                   
                    fout.write("x%s %s %s %s %s VDD GND %s\n" % (gate_name,inD_rm,inC_rm,inQ_rm,inQN_rm,gate_type))
                    print("x%s %s %s %s %s VDD GND %s\n" % (gate_name,inD_rm,inC_rm,inQ_rm,inQN_rm,gate_type))
                
                elif gate_type.endswith('XOR2_X1'):
                    in1=items[3].strip()
                    in1_rm=in1[3:len(in1)-1]
                    in1_rm=sigconv(in1_rm)
        
                    in2=items[4].strip()
                    in2_rm=in2[3:len(in2)-1]
                    in2_rm=sigconv(in2_rm)
                    
                    out1=items[5].strip()
                    out1_rm=out1[3:len(out1)-1]                         
                    out1_rm=sigconv(out1_rm)
                    
                    fout.write("x%s %s %s %s VDD GND %s\n" % (gate_name,in1_rm,in2_rm,out1_rm,gate_type))
                    print("x%s %s %s %s VDD GND %s\n" % (gate_name,in1_rm,in2_rm,out1_rm,gate_type))
                
                elif gate_type.endswith('AND2_X1') or gate_type.endswith('OR2_X1'):
                    in1=items[3].strip()
                    in1_rm=in1[4:len(in1)-1]
                    in1_rm=sigconv(in1_rm)
        
                    in2=items[4].strip()
                    in2_rm=in2[4:len(in2)-1]
                    in2_rm=sigconv(in2_rm)
                    
                    out1=items[5].strip()
                    out1_rm=out1[4:len(out1)-1]                         
                    out1_rm=sigconv(out1_rm)
                    
                    fout.write("x%s %s %s %s VDD GND %s\n" % (gate_name,in1_rm,in2_rm,out1_rm,gate_type))
                    print("x%s %s %s %s VDD GND %s\n" % (gate_name,in1_rm,in2_rm,out1_rm,gate_type))
                    
                
                elif gate_type.endswith('INV_X1') or gate_type.endswith('BUF_X1'):
                    in1=items[3].strip()
                    in1_rm=in1[3:len(in1)-1]
                    in1_rm=sigconv(in1_rm)
        
                                        
                    out1=items[4].strip()
                    if gate_type.startswith('B'):
                        out1_rm=out1[3:len(out1)-1]                        
                    else:
                        out1_rm=out1[4:len(out1)-1]                         
                    out1_rm=sigconv(out1_rm)
                    fout.write("x%s %s %s VDD GND %s\n" % (gate_name,in1_rm,out1_rm,gate_type)) 
                    print("x%s %s %s VDD GND %s\n" % (gate_name,in1_rm,out1_rm,gate_type))  
                else:
                    fout.write("ERROR******************************************\n")
                    print("ERROR******************************************")
                
fout.close()
            
