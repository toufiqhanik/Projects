'''
Python code for Obfuscation Verilog Test Brench

Random with %, Xor/xnor before signal.
+Last Update: 1.16.19
SARLock

Code Written by:
Md. Toufiq Hasan Anik
CSEE, UMBC, MD.

Date: 12.04.18'''

#Calling the main function (verilog_obfuscation())


import random

#Reading module'''
def module(x):
    global module_name
    global module_nodes
    module_name = x[1]
    modlue_nodes= x[2].strip('(')
    modlue_nodes= modlue_nodes.strip(')')
    module_nodes= modlue_nodes.split(",")
    print("Main Module Name : ", module_name)
    print("Main Module node list :", module_nodes)


#Reading gate with two input'''
def gate2X1(x):
    global device_list 
    gate_type_name = x[0] 
    gate_name= x[1]
    gate_nodes= x[2].strip('(.Y(')
    gate_nodes= gate_nodes.strip('))')
    gate_nodes= gate_nodes.split(",")
    output_node =gate_nodes[0].strip(')')

    input_node =gate_nodes[1].strip('.A(')
    input_node =input_node.strip(')')
    input_node2 =gate_nodes[2].strip('.B(')

    global gate_out  #output name of the 
    gate_out[gate_name]=output_node



    global gate_in #inputs of the gate
    gate_in[gate_name]=[input_node,input_node2]

    global gate_type #type of the gate
    gate_type[gate_name]=gate_type_name

    global sig_to_in #Sign in as input to how many gates (fanin)

    sig_to_in.setdefault(input_node,[]).append(gate_name)
    sig_to_in.setdefault(input_node2,[]).append(gate_name)



    global sig_to_out #Sign to output gate name
    sig_to_out[output_node]=gate_name
    #sig_to_out.setdefault(output_node,[]).append(gate_name)
    device_list.append(gate_name)




def gate(x):
    global device_list
    gate_type_name = x[0]
    gate_name= x[1]
    gate_nodes= x[2].strip('(.Y(')
    gate_nodes= gate_nodes.strip('))')
    gate_nodes= gate_nodes.split(",")
    output_node =gate_nodes[0].strip(')')
    

    input_node =gate_nodes[1].strip('.A(')
    #print("node check: ",input_node )
    #input_node =input_node.strip(')')

    global gate_out
    gate_out[gate_name]= output_node


    global sig_to_out
    sig_to_out[output_node]=gate_name


    input_node_in =[input_node]

    global gate_in
    gate_in[gate_name]=input_node_in

    global sig_to_in

    sig_to_in.setdefault(input_node,[]).append(gate_name)

    global gate_type
    gate_type[gate_name]=gate_type_name
    device_list.append(gate_name)


def input_list(x):
    global input_node
    global pi_node_number
    input_node=x.split(',')
    pi_node_number=len(input_node)

    #print("input list: ",input_node)


def output_list(x):
    global output_node
    output_node=x.split(',')
    #print("output list: ", output_node)


def wire_list(x): 
    global wire_node
    wire_node=x.split(',')
    #print("wire list: ", wire_node)


def xor_add_sig_in(x,y):
    global gatenumber
    global gate_out
    global gate_in
    global gate_type
    global sig_to_in
    global sig_to_out
    global module_nodes
    global device_list



    global new_node
    new_node= "keyinput"+str(gatenumber)
    global input_node
    
    input_node.append(new_node)
    module_nodes.append(new_node)
    #print("New module nodes: ", module_nodes)
    #print("New Input list : ", input_node)
    gate_name=y+"2_"+ x
    new_temp_node= x + "enc"
    device_list.append(gate_name)
    wire_node.append(new_temp_node)    


    sig_to_out[new_temp_node]=gate_name
    #print("New Gate signal to out Dictonary: ", sig_to_out)

    gate_out[gate_name]= new_temp_node
    #print("New Gate Out Dictonary: ", gate_out)   

    
    gate_type[gate_name]=y+"2X1"
    #print("New Gate Type Dictonary: ",gate_type)     
    
            

    x_gates= sig_to_in.get(x)
    g_len=len(x_gates)
    #print("check x_gates: ", x_gates)
   
                    
    for k in range(g_len):
        k_sigs= gate_in.get(x_gates[k])
        #print ("k_sigs:", k_sigs)
        for k_in in range (len(k_sigs)):               
                                   
            if k_sigs[k_in]== x:
                k_sigs.remove(x)
                k_sigs.insert(k_in, new_temp_node)
                #print ("k_sigs:check: ", k_sigs)     
                
              
            gate_in[x_gates[k]]=k_sigs
    
    gate_in[gate_name]=[x, new_node]


    gate_name_list=[gate_name]
    sig_to_in[x]=gate_name_list
    sig_to_in[new_node]=gate_name_list
    #print("New Gate signal to in Dictonary: ", sig_to_in)

    
            
    #print(x, "New Signal input to gates: ", x_gates)

    #print("New Gate in Dictonary: ", gate_in)

    

    
