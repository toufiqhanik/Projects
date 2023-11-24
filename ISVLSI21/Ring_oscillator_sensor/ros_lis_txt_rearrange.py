# -*- coding: utf-8 -*-
"""
Created on Thu Jun  6 15:13:29 2019

@author: SECRECTS LAB - ANIK
"""

import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('.txt')]
print(text_files)

for f in range (len(text_files)):
    analogfile= text_files[f]
    print(analogfile)
    
    filename=analogfile[:len(analogfile)-3]+"_re.txt"
    
    with open (analogfile,'r') as outfile:
        lines= outfile.readlines()
        
        for temp in range (0,91):            
            for ln in range (0, len(lines)):            
                line1= str(lines[ln])            
                list1= line1.split()
                
                if (list1[0]== str(temp)):
                    appendFile= open(filename,'a')
                    appendFile.write(line1)
                    appendFile.close()

print("Done...")
            
            
            