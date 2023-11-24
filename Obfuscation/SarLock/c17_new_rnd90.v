module c17 (N1,N2,N3,N6,N7,N22,N23,keyinput0,keyinput1,keyinput2,keyinput3);
input N1,N2,N3,N6,N7,keyinput0,keyinput1,keyinput2,keyinput3;
output N22,N23;
wire N10,N11,N16,N19,N6enc,N19enc,N11enc,N2enc;
NAND2X1 NAND2_1 (.Y(N10),.A(N1),.B(N3));
NAND2X1 NAND2_2 (.Y(N11),.A(N3),.B(N6enc));
NAND2X1 NAND2_3 (.Y(N16),.A(N2enc),.B(N11enc));
NAND2X1 NAND2_4 (.Y(N19),.A(N11enc),.B(N7));
NAND2X1 NAND2_5 (.Y(N22),.A(N10),.B(N16));
NAND2X1 NAND2_6 (.Y(N23),.A(N16),.B(N19enc));
XOR2X1 XOR2_N6 (.Y(N6enc),.A(N6),.B(keyinput0));
XNOR2X1 XNOR2_N19 (.Y(N19enc),.A(N19),.B(keyinput1));
XOR2X1 XOR2_N11 (.Y(N11enc),.A(N11),.B(keyinput2));
XOR2X1 XOR2_N2 (.Y(N2enc),.A(N2),.B(keyinput3));
endmodule