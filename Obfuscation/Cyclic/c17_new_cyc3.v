module c17 (N1,N2,N3,N6,N7,N22,N23,keyinput0,keyinput1,keyinput2,keyinput3);
input N1,N2,N3,N6,N7,keyinput0,keyinput1,keyinput2,keyinput3;
output N22,N23;
wire N10,N11,N16,N19,muxed0,muxed1,muxed2,muxed3;
NAND2X1 NAND2_1 (.Y(N10),.A(muxed0),.B(N3));
NAND2X1 NAND2_2 (.Y(N11),.A(N3),.B(N6));
NAND2X1 NAND2_3 (.Y(N16),.A(N2),.B(N11));
NAND2X1 NAND2_4 (.Y(N19),.A(N11),.B(N7));
NAND2X1 NAND2_5 (.Y(N22),.A(muxed2),.B(N16));
NAND2X1 NAND2_6 (.Y(N23),.A(N16),.B(N19));
MX2X1 mux_0 (.Y(muxed0),.A(muxed1),.B(N22),.S0(keyinput0);
MX2X1 mux_1 (.Y(muxed1),.A(N1),.B(N2),.S0(keyinput1);
MX2X1 mux_2 (.Y(muxed2),.A(muxed3),.B(muxed3),.S0(keyinput2);
MX2X1 mux_3 (.Y(muxed3),.A(N10),.B(N22),.S0(keyinput3);
endmodule