module decoder3x8_tb ();

	reg [2:0] A;
	wire [7:0] Y;
	
	
	decoder3x8  uut_decoder3x8 (.A2(A[2]), .A1(A[1]), .A0(A[0]), .Y7(Y[7]), .Y6(Y[6]), .Y5(Y[5]), .Y4(Y[4]), .Y3(Y[3]), .Y2(Y[2]), .Y1(Y[1]), .Y0(Y[0]));
	
	initial begin
	A=3'b000;
	#100;
	A=3'b001;
	#100;
	A=3'b010;
	#100;
	A=3'b011;
	#100;
	A=3'b100;
	#100;
	A=3'b101;
	#100;
	A=3'b110;
	#100;
	A=3'b111;
	#100;
	
	$finish;
	end
endmodule



