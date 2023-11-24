
"""Written By:  Md Toufiq hasan Anik

CSEE, UMBC JV38613
Email: toufiqhanik@umbc.edu
Date: 2:27:2019 (6:25am)
update: 3.21.19 4.15am #voltage file update"""




import os

def makemydir(new):
  try:
    os.makedirs(new)
  except OSError:
    pass
  

makemydir("voltage_plots_per")

path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('npa_clockhm_re_ver1_v1.0_1.4_t_0_40_data_alarm.txt')]
print(text_files)

basefile= open ("hm_base_v1_1.4_t0_40_clockhm_data_alarm.txt", 'r')
baselines= basefile.readlines()

for volt in range (100,141,4):
    mainvoltage=str(volt/100)

    for f in range (len(text_files)):

        miss_alarm= [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

        false_alarm= [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        
        datafile= text_files[f]
        #alarmfile=datafile[0:len(datafile)-9]+"mf_alarm.txt"
        #appendFile= open(alarmfile,'a')

        outfile= open (datafile,'r')
        lines= outfile.readlines()
        
        #miss_alarmfile=datafile[0:len(datafile)-4]+"miss_alarm.txt"
        #false_alarmfile=datafile[0:len(datafile)-4]+"false_alarm.txt"

        
        for ln in range(len(baselines)):
            bline1= str(baselines[ln])
            blist0= bline1.split()
            blist1=blist0

            voltage= blist1[0]
            temperature= blist1[1]
            balarm= blist1[3]

            if (voltage == mainvoltage):

                for month in range (2,85,2):
                    mindex=int(month/2-1)         
                    

                    for dln in range(len(lines)):
                             
                        line1= str(lines[dln])                        
                        list0= line1.split()
                        list1=list0

                        if(list1[0]==voltage):
                            if(list1[1]==temperature):                        
                                if(list1[2]==str(month)):                   
                                                
                                    if (balarm=="1"):
                                        if (list1[4]=="0"):                        
                                            miss_alarm[mindex]=miss_alarm[mindex]+1

                                    if (balarm=="0"):
                                        if (list1[4]=="1"):                                                
                                            false_alarm[mindex]=false_alarm[mindex]+1

                        """clocknumber=float(list1[2])

                if(uprange>=clocknumber>=lowrange):
                     list1.append("0")
                else:
                    list1.append("1")

                linestring= list1[0]+" "+list1[1]+" "+list1[2]+" "+list1[3]+"\n

                    
                
                x_var=x_var+1
            linestring= list1[0]+" "+list1[1]+" "+str(miss_alarm)+" "+str(false_alarm)+"\n"
            appendFile.write(linestring)
                    
        appendFile.close()"""

        miss_alarm_per= [round((x/121)*100,2) for x in miss_alarm]
        false_alarm_per = [round((y/121)*100,2) for y in false_alarm]

        miss_alarm=miss_alarm_per
        false_alarm=false_alarm_per

        print("miss_alarm: ", miss_alarm)
        print("\n")
        print("false_alarm: ", false_alarm)

        plotdatafile="./voltage_plots_per/V_"+str(mainvoltage)+"_miss_false_st.dat"

        file=open(plotdatafile,"a")

        xtics= ""
        for n in range (len(miss_alarm)):
            file.write(str(4*n+2-0.5)+" "+str(miss_alarm[n])+"\n")
            file.write(str(4*n+2+0.5)+" "+str(false_alarm[n])+"\n\n")
            xtics=xtics+'"'+str(2*n+2)+'" '+str(4*n+2)+", "

        
    file.close()
print(xtics)
            
