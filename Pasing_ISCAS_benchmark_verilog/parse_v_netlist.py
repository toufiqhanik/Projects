'''
Python code for parsing Verilog Test Brench

Code Written by:
Md. Toufiq Hasan Anik
CSEE, UMBC, MD.

Date: 7.13.2018
'''

print("Enter the name of a file for parsing ")

filename= input()
input_node=[]
output_node=[]
wire_node=[]
gate_in={}
gate_out={}
sig_to_out={}
sig_to_in={}
gate_type={}



def module(x):
    module_name = x[1]
    modlue_nodes= x[2].strip('(')
    modlue_nodes= modlue_nodes.strip(')')
    module_nodes= modlue_nodes.split(",")
    print("Main Module Name : ", module_name)
    print("Main Module node list :", module_nodes)

def gate2X1(x):
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
    

    

def gate(x):
    gate_type_name = x[0]
    gate_name= x[1]
    gate_nodes= x[2].strip('(.Y(')
    gate_nodes= gate_nodes.strip('))')
    gate_nodes= gate_nodes.split(",")
    output_node =gate_nodes[0].strip(')')

    input_node =gate_nodes[1].strip('.A(')
    input_node =input_node.strip(')')
    
    global gate_out
    gate_out[gate_name]=output_node
    

    global sig_to_out
    #sig_to_out.setdefault(output_node,[]).append(gate_name)
    sig_to_out[output_node]=gate_name
    
    input_node_in =[input_node]
    global gate_in
    gate_in[gate_name]=input_node_in

    global sig_to_in
    
    sig_to_in.setdefault(input_node,[]).append(gate_name)

    global gate_type
    gate_type[gate_name]=gate_type_name

    
    
    

    
    
     
     
    

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
        else:
            gate(line_list)
        
        
        #print(mod_ls)

        
        
        
        

print("Input list : ", input_node)
print("Output list : ", output_node)
print("Wire list : ", wire_node)


print("Gate in Dictonary: ", gate_in)
print("Gate Out Dictonary: ", gate_out)

print("Gate signal to out Dictonary: ", sig_to_out)
print("Gate signal to in Dictonary: ", sig_to_in)

print("Gate Type Dictonary: ",gate_type)



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

