import os
import numpy as np
path = '.'
files = [f for f in os.listdir(path) if f.endswith('.npy')]

for file in files:
    print(file)
    data=  np.load(file)
    np.savetxt(file[:-4]+'.csv', data, delimiter=",")