def xor_add_sig_out(x,y):
    global gatenumber
    global gate_out
    global gate_type
    global gate_in
    global sig_to_in
    global sig_to_out
    global module_nodes
    global device_list
    



    global new_node
    new_node= "keyinput"+str(gatenumber)
    global input_node
    
    input_node.append(new_node)
    module_nodes.append(new_node)
    #print("New module nodes: ", module_nodes)
    #print("New Input list : ", input_node)
    gate_name=y+"2_"+ x
    new_temp_node= x +"enc"
    device_list.append(gate_name)
    wire_node.append(new_temp_node)

    y_gate= sig_to_out.get(x)
    
    gate_out[y_gate]= new_temp_node
    gate_out[gate_name]= x

    gate_in[gate_name]=[new_temp_node,new_node]
    
    #print("New Gate Out Dictonary: ", gate_out)
    #print(x, "New Signal output to gates: ", gate_name)
    #print("New Gate in Dictonary: ", gate_in)


    sig_to_out[x]=gate_name
    sig_to_out[new_node]='Output to modeul'
    
    #print("New Gate signal to out Dictonary: ", sig_to_out)

    
    gate_type[gate_name]=y+"2X1"
    #print("New Gate Type Dictonary: ",gate_type)        
    
    gate_name_list=[gate_name]
   
    sig_to_in[new_temp_node]=gate_name_list
    sig_to_in[new_node]=gate_name_list

    #print("New Gate signal to in Dictonary: ", sig_to_in)

    

def check_signal(x,y):
    global gatenumber
    global sig_to_in
    global sig_to_out
    global xor_signal
    global already_key_flag

    
    

    sig_have = sig_to_in.get(x,"none")
    sig_have2= sig_to_out.get(x,"none")

    x_len= len(xor_signal)
    xor_flag=0

    for xl in range (x_len):
        if xor_signal[xl] == x:
            xor_flag=1
            print("You already included this signal, Please use other signal")
            already_key_flag = 1
        
 
    if xor_flag==0:
        
        if sig_have == "none":
            
            if sig_have2 != "none":
                xor_add_sig_out(x,y)
                xor_signal.append(x)
                print("Signal added for Obfuscation Successfully") 
                    
            else:
                print("No signal exist with this name, Please input correctly. ")
        else:
            xor_add_sig_in(x,y)
            xor_signal.append(x)
            print("Signal added for Obsfucation Successfully")
                      
        
def random_key_gates_input(x):
    global gatenumber
    global gate_count
    global node_list
    global already_key_flag

    number_of_key_gates = round ((x/100)* gate_count)

    node_list_len= len(node_list)
    gaternd_list=["XOR", "XNOR"]

    for m in range(0,number_of_key_gates):
        y= random.randint(0,node_list_len-1)
        k= random.randint(0,len(gaternd_list)-1)
        rnd_signal=node_list[y]
        gaternd_type= gaternd_list[k]
        print("Signal to add Xor/Xnor after: ", rnd_signal)
        check_signal(rnd_signal,gaternd_type)
        gatenumber=gatenumber+1
        if (already_key_flag==1):
            m=m-1
            gatenumber=gatenumber-1
            already_key_flag=0


