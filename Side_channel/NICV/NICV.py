import numpy as np
from scipy import stats
from tqdm import trange
import matplotlib.pyplot as plt
from statistics import variance
import os, sys

textbytes_all=np.load('./AES_HOST_24_LFSR_seed_list_1000_repeat_10k_ct_all_9th_ct_xor_textbytes.npy')
D=400
start_point=1500

#%%

    
def nicv(campaign, textbytes):
    global var, cond_mean_without_zeros
    global interclass_var
    var = campaign.var(axis=0)
    nb_textbytes = np.zeros(256, dtype=int)
    cond_mean = np.zeros((256, D))
    
    for trace_index in trange(len(textbytes)):
        cond_mean[textbytes[trace_index]] += campaign[trace_index]
        nb_textbytes[textbytes[trace_index]] += 1
        
    interclass_var = np.zeros((256, D))
    # Calculate mean within each class
    for t in trange(256):
        if nb_textbytes[t] > 0:
            cond_mean[t] /= nb_textbytes[t]
            #print(cond_mean[t])

    #Removing zero rows
    # Find rows where sum equals zero
    rows_without_zeros = np.sum(cond_mean, axis=1) != 0

    # Remove rows with all zeros
    cond_mean_without_zeros = cond_mean[rows_without_zeros]

    # Calculate interclass variability
    interclass_var = cond_mean_without_zeros.var(axis=0)
    
    

    res = np.zeros(D)
    for sample in trange(D):
        if var[sample] != 0:
            res[sample] = interclass_var[sample] / var[sample]

    return res



#%%
traces_start=0
traces=traces_start+10000

#volts=['090', '100', '110', '120', '130', '140', '150']
volts=['150']
max_nicv=[]

for volt in range (len(volts)):    
    print("Volt: ", volts[volt])
    power_all=np.loadtxt('../../Power/HOST24_AES_%s_B_0_to_9_BS_1000_TC_10000.csv' % volts[volt], delimiter=",")
    # print("Volt: ", volts[volt])

    campaign = power_all[traces_start:traces, start_point:start_point+D]


    nicv_val =np.zeros(D)
    for byte in range (0, 16):
        textbytes = textbytes_all[traces_start:traces, byte]
        nicv_val = nicv(campaign, textbytes)

        fig=plt.figure(figsize=(18.5, 10.5), dpi=150, linewidth=1, edgecolor="#04253a")
        plt.plot(nicv_val, linewidth=4, color='blue')
        # plt.grid(True)
        plt.title('NICV Volt: %s | Byte%d | Max NICV: %s' %(volts[volt], byte, round(max(nicv_val),3)), size=28)          
        plt.rc('xtick', labelsize=22) 
        plt.rc('ytick', labelsize=22) 
        # plt.xticks( color='black', weight='bold')
        # plt.yticks( color='black', weight='bold')
        axes = plt.gca()       
        #axes.set_ylim([0,0.06])
        # axes.set_xlim([0,D-1])
        # axes.set_xticks(list(range(0,D)))
        # axes.set_xticklabels(list(range(start_point+5,start_point+D+5)))
        plt.xlabel('Time Samples', size=22, fontweight="bold")
        plt.ylabel('NICV', size=22, fontweight="bold")
        plt.savefig('./nicv_fig/AES_NICV_pt_sensor_volt_%sV_byte%d.png' %(volts[volt],byte), format="png", bbox_inches='tight', pad_inches=0, dpi=150)
        plt.close()
