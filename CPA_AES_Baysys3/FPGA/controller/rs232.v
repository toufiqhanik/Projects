`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2019 10:14:49 AM
// Design Name: 
// Module Name: rs232
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rs232(clk, rst, tx, rx, send_cmd, send_data, receive_ack, receive_data, busy, test, out_rx_counter);
    input clk, rst, send_cmd;
    input [127:0] send_data;
    input rx;
    output tx;
    output reg receive_ack;
    output reg [127:0] receive_data;
    output reg busy;
    output wire [5:0] out_rx_counter;
    
    
    reg[3:0] state;
    parameter IDLE = 4'd0, LOAD = 4'd1, TX_CMD = 4'd2, WAIT = 4'd3, DEC_TX = 4'd4, WAIT2 = 4'd5, FINISH = 4'd6, RCV= 4'd7, SEND_DATA= 4'd8;
    reg[5:0] rx_counter, tx_counter;
    reg receive_back;
    reg[7:0]rx_byte_back;
    
    reg [3:0] tx_temp;
    reg [7:0] tx_byte;
    wire [7:0] rx_byte;
    reg transmit;
    wire receive;
    wire rx_busy, tx_busy;
    
    reg [12:0] wait_counter;
    wire recv_error;
    
    output reg [3:0] test;
    //reg we1, we;
        //    uart #(
        //        .baud_rate(9600),            // default is 9600
        //        .sys_clk_freq(100000000)       // default is 100000000
        //     )
        //    instance_name(
        
    uart modul(
        .clk(clk),                        // The master clock for this module
        .rst(rst),                        // Synchronous reset
        .rx(rx_filter),                          // Incoming serial line
        .tx(tx),                          // Outgoing serial line
        .transmit(transmit),              // Signal to transmit
        .tx_byte(tx_byte),                // Byte to transmit       
        .received(receive),              // Indicated that a byte has been received
        .rx_byte(rx_byte),                // Byte received
        .is_receiving(rx_busy),      // Low when receive line is idle
        .is_transmitting(tx_busy),      // Low when transmit line is idle
        .recv_error(recv_error)           // Indicates error in receiving packet.
      //.recv_state(recv_state),          // for test bench
      //.tx_state(tx_state)               // for test bench
    );
    
    
    small_filter #(.wd(3), .n(7), .bound(5))  uut1(.clk(clk), .data_in(rx), .data_out(rx_filter), .data_edge());
    
    
    function [3:0] rx_byte_temp;
        input [7:0] x;
        begin
             case(x)                
                8'h30 : rx_byte_temp =4'b0000;
                8'h31 : rx_byte_temp =4'b0001;
                8'h32 : rx_byte_temp =4'b0010;
                8'h33 : rx_byte_temp =4'b0011;
                8'h34 : rx_byte_temp =4'b0100;
                8'h35 : rx_byte_temp =4'b0101;
                8'h36 : rx_byte_temp =4'b0110;
                8'h37 : rx_byte_temp =4'b0111;
                
                8'h38 : rx_byte_temp =4'b1000;
                8'h39 : rx_byte_temp =4'b1001;
                8'h61 : rx_byte_temp =4'b1010;
                8'h62 : rx_byte_temp =4'b1011;
                8'h63 : rx_byte_temp =4'b1100;
                8'h64 : rx_byte_temp =4'b1101;
                8'h65 : rx_byte_temp =4'b1110;
                8'h66 : rx_byte_temp =4'b1111;
                default: rx_byte_temp = 0;
                endcase
 
            end
    endfunction
    
    function [8:0] tx_byte_temp;
    input [3:0]y; 
       begin
             case(y)
             4'b0000 : tx_byte_temp= 8'h30;
             4'b0001 : tx_byte_temp= 8'h31;
             4'b0010 : tx_byte_temp= 8'h32;
             4'b0011 : tx_byte_temp= 8'h33;
             4'b0100 : tx_byte_temp= 8'h34;
             4'b0101 : tx_byte_temp= 8'h35;
             4'b0110 : tx_byte_temp= 8'h36;
             4'b0111 : tx_byte_temp= 8'h37;
                                
             4'b1000 : tx_byte_temp= 8'h38;
             4'b1001 : tx_byte_temp= 8'h39;
             4'b1010 : tx_byte_temp= 8'h61;
             4'b1011 : tx_byte_temp= 8'h62;
             4'b1100 : tx_byte_temp= 8'h63;
             4'b1101 : tx_byte_temp= 8'h64;
             4'b1110 : tx_byte_temp= 8'h65;
             4'b1111 : tx_byte_temp= 8'h66;
             default: tx_byte_temp = 0;
             endcase
             end
    endfunction
    
    always @(posedge clk)
    begin 
        receive_back    <= receive;
        rx_byte_back    <= rx_byte;
        if(rst == 1'b1)
        begin
            state <= IDLE;
            receive_ack <= 1'b0;
            busy <= 0;
            tx_counter <= 0;
            rx_counter <= 0;
        end
        else
        begin
            case(state)
                IDLE:
                begin
                    if(receive == 1'b1)
                    begin
                        state <= RCV;
                        receive_ack <= 1'b0;
                        busy <= 1;
                        rx_counter <= 0;
                    end
                    else if(send_cmd == 1'b1)
                    begin
                        busy <= 1;
                        state <= LOAD;
                        tx_counter <= 0;
                    end
                    else
                    begin
                        state <= IDLE;
                        receive_ack <= 1'b0;
                        busy <= 0;
                        tx_counter <= 0;
                        rx_counter <= 0;
                    end    
                end
                RCV: begin 
                   if(receive_back) begin
                          test <= rx_byte_temp(rx_byte_back);
                        rx_counter <= rx_counter + 1;
                        case (rx_counter)
                          0: receive_data[127:124] <=rx_byte_temp(rx_byte_back);
                          1: receive_data[123:120] <=rx_byte_temp(rx_byte_back);
                          2: receive_data[119:116] <=rx_byte_temp(rx_byte_back);
                          3: receive_data[115:112] <=rx_byte_temp(rx_byte_back);
                          4: receive_data[111:108] <=rx_byte_temp(rx_byte_back); 
                          5: receive_data[107:104] <=rx_byte_temp(rx_byte_back); 
                          6: receive_data[103:100] <=rx_byte_temp(rx_byte_back); 
                          7: receive_data[99:96] <=rx_byte_temp(rx_byte_back); 
                          8: receive_data[95:92] <=rx_byte_temp(rx_byte_back); 
                          9: receive_data[91:88] <=rx_byte_temp(rx_byte_back);
                          10: receive_data[87:84] <=rx_byte_temp(rx_byte_back);
                          11: receive_data[83:80] <=rx_byte_temp(rx_byte_back);
                          12: receive_data[79:76] <=rx_byte_temp(rx_byte_back);
                          13: receive_data[75:72] <=rx_byte_temp(rx_byte_back);
                          14: receive_data[71:68] <=rx_byte_temp(rx_byte_back); 
                          15: receive_data[67:64] <=rx_byte_temp(rx_byte_back);
                          
                          16: receive_data[63:60] <=rx_byte_temp(rx_byte_back);
                          17: receive_data[59:56] <=rx_byte_temp(rx_byte_back);
                          18: receive_data[55:52] <=rx_byte_temp(rx_byte_back);
                          19: receive_data[51:48] <=rx_byte_temp(rx_byte_back);
                          20: receive_data[47:44] <=rx_byte_temp(rx_byte_back); 
                          21: receive_data[43:40] <=rx_byte_temp(rx_byte_back); 
                          22: receive_data[39:36] <=rx_byte_temp(rx_byte_back); 
                          23: receive_data[35:32] <=rx_byte_temp(rx_byte_back); 
                          24: receive_data[31:28] <=rx_byte_temp(rx_byte_back); 
                          25: receive_data[27:24] <=rx_byte_temp(rx_byte_back);
                          26: receive_data[23:20] <=rx_byte_temp(rx_byte_back);
                          27: receive_data[19:16] <=rx_byte_temp(rx_byte_back);
                          28: receive_data[15:12] <=rx_byte_temp(rx_byte_back);
                          29: receive_data[11:8] <=rx_byte_temp(rx_byte_back);
                          30: receive_data[7:4] <=rx_byte_temp(rx_byte_back); 
                          31: receive_data[3:0] <=rx_byte_temp(rx_byte_back);
                       endcase
                       if(rx_counter == 31)
                       begin
                           state <= IDLE;
                           receive_ack <= 1'b1;
                       end    
                       else
                           state <= RCV;
                    end
                    
                end
                LOAD:
                begin
                    tx_byte <= tx_byte_temp(tx_temp);
                    state   <= TX_CMD;     
                end
                TX_CMD:
                begin
                    transmit <= 1'b1;
                    state    <= WAIT;
                end 
                WAIT:
                begin
                    state <= DEC_TX;
                    transmit <= 1'b0;
                end
                DEC_TX:
                begin
                    if(tx_counter < 6'd31)
                    begin  
                        if(tx_busy == 1'b0)
                        begin  
                            state <= WAIT2;
                            wait_counter <= 13'd0;
                            tx_counter <= tx_counter + 6'd1;
                        end    
                        else
                            state <= DEC_TX;                               
                    end 
                    else
                        state <= IDLE;      
                end
                WAIT2:
                begin
                    wait_counter <= wait_counter + 1;
                    if(wait_counter > 13'd3000)
                        state <= LOAD;
                end 
            endcase
        end
        
        
    
    end
    
    
    always @(posedge clk)
        begin
            case(tx_counter)
                0:  tx_temp <= send_data[127:124];
                1:  tx_temp <= send_data[123:120];
                2:  tx_temp <= send_data[119:116];
                3:  tx_temp <= send_data[115:112];
                4:  tx_temp <= send_data[111:108]; 
                5:  tx_temp <= send_data[107:104]; 
                6:  tx_temp <= send_data[103:100]; 
                7:  tx_temp <= send_data[99:96]; 
                8:  tx_temp <= send_data[95:92]; 
                9:  tx_temp <= send_data[91:88];
                10: tx_temp <= send_data[87:84];
                11: tx_temp <= send_data[83:80];
                12: tx_temp <= send_data[79:76];
                13: tx_temp <= send_data[75:72];
                14: tx_temp <= send_data[71:68]; 
                15: tx_temp <= send_data[67:64];
                    
                16: tx_temp <= send_data[63:60];
                17: tx_temp <= send_data[59:56];
                18: tx_temp <= send_data[55:52];
                19: tx_temp <= send_data[51:48];
                20: tx_temp <= send_data[47:44]; 
                21: tx_temp <= send_data[43:40]; 
                22: tx_temp <= send_data[39:36]; 
                23: tx_temp <= send_data[35:32]; 
                24: tx_temp <= send_data[31:28]; 
                25: tx_temp <= send_data[27:24];
                26: tx_temp <= send_data[23:20];
                27: tx_temp <= send_data[19:16];
                28: tx_temp <= send_data[15:12];
                29: tx_temp <= send_data[11:8];
                30: tx_temp <= send_data[7:4]; 
                31: tx_temp <= send_data[3:0];
            default: tx_temp <= 0;
           endcase   
        end     
    
assign out_rx_counter= rx_counter;    
endmodule