def sarlock_xorgate_mask():
    global pi_node_number
    global gatenumber
    global gate_out
    global gate_in
    global gate_type
    global sig_to_in
    global sig_to_out
    global module_nodes
    global device_list

    global new_node
    global input_node



    for m in range(gatenumber):
        
        new_node= "keyinput"+str(m)
        new_node2="keyinput"+str(gatenumber+m)
        
        
        input_node.append(new_node2)
        module_nodes.append(new_node2)
        #print("New module nodes: ", module_nodes)
        #print("New Input list : ", input_node)
        gate_name="xorgate_"+ str(m)#identical gatename
        new_temp_node= "xorgate"+ str(m) #output node
        device_list.append(gate_name)
        wire_node.append(new_temp_node)    


        sig_to_out[new_temp_node]=gate_name #update output library
        #print("New Gate signal to out Dictonary: ", sig_to_out)

        gate_out[gate_name]= new_temp_node
        #print("New Gate Out Dictonary: ", gate_out)   

        
        gate_type[gate_name]="XOR"+"2X1"
        #print("New Gate Type Dictonary: ",gate_type)     

        
        gate_in[gate_name]=[new_node,new_node2]


        gate_name_list=[gate_name]
        sig_to_in[new_node]=gate_name_list
        sig_to_in[new_node2]=gate_name_list


def sarlock_comparator():
    global pi_node_number
    global gatenumber
    global gate_out
    global gate_in
    global gate_type
    global sig_to_in
    global sig_to_out
    global module_nodes
    global device_list

    global new_node
    global input_node



    for m in range(pi_node_number):

        if (m<gatenumber):
            new_node= "xorgate"+str(m)
        else:
            new_node= "keyinput"+str(gatenumber+m)
            input_node.append(new_node)
            module_nodes.append(new_node)
        
        new_node2=input_node[m]
        
        
        #input_node.append(new_node2)
        #module_nodes.append(new_node)
        #print("New module nodes: ", module_nodes)
        #print("New Input list : ", input_node)
        gate_name="compare_"+ str(m) #identical gatename
        new_temp_node= "compare"+ str(m) #output node
        device_list.append(gate_name)
        wire_node.append(new_temp_node)    


        sig_to_out[new_temp_node]=gate_name #update output library
        #print("New Gate signal to out Dictonary: ", sig_to_out)

        gate_out[gate_name]= new_temp_node
        #print("New Gate Out Dictonary: ", gate_out)   

        
        gate_type[gate_name]="XNOR"+"2X1"
        #print("New Gate Type Dictonary: ",gate_type)     

        
        gate_in[gate_name]=[new_node,new_node2]


        gate_name_list=[gate_name]
        sig_to_in[new_node]=gate_name_list
        sig_to_in[new_node2]=gate_name_list


def sarlock_andgate():
    global pi_node_number
    global gatenumber
    global gate_out
    global gate_in
    global gate_type
    global sig_to_in
    global sig_to_out
    global module_nodes
    global device_list

    global new_node
    global input_node
    compare_number=0
    cmp_sig=0



    for m in range(pi_node_number-1):
        

        if (m<=pi_node_number/2):
            new_node= "compare"+str(compare_number)
            new_node2= "compare"+str(compare_number+1)
            if(compare_number+1>=pi_node_number-1):
                new_node2= "andgate"+str(0)
                cmp_sig=1
            compare_number=compare_number+2
        else:
            if(cmp_sig==0):
                compare_number=0
            elif(cmp_sig==1):
                compare_number=1
                cmp_sig=0
            #new_node= "keyinput"+str(gatenumber+gatenumber+m+1)
            new_node= "andgate"+str(compare_number)
            new_node2= "andgate"+str(compare_number+1)
            compare_number=compare_number+2
            #input_node.append(new_node)
            #module_nodes.append(new_node)
        
        #new_node2=input_node[m]
        
        
        #input_node.append(new_node2)
        #module_nodes.append(new_node)
        #print("New module nodes: ", module_nodes)
        #print("New Input list : ", input_node)
        gate_name="andgate_"+ str(m) #identical gatename
        new_temp_node= "andgate"+ str(m) #output node
        device_list.append(gate_name)
        wire_node.append(new_temp_node)    


        sig_to_out[new_temp_node]=gate_name #update output library
        #print("New Gate signal to out Dictonary: ", sig_to_out)

        gate_out[gate_name]= new_temp_node
        #print("New Gate Out Dictonary: ", gate_out)   

        
        gate_type[gate_name]="AND"+"2X1"
        #print("New Gate Type Dictonary: ",gate_type)     

        
        gate_in[gate_name]=[new_node,new_node2]


        gate_name_list=[gate_name]
        sig_to_in[new_node]=gate_name_list
        sig_to_in[new_node2]=gate_name_list



