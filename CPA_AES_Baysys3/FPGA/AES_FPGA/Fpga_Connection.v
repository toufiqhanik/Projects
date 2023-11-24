module Fpga_Connection(clk, rst, cmd_send, tx_data, data_in, clk_in, clk_out, data_out, rx_data, receive_ok);

	input clk, rst;
	input cmd_send;
	input clk_in; 
	input [7:0] data_in;
	input [127:0] tx_data;
	output reg clk_out;
	output reg [7:0] data_out;
	output reg receive_ok;
	output reg [127:0] rx_data;
	
	reg [6:0] clk_cnt;
	reg [4:0] cnt_bit_rx, cnt_bit_tx;
	reg [127:0] TX;
	
	reg clk_out_en;
	reg clk_in_back;
	reg clk_out_back;
	reg state;
	localparam IDLE = 1'b0, SEND = 1'b1;
	
	
	always @(posedge clk)
	begin
		if(rst == 1'b1)
		begin
			clk_out_en <= 1'b0;
			clk_cnt	  <= 7'd0;
			clk_out	  <= 1'b0;
			data_out	  <= 8'd0;		
			receive_ok <= 1'b0;
			rx_data	  <= 128'd0;
			cnt_bit_rx <= 5'd0;
			cnt_bit_tx <= 5'd0;
 			state		  <= IDLE;
		end
		else
		begin
			clk_in_back	 <= clk_in;
			clk_out_back <= clk_out;
			
			if(clk_out_en == 1'b1)
				clk_cnt <= clk_cnt + 7'd1;
				
			if(clk_cnt == 7'd127)
				clk_out <= ~clk_out; 
			
			if(clk_in_back == 1'b1 && clk_in == 1'b0)
			begin
				rx_data <= {rx_data[119:0],data_in}; 
				cnt_bit_rx <= cnt_bit_rx + 5'd1;
			end
			
			if(cnt_bit_rx == 5'd16)
			begin
				receive_ok <= 1'b1;
				cnt_bit_rx	  <= 5'd0;
			end
			else
				receive_ok <= 1'b0;
			
			case(state)
				IDLE:
				begin
					if(cmd_send == 1'b1)
					begin
						clk_out_en <= 1'b1;
						TX			  <= tx_data;
						state		  <= SEND;
 					end
					else
					begin
						clk_out_en <= 1'b0;
						clk_cnt	  <= 7'd0;
						clk_out	  <= 1'b0;
						data_out	  <= 1'b0;		
						cnt_bit_tx <= 5'd0;			
					end
				end
				SEND:
				begin
					if(clk_out_back == 1'b0 && clk_out == 1'b1)
					begin
						data_out 		<= TX[127:120];
						TX[127:0]		<= {TX[119:0], 8'd0};
						cnt_bit_tx		<= cnt_bit_tx + 5'd1; 
					end
					if(cnt_bit_tx == 5'd16 && clk_out_back == 1'b1 && clk_out == 1'b0)
						state		  <= IDLE;
				end
				
			endcase
		end	
	
	
	
	end

endmodule	
	
	