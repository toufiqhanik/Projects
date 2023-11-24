module fpga2_aes (input clk, input rst,  input[7:0] data_in, input clk_in, output [7:0] data_out, output clk_out);

    
    reg [3:0] state;
    parameter IDLE = 4'd0, SEND_To_FPGA1 = 4'd1, RECEIVE_From_FPGA1 = 4'd2,  AES_STRT=4'd3, AES= 4'd4, FINISH = 4'd5;
    reg send_cmd;
    
    reg [127:0] fpga1_data_send;
    
    reg send_fpga;
    wire [127:0] fpga1_data_receive;
    wire fpga1_data_receive_ok;
    //AES
    reg [127:0] plaintext;
    reg aKrdy, aDrdy, aes_enbl, aRSt,aDvld_temp;
    wire aBSY, aKvld, aDvld;
    wire [127:0] ciphertext;
    wire clk_in_filter;
    wire [7:0] data_in_filter;
    
    Fpga_Connection uut2 (.clk(clk) , .rst(rst), .cmd_send(send_fpga), .tx_data(fpga1_data_send), .data_in(data_in_filter), .clk_in(clk_in_filter), .clk_out(clk_out), .data_out(data_out), .rx_data(fpga1_data_receive), .receive_ok(fpga1_data_receive_ok));
    small_filter #(.wd(5), .n(31), .bound(20))  uut1(.clk(clk), .data_in(clk_in), .data_out(clk_in_filter), .data_edge());
    
    small_filter #(.wd(5), .n(31), .bound(20))  uut3(.clk(clk), .data_in(data_in[0]), .data_out(data_in_filter[0]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut4(.clk(clk), .data_in(data_in[1]), .data_out(data_in_filter[1]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut5(.clk(clk), .data_in(data_in[2]), .data_out(data_in_filter[2]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut6(.clk(clk), .data_in(data_in[3]), .data_out(data_in_filter[3]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut7(.clk(clk), .data_in(data_in[4]), .data_out(data_in_filter[4]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut8(.clk(clk), .data_in(data_in[5]), .data_out(data_in_filter[5]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut9(.clk(clk), .data_in(data_in[6]), .data_out(data_in_filter[6]), .data_edge());
    small_filter #(.wd(5), .n(31), .bound(20))  uut10(.clk(clk), .data_in(data_in[7]), .data_out(data_in_filter[7]), .data_edge());
    
    AES_Comp aesc1 (.Kin(128'h37d0d724d00a1248db0fead349f1c09b), .Din(plaintext), .Dout(ciphertext), .Krdy(aKrdy), .Drdy(aDrdy), .EncDec(1'b0), .RSTn(aRSt), .EN(aes_enbl), .CLK(clk), .BSY(aBSY), .Kvld(aKvld), .Dvld(aDvld));
    
    
    always @(posedge clk)
    begin
        if(rst == 1'b1)
        begin
            state <= IDLE;
            send_fpga <= 1'b0;
            fpga1_data_send <= 128'd0;
            
            plaintext <=0;
            aes_enbl <= 1'b1;
            aKrdy<= 0;
            aDrdy<= 0;
            aDvld_temp <= 0;
            aRSt <=0;
            
          end 
        else
        begin
        case(state)
            IDLE:
            begin
                send_fpga <= 1'b0;
                fpga1_data_send <= 128'd0;
                
                plaintext <=0;
                aes_enbl <= 1'b1;
                aKrdy<= 0;
                aDrdy<= 0;
                aDvld_temp <= 0;
                aRSt <=0;
               state <= RECEIVE_From_FPGA1;
               send_fpga <= 1'b0;
            end 
            
            RECEIVE_From_FPGA1:
            begin
                if(fpga1_data_receive_ok == 1'b1)
                begin
                    plaintext <= fpga1_data_receive;
                    state <= AES_STRT;
                    aRSt <=1'b1;                                      
                    aKrdy <= 1'b1;
                    aDrdy <= 1'b0;
                end
            end
            
            AES_STRT:
            begin
                     aKrdy <= 1'b0;
                     aDrdy <= 1'b1;
                     state <= AES;
                    end
                    
             AES:
             begin 
                if (aDvld == 1'b1) begin     
                    fpga1_data_send <= ciphertext;  
                    
                    aes_enbl <= 1'b0;
                    state <=SEND_To_FPGA1;
                    end
                 else begin 
                    state <= state;                             
                    end 
             end
            
            
            
            SEND_To_FPGA1:
            begin
               send_fpga <= 1'b1; 
               state <= FINISH;
            end
            
            FINISH:
            begin
                send_fpga <= 1'b0; 
                state<=IDLE;
            end
        endcase   
    end
end
endmodule