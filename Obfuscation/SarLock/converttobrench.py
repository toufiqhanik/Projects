'''
Python code for Obfuscation Verilog Test Brench

Xor before signal.
Brench
Code Written by:
Md. Toufiq Hasan Anik
CSEE, UMBC, MD.

Date: 23.07.2018
'''

#Calling the main function (verilog_obfuscation())





def module(x):
    global module_name
    global module_nodes
    module_name = x[1]
    modlue_nodes= x[2].strip('(')
    modlue_nodes= modlue_nodes.strip(')')
    module_nodes= modlue_nodes.split(",")
    print("Main Module Name : ", module_name)
    print("Main Module node list :", module_nodes)

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

    global gate_out
    gate_out[gate_name]=output_node



    global gate_in
    gate_in[gate_name]=[input_node,input_node2]

    global gate_type
    gate_type[gate_name]=gate_type_name

    global sig_to_in

    sig_to_in.setdefault(input_node,[]).append(gate_name)
    sig_to_in.setdefault(input_node2,[]).append(gate_name)



    global sig_to_out
    sig_to_out[output_node]=gate_name
    #sig_to_out.setdefault(output_node,[]).append(gate_name)
    device_list.append(gate_name)




def gate(x):
    global device_list
    gate_type_name = x[0]
    if(gate_type_name== "INVX1"):
        gate_type_name="NOTX1"
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
    input_node=x.split(',')

    #print("input list: ",input_node)


def output_list(x):
    global output_node
    output_node=x.split(',')
    #print("output list: ", output_node)

def wire_list(x):
    global wire_node
    wire_node=x.split(',')
    #print("wire list: ", wire_node)


def xor_add_sig_in(x):
    
    global gate_out
    global gate_in
    global gate_type
    global sig_to_in
    global sig_to_out
    global module_nodes
    global device_list



    global new_node
    new_node= "K_"+x
    global input_node
    
    input_node.append(new_node)
    module_nodes.append(new_node)
    #print("New module nodes: ", module_nodes)
    #print("New Input list : ", input_node)
    gate_name="XOR2_"+ x
    new_temp_node= x + "_temp"
    device_list.append(gate_name)
    wire_node.append(new_temp_node)    


    sig_to_out[new_temp_node]=gate_name
    #print("New Gate signal to out Dictonary: ", sig_to_out)

    gate_out[gate_name]= new_temp_node
    #print("New Gate Out Dictonary: ", gate_out)   

    
    gate_type[gate_name]="XOR2X1"
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

    

    
def xor_add_sig_out(x):
    global gate_out
    global gate_type
    global gate_in
    global sig_to_in
    global sig_to_out
    global module_nodes
    global device_list
    



    global new_node
    new_node= "K_"+x
    global input_node
    
    input_node.append(new_node)
    module_nodes.append(new_node)
    #print("New module nodes: ", module_nodes)
    #print("New Input list : ", input_node)
    gate_name="XOR2_"+ x
    new_temp_node= x +"_temp"
    device_list.append(gate_name)
    wire_node.append(new_temp_node)

    y_gate= sig_to_out.get(x)
    
    gate_out[y_gate]= new_temp_node
    gate_out[gate_name]= x

    gate_in[gate_name]=[new_temp_node,new_node]
    
    #print("New Gate Out Dictonary: ", gate_out)
    #print(x, "New Signal output to gates: ", gate_name)
   # print("New Gate in Dictonary: ", gate_in)


    sig_to_out[x]=gate_name
    sig_to_out[new_node]='Output to modeul'
    
    #print("New Gate signal to out Dictonary: ", sig_to_out)

    
    gate_type[gate_name]="XOR2X1"
    #print("New Gate Type Dictonary: ",gate_type)        
    
    gate_name_list=[gate_name]
   
    sig_to_in[new_temp_node]=gate_name_list
    sig_to_in[new_node]=gate_name_list

    #print("New Gate signal to in Dictonary: ", sig_to_in)

    

