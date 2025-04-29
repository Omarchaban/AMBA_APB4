`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2025 05:39:36 PM
// Design Name: 
// Module Name: APB_tb
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


module APB_tb(

    );
    
    reg PCLK;
    reg PRESETn;
    //user Signals
    reg [32-1:0] paddr;
    reg psel1;
    reg [(32/8) -1 :0] pstrb;
    reg Transfer;

    reg pwrite;
    reg [32-1:0] pwdata;
    wire [31:0] PRDATA ;
    
    reg [32-1:0] Cache [1024-1:0];
    
    APB_top top (PCLK,PRESETn,paddr,psel1,pstrb,Transfer,pwrite,pwdata,PRDATA);
    
    
    
    always begin
        PCLK = ~PCLK ; #5;
    end
    
    initial begin
        PCLK = 0;
        PRESETn = 1; #5;
        PRESETn = 0; #10;
        PRESETn =1;
         simple_write(1,50,30);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(2,51,31);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(3,52,32);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(4,53,33);
         @(posedge PCLK);
         @(posedge PCLK);
          simple_write(5,54,34);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(6,55,35);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(7,56,36);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(8,57,37);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(9,58,38);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(10,59,39);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(11,60,40);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(12,61,41);
         @(posedge PCLK);
         @(posedge PCLK);
          simple_write(13,62,42);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(14,63,43);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(15,64,44);
         @(posedge PCLK);
         @(posedge PCLK);
          write_wait(70 , 80);
          @(posedge PCLK);
          @(posedge PCLK);
          simple_write(15,120,66);
         @(posedge PCLK);
         @(posedge PCLK);
         simple_write(14,888,632);
         @(posedge PCLK);
         @(posedge PCLK);
         write_wait(1000 , 540);
          @(posedge PCLK);
          @(posedge PCLK);
          write_wait(750 , 643);
          @(posedge PCLK);
          @(posedge PCLK);
        read(50);
        read(51);
        read(52);
        read(53);
        read(120);
        read(54);
        read(55);
        read(56);
        read(57);
        read(888);
        read(58);
        read(59);
        read(60);
        read(61);
        read(62);
        read(63);
        read(64);
        read(70);
        read(1000);
        read(750);
        err_inject();
        #50;
        $finish;
    end
    
    task simple_write(input [(32/8) -1 :0] trb,input [31:0] addr, input [31:0] data);
        begin
              pstrb = trb;
              psel1 =1; 
              Transfer = 1;
              paddr = addr;
              pwrite =1; 
              pwdata = data;
              strb(pstrb , paddr , pwdata);
             // Cache[paddr] = pwdata;
        end  
    endtask
    task write_wait(input [31:0] addr, input [31:0] data);
        begin
              pstrb = 4'b1111;
              psel1 =1; 
              Transfer = 1;
              paddr = addr;
              pwrite =1; 
              pwdata = data;
              @(posedge PCLK);
              psel1 =0;
              @(posedge PCLK);
              psel1 =1;
              Cache[paddr] = pwdata;
        end
    endtask
    task read(input [31:0] addr);
        begin
             paddr = addr;
             pwrite =0;
             pstrb = 0;
             @(posedge PCLK);
             @(posedge PCLK);
             //#21;
            
             if(Cache[paddr] == PRDATA) begin
                $display("SUCCESSSSS");
             end
             else begin
                $display("FAAAIAIL at t= %0t prdata = %0d  , cache = %0d" , $time , PRDATA,Cache[paddr]);
             end
        end
    endtask
    task err_inject();
         begin
            paddr = 66;
             pwrite =0;
             pstrb = 1;
             @(posedge PCLK);
             #1;
             if(top.PSLVERR == 1) begin
                $display("Error inject pass");
             
             end
             else begin
                $display("Error inject fail t= %0t ,PSLVERR = %0d ",$time ,top.PSLVERR);
             end
        end
    endtask
    
    task strb(input [(32/8) -1 :0] pstrb,input [31:0] paddr, input [31:0] pwdata);
        begin
            case (pstrb)
                4'b0001: Cache[paddr] <= {{24{pwdata[7]}}, pwdata[7:0]}; // Store the least significant byte (sb)
                4'b0010: Cache[paddr] <= {{24{pwdata[15]}}, pwdata[15:8], 8'h00}; // Store the second byte with zeroes in the least 8 bits
                4'b0011: Cache[paddr] <= {{16{pwdata[15]}}, pwdata[15:0]}; // Store the least significant half-word (sh)
                4'b0100: Cache[paddr] <= {{24{pwdata[23]}}, pwdata[23:16], 8'h00}; // Store the third byte with zeroes in the least 8 bits
                4'b0101: Cache[paddr] <= {{16{pwdata[23]}}, pwdata[23:16], 8'h00, pwdata[7:0]}; // Store the third and least significant bytes with zeroes
                4'b0110: Cache[paddr] <= {{8{pwdata[23]}}, pwdata[23:8], 8'h00}; // Store the second and third bytes with zeroes in the least 8 bits
                4'b0111: Cache[paddr] <= {{8{pwdata[23]}}, pwdata[23:0]}; // Store the least significant three bytes (sh)
                4'b1000: Cache[paddr] <= {pwdata[31:24], 24'h000000}; // Store the most significant byte without sign extension
                4'b1001: Cache[paddr] <= {pwdata[31:24], 16'h0000, pwdata[7:0]}; // Store the most and least significant bytes without sign extension
                4'b1010: Cache[paddr] <= {pwdata[31:23], 8'h00, pwdata[15:8], 8'h00}; // Store the most significant half-word with zeroes in the least significant byte if PSTRB[0] == 0
                4'b1011: Cache[paddr] <= {pwdata[31:23], 8'h00, pwdata[15:0]}; // Store the most significant half-word and the least significant byte, zeroing the middle byte if necessary
                4'b1100: Cache[paddr] <= {pwdata[31:16], 16'h0000}; // Store the most significant and second bytes without sign extension
                4'b1101: Cache[paddr] <= {pwdata[31:16], 8'h00, pwdata[7:0]}; // Store the most significant three bytes with zeroes in the least 8 bits
                4'b1110: Cache[paddr] <= {pwdata[31:8], 8'h00}; // Store the most significant three bytes with zeroes in the least 8 bits
                4'b1111: Cache[paddr] <= pwdata[31:0]; // Store the full word without sign extension
                default: Cache[paddr] <= 32'h00000000; // Default case to handle invalid PSTRB values
            endcase
        
        end
    
    endtask
    
endmodule
