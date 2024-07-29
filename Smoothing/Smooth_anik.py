# -*- coding: utf-8 -*-
"""
Created on Sun Aug 15 00:54:14 2021

@author: Md Toufiq Hasan Anik
"""

import os
from scipy.interpolate import splrep, splev
import numpy as np
path = '.'
files = [f for f in os.listdir(path) if f.endswith('.csv')]


for file in files:
    
    values=[]
    lines=open(file,'r').readlines()
    for line in lines:
        value=float(line.split(',')[0])
        values.append(value)
     
    x = np.array([0.]*len(lines))
    for k in range(len(lines)):
        x[k] = k
        
    smooth = splrep(x,values,s=1000)
    smoothen = splev(x,smooth)
    print("values: ", values)
    print("smoothen: ", smoothen)
    
    print("file: ", file)
    smoothen_file=file[:-4]+"_smoothen.csv"
    print("smoothen_file: ", smoothen_file)
    
    fout=open(smoothen_file,'w')
    
    write_string=""
    for x in smoothen:
        write_string=write_string+str(x)+",\n"
        
    fout.write(write_string)
    fout.close()