def check_signal(x):
    global sig_to_in
    global sig_to_out
    global xor_signal

    
    

    sig_have = sig_to_in.get(x,"none")
    sig_have2= sig_to_out.get(x,"none")

    x_len= len(xor_signal)
    xor_flag=0

    for xl in range (x_len):
        if xor_signal[xl] == x:
            xor_flag=1
            print("You already included this signal, Please use other signal")
        

    
    
    if xor_flag==0:
        
        if sig_have == "none":
            
            if sig_have2 != "none":
                xor_add_sig_out(x)
                xor_signal.append(x)
                print("Signal added for Obfuscation Successfully") 
                    
            else:
                print("No signal exist with this name, Please input correctly. ")
        else:
            xor_add_sig_in(x)
            xor_signal.append(x)
            print("Signal added for Obsfucation Successfully")
                      
        


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
    new_netlist.write("`timescale 1ns/10ps\n")
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


def print_b_inputs():
    new_netlist = open("try.bench", "a")
    global input_node
    m_len= len (input_node)
    input_nodes_string= ""
    for m in range(m_len):
        input_ns= input_node[m]
        input_ns= input_ns.strip("'")
        input_nodes_string= input_ns
        new_netlist.write("INPUT("+ input_nodes_string+")\n")

def print_b_output():
    new_netlist = open("try.bench", "a")
    global output_node
    m_len= len (output_node)
    output_nodes_string= ""
    for m in range(m_len):
        output_ns= output_node[m]
        output_ns= output_ns.strip("'")
        output_nodes_string= output_ns
        new_netlist.write("OUTPUT("+ output_nodes_string+")\n")

    new_netlist.write("\n")

def print_b_nodes():
    new_netlist = open("try.bench", "a")

    global device_list
    global gate_out
    global gate_in
    global output_node
    global gate_type
    node_len=len(device_list)
    for dx in range(node_len):
        d_name= device_list[dx]
        d_name=d_name.strip("'")
        d_type= gate_type.get(d_name)
        d_type=d_type.strip("'")
        d_output=gate_out.get(d_name)
        d_output= d_output.strip("'")
        d_input= gate_in.get(d_name)
        d_in_len= len(d_input)
        
        if d_in_len == 2:
            d_type=d_type.strip("21")
            d_type=d_type[0:len(d_type)-2]
            #print("d_type:", d_type)
            d_type=d_type.lower()
            d_input1=d_input[0]
            d_input1=d_input1.strip("'")
            d_input2=d_input[1]
            d_input2=d_input2.strip("'")
            new_netlist.write(d_output+" = "+d_type+"("+d_input1+", "+ d_input2+")\n")

        else:
            d_type=d_type.strip("X1")
            d_type=d_type.lower()
            d_input1=d_input[0]
            d_input1=d_input1.strip("'")
            new_netlist.write(d_output+" = "+d_type+"("+d_input1+")\n")
    
    

def print_brench():
    print_b_inputs()
    print_b_output()
    print_b_nodes()

def verilog_obfuscation():
    global filename
    
        
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
            #print("mod_ls:", mod_ls)

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
            else:
                gate(line_list)


            #print(mod_ls)
        print_brench()




    '''print("Input list : ", input_node)
    print("Output list : ", output_node)
    print("Wire list : ", wire_node)


    print("Gate in Dictonary: ", gate_in)
    print("Gate Out Dictonary: ", gate_out)

    print("Gate signal to out Dictonary: ", sig_to_out)
    print("Gate signal to in Dictonary: ", sig_to_in)

    print("Gate Type Dictonary: ",gate_type)'''
    


'''

    xor_sig="Yes"

    while xor_sig != "skip":
        print("Give a signal name to add Xor after it")
        print("Or write 'skip' to exit ")
        xor_sig=input()
        if xor_sig== "skip":
            print_netlist()
            break
        
        else:
            print("Signal to add Xor after: ", xor_sig)
            check_signal(xor_sig)

    print("obfuscation completed")
    print("Thank you for obfuscation")
    print("For obfuscation again, run the code one more time")
            




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

