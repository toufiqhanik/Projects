"""Written By:  Md Toufiq hasan Anik

CSEE, UMBC JV38613
Email: toufiqhanik@umbc.edu
Date: 3.15.19 (8.35 am)

update: 3.19.19 2.17pm  #alarm added and updated alarm for dual change


checks clock change and if it is changing 2 times"""




import os
path = '.'
text_files = [f for f in os.listdir(path) if f.endswith('data_digital.txt')]
print(text_files)

#alarm 
tolerance= 5
uprange=18+tolerance
lowrange=18-tolerance

#file
report_filename="report_pna_heat_map_data_len.txt"
dcng_file="double_change.txt"

double_change=0

def findclk(clkstr):
    global double_change
    fp0=clkstr[0]
    fp_flag="0"
    fpnew=""
    nochange_flag="0"
    for fp in range (1,33):   
        
               

        fpnow=clkstr[fp]

        if (nochange_flag=="0"):
            if (fp0 == fpnow):
                if (fp == 32):
                    double_change=1                   
                    
                    change_fp_number.append(int(33))

                    appendReportFile= open(report_filename,'a')
                    appendReportFile.write(str(voltage))
                    appendReportFile.write(' ')
                    appendReportFile.write(str(temperature))
                    #appendReportFile.write(' ')
                    #appendReportFile.write(str(month))
                    appendReportFile.write(' ')
                    appendReportFile.write("clk:"+str(m))
                    appendReportFile.write(' ')
                    appendReportFile.write("flipflop:"+str(fp)+"no change all way")
                    appendReportFile.write('\n')
                
            

        if (fp_flag == "0"):
            if (fp0 != fpnow):
                fpcng=fp
                
                fpnew=fpnow
                fp_flag="1"
                nochange_flag="1"
                change_fp_number.append(fpcng+1)

        if (fp_flag == "1"):
            if ( fpnew != fpnow):
                fpcng=fp
                fpnew=fpnow
                nochange_flag="1"
                double_change=1
                        
                appendReportFile= open(report_filename,'a')
                appendReportFile.write(str(voltage))
                appendReportFile.write(' ')
                appendReportFile.write(str(temperature))
                #appendReportFile.write(' ')
                #appendReportFile.write(str(month))
                appendReportFile.write(' ')
                appendReportFile.write("clk:"+str(m))
                appendReportFile.write(' ')
                appendReportFile.write("flipflop:"+str(fp))
                appendReportFile.write('\n')



for f in range (len(text_files)):

    change_fp_number=[]

    
    analogfile= text_files[f]
    for v in range (0, 20):
        if (analogfile[v]=="_"):
            if(analogfile[v+1]=="t"):
                vln=v

        if (analogfile[v]=="_"):
            if(analogfile[v+1]=="v"):
                vstart=v+2
                
    
                
    voltage=float(analogfile[vstart:vln])
    print("V:", voltage)
    
    for t in range (4, 20):
        if (analogfile[t]=="_"):
            if(analogfile[t+1]=="d"):
                if(analogfile[t+2]=="a"):
                    tmp=t
    
    
    temperature=int(analogfile[(vln+2):tmp])
    print("t:", temperature)

    """for t in range (15, 37):
        if (analogfile[t]=="_"):
            if(analogfile[t+1]=="d"):
                if(analogfile[t+2]=="a"):
            
                    mnt=t

    month=int(analogfile[(tmp+12):mnt])
    print("Month:", month)"""


    
    
    filename="pna_clockhm_data_alarm.txt"
    
    with open (analogfile,'r') as outfile:
        
        lines= outfile.readlines()
        

        line0= str(lines[0])
        list0= line0.split()
        

        for m in range (3,len(list0)):
            clkstr=""
            x_var=0

            while (x_var<len(lines)):
                
                line1= str(lines[x_var])
                
                list1= line1.split()
                
                v_str= list1[m]
                clkstr=clkstr+v_str
                x_var=x_var+1

            print("clkstr for clock: "+str(m),clkstr)
            findclk(clkstr)
            print("change_fp_number: ", change_fp_number)
            print("change_fp_number len : ", len(change_fp_number))
            #print("change_fp_number len : ", np.mean(change_fp_number))

            
                    

       
    print("change_fp_number: ", change_fp_number)
    print("change_fp_number len : ", len(change_fp_number))
    appendFile= open(filename,'a')
    appendFile.write(str(voltage))
    appendFile.write(' ')
    appendFile.write(str(temperature))
    appendFile.write(' ')
    #appendFile.write(str(month))
    #appendFile.write(' ')
    clocknumber =sum(change_fp_number)/49 #finding clock number
    
                
    appendFile.write(str(clocknumber))

    if(uprange>=clocknumber>=lowrange):
        if (double_change==1):
            appendFile.write(" 1")
        else:
            appendFile.write(" 0")           
        
    else:
        appendFile.write(" 1")
                
    appendFile.write('\n')
    
    dappendFile= open(dcng_file,'a')
    
    """if (double_change==1):
        #dappendFile= open(dcng_file,'a')
        dappendFile.write(str(voltage))
        dappendFile.write(' ')
        dappendFile.write(str(temperature))
        #dappendFile.write(' ')
        #dappendFile.write(str(month))
        #dappendFile.write(' ')
        #dappendFile.write(str(sum(change_fp_number)/49))
        dappendFile.write('\n')"""
        


appendFile.close()
dappendFile.close()
print("*******Done********")