def sarlock_orgate():
    global pi_node_number
    global gatenumber
    global gate_out
    global gate_in
    global gate_type
    global sig_to_in
    global sig_to_out
    global module_nodes
    global device_list

    global new_node
    global input_node
    compare_number=gatenumber
    cmp_sig=0



    for m in range(pi_node_number-1):
        

        if (m<=pi_node_number/2):
            new_node= "keyinput"+str(compare_number)
            new_node2= "keyinput"+str(compare_number+1)
            if(compare_number+1>=gatenumber+pi_node_number-1):
                new_node2= "orgate"+str(0)
                cmp_sig=1
            compare_number=compare_number+2
        else:
            if(cmp_sig==0):
                compare_number=0
            elif(cmp_sig==1):
                compare_number=1
                cmp_sig=0
            #new_node= "keyinput"+str(gatenumber+gatenumber+m+1)
            new_node= "orgate"+str(compare_number)
            new_node2= "orgate"+str(compare_number+1)
            compare_number=compare_number+2
            #input_node.append(new_node)
            #module_nodes.append(new_node)
        
        #new_node2=input_node[m]
        
        
        #input_node.append(new_node2)
        #module_nodes.append(new_node)
        #print("New module nodes: ", module_nodes)
        #print("New Input list : ", input_node)
        gate_name="orgate_"+ str(m) #identical gatename
        new_temp_node= "orgate"+ str(m) #output node
        device_list.append(gate_name)
        wire_node.append(new_temp_node)    


        sig_to_out[new_temp_node]=gate_name #update output library
        #print("New Gate signal to out Dictonary: ", sig_to_out)

        gate_out[gate_name]= new_temp_node
        #print("New Gate Out Dictonary: ", gate_out)   

        
        gate_type[gate_name]="OR"+"2X1"
        #print("New Gate Type Dictonary: ",gate_type)     

        
        gate_in[gate_name]=[new_node,new_node2]


        gate_name_list=[gate_name]
        sig_to_in[new_node]=gate_name_list
        sig_to_in[new_node2]=gate_name_list  




def sarlock_po():
    global pi_node_number
    global gatenumber
    global gate_out
    global gate_in
    global gate_type
    global sig_to_in
    global sig_to_out
    global module_nodes
    global device_list
    global output_node

    global new_node
    global input_node

    
    sar_output_node=output_node
    

    new_node= "orgate"+str(pi_node_number-2)
    new_node2="andgate"+str(pi_node_number-2)
        
        
    #input_node.append(new_node2)
    #module_nodes.append(new_node2)
        #print("New module nodes: ", module_nodes)
        #print("New Input list : ", input_node)
    gate_name="andgate_"+ str(pi_node_number-1) #identical gatename
    new_temp_node= "andgate"+ str(pi_node_number-1) #output node
    device_list.append(gate_name)
    wire_node.append(new_temp_node)    


    sig_to_out[new_temp_node]=gate_name #update output library
        #print("New Gate signal to out Dictonary: ", sig_to_out)

    gate_out[gate_name]= new_temp_node
        #print("New Gate Out Dictonary: ", gate_out)   

        
    gate_type[gate_name]="AND"+"2X1"
        #print("New Gate Type Dictonary: ",gate_type)     

        
    gate_in[gate_name]=[new_node,new_node2]


    gate_name_list=[gate_name]
    sig_to_in[new_node]=gate_name_list
    sig_to_in[new_node2]=gate_name_list
    



    for m in range(len(sar_output_node)):
        
        new_node= "andgate"+str(pi_node_number-1)
        x=sar_output_node[m]
        
    
        #input_node.append(new_node)
        #module_nodes.append(new_node)
        #print("New module nodes: ", module_nodes)
        #print("New Input list : ", input_node)
        gate_name="XOR_out"+str(m)
        new_temp_node=  str(x)
        device_list.append(gate_name)
        wire_node.append(x)
        output_node[m]=str(x)+"_sar"

        #y_gate= sig_to_out.get(x)
    
        #gate_out[y_gate]= 
        gate_out[gate_name]= str(x)+"_sar"

        gate_in[gate_name]=[new_temp_node,new_node]

        y=module_nodes.index(str(x))
        module_nodes[y]=str(x)+"_sar"
        #print("New Gate Out Dictonary: ", gate_out)
        #print(x, "New Signal output to gates: ", gate_name)
        #print("New Gate in Dictonary: ", gate_in)


        sig_to_out[str(x)+"_sar"]=gate_name
        #sig_to_out[new_node]='Output to modeul'
    
        #print("New Gate signal to out Dictonary: ", sig_to_out)

    
        gate_type[gate_name]="XOR"+"2X1"
        #print("New Gate Type Dictonary: ",gate_type)        
    
        gate_name_list=[gate_name]
   
        sig_to_in[new_temp_node]=gate_name_list
        sig_to_in[new_node]=gate_name_list

        #print("New Gate signal to in Dictonary: ", sig_to_in)
        

          

       
