module decoder3x8 (A2, A1, A0, Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0);
	input A2, A1, A0;
	output Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0;

	wire A2_bar, A1_bar, A0_bar;

	not uut_A2_bar (A2_bar, A2);
	not uut_A1_bar (A1_bar, A1);
	not uut_A0_bar (A0_bar, A0);

	and uut_Y7 ( Y7, A2, A1, A0);
	and uut_Y6 ( Y6, A2, A1, A0_bar);
	and uut_Y5 ( Y5, A2, A1_bar, A0);
	and uut_Y4 ( Y4, A2, A1_bar, A0_bar);
	and uut_Y3 ( Y3, A2_bar, A1, A0);
	and uut_Y2 ( Y2, A2_bar, A1, A0_bar);
	and uut_Y1 ( Y1, A2_bar, A1_bar, A0);
	and uut_Y0 ( Y0, A2_bar, A1_bar, A0_bar);

endmodule