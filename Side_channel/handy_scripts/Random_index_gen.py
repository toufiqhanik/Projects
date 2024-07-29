# -*- coding: utf-8 -*-
"""
Created on Fri May 31 17:22:43 2024

@author: anik9
"""

import random

# Generate 10000 unique integers from 0 to 9999
random.seed(0)
unique_integers = random.sample(range(10000), 10000)

print(unique_integers[-10:-1])

random.seed(1)
unique_integers = random.sample(range(10000), 10000)

print(unique_integers[-10:-1])

random.seed(2)
unique_integers = random.sample(range(10000), 10000)



random.seed(3)
unique_integers = random.sample(range(100), 100)
print(unique_integers)

HD_index = [i for i in range(0, 100*16, 16)]
print(HD_index)

shuffled_HD_index = []

for i in range (0, len(unique_integers)):
    shuffled_HD_index.append(HD_index[unique_integers[i]])

print(shuffled_HD_index)