def sarlock():

    global gatenumber
    global gate_out
    global gate_in
    global gate_type
    global sig_to_in
    global sig_to_out
    global module_nodes
    global device_list

    global pi_node_number
    sarlock_xorgate_mask()
    sarlock_comparator()

    sarlock_andgate()
    sarlock_orgate()

    sarlock_po()

    

def print_module():
    global module_nodes
    m_len= len (module_nodes)
    module_nodes_string= ""
    for m in range(m_len):
        module_ns=module_nodes[m]
        module_ns=module_ns.strip("'")
        if m==0:
            module_nodes_string= module_ns
        else:
            module_nodes_string= module_nodes_string+"," + module_ns
    
    new_netlist = open("obsfucation.txt", "a")
    #new_netlist.write("`timescale 1ns/10ps\n")
    new_netlist.write("module "+ module_name+ " ("+ module_nodes_string+");\n")
    

def print_input():
    global input_node
    m_len= len (input_node)
    input_nodes_string= ""
    for m in range(m_len):
        input_ns= input_node[m]
        input_ns= input_ns.strip("'")
        if m==0:
            input_nodes_string= input_ns
        else:
            input_nodes_string= input_nodes_string+"," + input_ns
    
    new_netlist = open("obsfucation.txt", "a")
    new_netlist.write("input "+ input_nodes_string+";\n")




def print_output():
    global output_node
    m_len= len (output_node)
    output_nodes_string= ""
    for m in range(m_len):
        output_ns= output_node[m]
        output_ns= output_ns.strip("'")
        if m==0:
            output_nodes_string= output_ns
        else:
            output_nodes_string= output_nodes_string+"," + output_ns
    
    new_netlist = open("obsfucation.txt", "a")
    new_netlist.write("output "+ output_nodes_string+";\n")


def print_wire():
    global wire_node
    m_len= len (wire_node)
    wire_nodes_string= ""
    for m in range(m_len):
        wire_ns= wire_node[m]
        wire_ns= wire_ns.strip("'")
        if m==0:
            wire_nodes_string= wire_ns
        else:
            wire_nodes_string= wire_nodes_string+"," + wire_ns
    
    new_netlist = open("obsfucation.txt", "a")
    new_netlist.write("wire "+ wire_nodes_string+";\n")



def print_device():
    global device_list
    global gate_out
    global gate_in
    global gate_type
    new_netlist = open("obsfucation.txt", "a")
    d_len=len(device_list)
    for dx in range(d_len):
        d_name= device_list[dx]
        d_name=d_name.strip("'")
        d_type= gate_type.get(d_name)
        d_type=d_type.strip("'")
        d_output=gate_out.get(d_name)
        d_output= d_output.strip("'")
        d_input= gate_in.get(d_name)
        d_in_len= len(d_input)
        
        if d_in_len == 2:                     
            d_input1=d_input[0]
            d_input1=d_input1.strip("'")
            d_input2=d_input[1]
            d_input2=d_input2.strip("'")
            new_netlist.write(d_type+ " "+ d_name+" (.Y("+d_output+"),.A("+d_input1+"),.B("+ d_input2+"));\n")

        else:
            d_input1=d_input[0]
            d_input1=d_input1.strip("'")
            new_netlist.write(d_type+ " "+ d_name+" (.Y("+d_output+"),.A("+d_input1+"));\n")

    new_netlist.write("endmodule")


