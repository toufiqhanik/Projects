module fpga1(input clk, input rst, output rst_out, input rx, output tx, output [3:0] in, input[7:0] data_in, input clk_in, output [7:0] data_out, output clk_out, output [5:0] cout);

    
    reg [3:0] state;
    parameter IDLE = 4'd0, SEND_To_FPGA2 = 4'd1, RECEIVE_From_FPGA2 = 4'd2, SEND_To_PC = 4'd3, FINISH = 4'd4;
    reg send_cmd;
    reg [127:0] send_data;
    wire serial_busy;
    wire receive_ack;
    wire [127:0] receive_data;
    reg receive_ack_back;
    reg [127:0] fpga2_data_send;
    
    reg send_fpga;
    wire [127:0] fpga2_data_receive;
    wire fpga2_data_receive_ok;
    wire [5:0] out_rx_counter;
    wire clk_in_filter;
    wire [7:0] data_in_filter;
    
    rs232 uut1(.clk(clk), .rst(rst), .tx(tx), .rx(rx), .send_cmd(send_cmd), .send_data(send_data), .receive_ack(receive_ack), .receive_data(receive_data), .busy(serial_busy), .test(in), .out_rx_counter(out_rx_counter));
    
    Fpga_Connection uut2 (.clk(clk) , .rst(rst), .cmd_send(send_fpga), .tx_data(fpga2_data_send), .data_in(data_in_filter), .clk_in(clk_in_filter), .clk_out(clk_out), .data_out(data_out), .rx_data(fpga2_data_receive), .receive_ok(fpga2_data_receive_ok));
    
    small_filter #(.wd(5), .n(31), .bound(20))  uut11(.clk(clk), .data_in(clk_in), .data_out(clk_in_filter), .data_edge());
    
    small_filter #(.wd(5), .n(31), .bound(20))  uut3(.clk(clk), .data_in(data_in[0]), .data_out(data_in_filter[0]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut4(.clk(clk), .data_in(data_in[1]), .data_out(data_in_filter[1]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut5(.clk(clk), .data_in(data_in[2]), .data_out(data_in_filter[2]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut6(.clk(clk), .data_in(data_in[3]), .data_out(data_in_filter[3]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut7(.clk(clk), .data_in(data_in[4]), .data_out(data_in_filter[4]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut8(.clk(clk), .data_in(data_in[5]), .data_out(data_in_filter[5]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut9(.clk(clk), .data_in(data_in[6]), .data_out(data_in_filter[6]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut10(.clk(clk), .data_in(data_in[7]), .data_out(data_in_filter[7]), .data_edge());
    
    always @(posedge clk)
    begin
        receive_ack_back <= receive_ack;
        if(rst == 1'b1)
        begin
            state <= IDLE;
            send_fpga <= 1'b0;
            fpga2_data_send <= 128'd0;
          end 
        else
        begin
        case(state)
            IDLE:
            begin
               send_cmd <= 1'b0;  
               if(receive_ack_back == 1'b1)
               begin
                   state <= SEND_To_FPGA2;
                   fpga2_data_send <= receive_data;
               end    
               else
                   state <= IDLE;         
            end
            
            
            SEND_To_FPGA2:
            begin
               send_fpga <= 1'b1; 
               state <= RECEIVE_From_FPGA2;
            end
            
            RECEIVE_From_FPGA2:
            begin
                send_fpga <= 1'b0;
                if(fpga2_data_receive_ok == 1'b1)
                begin
                    send_data <= fpga2_data_receive;
                    state <= SEND_To_PC;
                end
            end
            
            SEND_To_PC:
            begin
                send_cmd <= 1'b1;
                state <= FINISH;
            end 
            FINISH:
            begin
                send_cmd <= 1'b0;
                state <=IDLE;
            end
        endcase   
    end
end

assign cout = out_rx_counter;
assign rst_out = rst;
endmodule