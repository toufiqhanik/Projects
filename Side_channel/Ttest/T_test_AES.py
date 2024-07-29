# -*- coding: utf-8 -*-
"""
Created on Tue Apr 30 15:08:47 2024

@author: anik9
"""

import numpy as np
from scipy import stats
from tqdm import trange
import matplotlib.pyplot as plt
from statistics import variance
import os, sys


debug_on =1#int(sys.argv[3])
volt="160"
plots_on = 1

final = 10000
steps=10000

bit=0
#%%
HD = np.loadtxt('./AES_HOST_24_LFSR_seed_list_1000_repeat_10k_ct_all_HD_bit%d.csv' %bit, delimiter=",")
#print("Model Loaded.....")
#%%
power = np.loadtxt('../../Power/HOST24_AES_%s_B_0_to_9_BS_1000_TC_10000.csv' %volt, delimiter=",")

#%%
#np.save("../Power/AES_HOST_24_LFSR_seed_list_1000_repeat_10k_ct_all_HD.npy", HD )
#HD =np.load("../Power/AES_HOST_24_LFSR_seed_list_1000_repeat_10k_ct_all_HD.npy")
#%%
#np.save("../Power/HOST24_AES_%s_B_0_to_9_BS_1000_TC_10000.npy" %volt, power )
#power = np.load("../Power/HOST24_AES_%s_B_0_to_9_BS_1000_TC_10000.npy" %volt)
print("Power Loaded.....")
#%%
key_list=[44,18,44,62,215,249,69,103,35,186,126,14,169,235,80,204]
start_point=1600
D=300

for nibble in range(0,16):
    key = key_list[nibble]
    
    power_model = np.zeros((len(power), 256))
    HD_index = [i for i in range(nibble, len(power)*16, 16)]
    
    for i in range(0, len(HD_index)):
        # print(HD_index[i])
        for col in range(0, 256):
            power_model[i, col] = HD[HD_index[i], col]
            
    Ttest=np.zeros((256, D))
    for k in trange(0, 256):
        HV = power_model[:,k]
        index0=np.where(HV==0)
        index1=np.where(HV==1)
        
        traces0=power[index0,start_point:start_point+D]
        traces1=power[index1,start_point:start_point+D]
        m0=np.mean(traces0,axis=1)
        m1=np.mean(traces1,axis=1)
        ttst = m0-m1
        
        n0=traces0.shape[1]
        n1=traces1.shape[1]
        
        var0=np.var(traces0, axis=1)
        var1=np.var(traces1, axis=1)
        
        den = np.sqrt(var0/n0 + var1/n1)
        #den[ np.where(den==0)] = 1.
        
        Ttest[k,:] = ttst/ den
    
    Ttest_T=Ttest.T
    line1=5*np.ones(D)
    line2=-5*np.ones(D)
    if(plots_on==1):
        fig=plt.figure(figsize=(18.5, 10.5), dpi=150, linewidth=1, edgecolor="#04253a")
        plt.plot(Ttest_T, linewidth=2, color='royalblue')
        plt.plot(Ttest_T[:,key], linewidth=4, color='red')
        plt.plot(line1, linewidth=2, color='black')
        plt.plot(line2, linewidth=2, color='black')
        # plt.grid(True)
        plt.title('Byte:%d  |  Bit:%d  |  Max T-Test: %s' %(nibble, bit, round(np.max(Ttest_T),2)), size=28)          
        plt.rc('xtick', labelsize=22) 
        plt.rc('ytick', labelsize=22) 
        plt.xticks( color='black', weight='bold')
        plt.yticks( color='black', weight='bold')
        axes = plt.gca()       
        axes.set_ylim([-6,6])
        axes.set_xlim([0,D])
        # axes.set_xticks(list(range(0,len(success_rate)+1,10)))
        # axes.set_xticklabels(list(range(0,len(success_rate)+1,10)))
        plt.xlabel('Sample Points', size=22, fontweight="bold")
        plt.ylabel('T-Test', size=22, fontweight="bold")
        plt.savefig('results/AES_sensor_ttest_N%d_bit%d_q%s_v%s.png'%(nibble,bit,final,volt), format="png", bbox_inches='tight', pad_inches=0, dpi=150)
        
        np.savetxt('results/AES_sensor_ttest_N%d_bit%d_q%s_v%s.csv'%(nibble,bit,final,volt), Ttest_T, delimiter=',')
        plt.close()
        
        