def print_netlist():
    print_module()
    print_input()
    print_output()
    print_wire()
    print_device()
    
input_node=[]
output_node=[]
wire_node=[]
gate_in={}
gate_out={}
sig_to_out={}
sig_to_in={}
gate_type={}
new_node="0"
module_name =""
module_nodes=[]
device_list=[]
xor_signal=[]
gate_count=0
node_list=[]
already_key_flag=0
gatenumber=0

##SARlock Signals

pi_node_number=0


def verilog_obfuscation():
    global gatenumber
    global gate_count
    global node_list
    
        
    print("Enter the name of a file for parsing ")

    filename= input()
    
    with open(filename,"rt")as filein:

        lines= filein.readlines()

        #print(lines)

        line_len= (len(lines))

        for x in range (line_len):

            line_in= str(lines[x])
            line_striped =line_in.strip(';\n')
            line_list=line_striped.split(" ")

            mod_len=len(line_list[0])
            mod_ls=line_list[0][mod_len-3:mod_len]

            #print(line_list)
            if line_list[0]=='module':
                module(line_list)

            elif line_list[0]=='input':
                input_list(line_list[1])

            elif line_list[0]=='output':
                output_list(line_list[1])

            elif line_list[0]=='wire':
                wire_list(line_list[1])

            elif line_list[0]=='endmodule':
                continue
            elif mod_ls =='2X1':
                gate2X1(line_list)
                gate_count=gate_count+1
            else:
                gate(line_list)
                gate_count=gate_count+1


            #print(mod_ls)


    node_list = module_nodes + wire_node

    print("Input list : ", input_node)
    print("Output list : ", output_node)
    print("Wire list : ", wire_node)
    print("All nodes : ", node_list)


    print("Gate in Dictonary: ", gate_in)
    print("Gate Out Dictonary: ", gate_out)

    print("Gate signal to out Dictonary: ", sig_to_out)
    print("Gate signal to in Dictonary: ", sig_to_in)

    print("Gate Type Dictonary: ",gate_type)

    print("*****************************************************************************************")
    print("*****************************************************************************************")

    print("Give the number of percentage of gates you want to add for logic locking")

    p_key= input()

    random_key_gates_input(int(p_key))


    print("Logic locking done, if you want more key gate to input: ")   

        
    xor_sig="Yes"

    while xor_sig != "skip":
        print("Give a signal name to add key gate after it")
        print("Or write 'skip' to exit ")
        xor_sig=input()
        print("Give a Gate type name to add after it")
        g_to_add= input()
        if xor_sig== "skip":
            
            break
        
        else:
            print("Signal to add Xor after: ", xor_sig)
            check_signal(xor_sig, g_to_add)
            gatenumber=gatenumber+1

    print("Want to lock with SARLock??: Press 'y' or 'n'")

    sarlock_sig=input()
    if sarlock_sig=="y":
        sarlock()

    
    print_netlist()

    print("obfuscation completed")
    print("Thank you for obfuscation")
    print("For obfuscation again, run the code one more time")
            



'''
    print("Give a Gate name to show input Signals of the Gate")
    gin=input()
    gin2=gate_in.get(gin,"Not found this gate ")
    print(gin,"Gate's Inputs: ", gin2)
    
    print("Give a Gate name to show output Signal of the Gate")
    gout=input()
    gout2=gate_out.get(gout,"Not found this gate")
    print(gout,"Gate's Output: ", gout2)

    print("Give a Signal name to show Singnal from output Gate name")
    s_in=input()
    s_in2=sig_to_out.get(s_in,"Not found this Signal")
    print(s_in, "Signal out from gate: ", s_in2)

    print("Give a Signal name to show Singnal to input Gate names")
    s_out=input()
    s_out2=sig_to_in.get(s_out,"Not found this Signal")
    print(s_out, "Signal input to gates: ",s_out2)


    print("Give a Gate name to show the Gate Type name")
    g_type=input()
    g_type2=gate_type.get(g_type,"Not found this gate")
    print(g_type, "Gate's type is: ",g_type2)



    print("Parsing complited")
    print("Thank you for Parsing")
    print("For parsing again, run the code one more time")

   '''


verilog_obfuscation()
