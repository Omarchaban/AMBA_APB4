`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2025 05:30:06 PM
// Design Name: 
// Module Name: APB_top
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


module APB_top#(
        ADDR_WIDTH = 32,
        DATA_WIDTH = 32
        )
    (
    input PCLK,
    input PRESETn,
    //user Signals
    input [ADDR_WIDTH-1:0] paddr,
    input psel1,
    input [(DATA_WIDTH/8) -1 :0] pstrb,
    input Transfer,

    input pwrite,
    input [DATA_WIDTH-1:0] pwdata,
    output [31:0] PRDATA 
    
    );
    wire PSEL , PENABLE , PWRITE ;
wire [31:0] PADDR , PWDATA ;
wire [3:0] PSTRB ;
wire [2:0] PPROT ;
wire PREADY , PSLVERR ;

    APB_master Master (
    .PCLK (PCLK),
    .PRESETn(PRESETn),
    .pwrite(pwrite),
    .paddr(paddr),
    .pwdata(pwdata),
    .pstrb(pstrb),
    
    .Transfer(Transfer),
    .psel1(psel1),
    .PRDATA(PRDATA),
    .PENABLE(PENABLE),
    .PWRITE(PWRITE),
    .PADDR(PADDR),
    .PSEL1(PSEL),
    .PWDATA(PWDATA),
    .PSTRB(PSTRB),
    .PPROT(PPROT),
    .PREADY(PREADY)
   
);
    
    
    APB_Slave Slave (
    .PCLK(PCLK),
    .PRESETn(PRESETn),
    .PSEL(PSEL),
    .PENABLE(PENABLE),
    .PWRITE(PWRITE),
    .PADDR(PADDR),
    .PWDATA(PWDATA),
    .PSTRB(PSTRB),
    .PPROT(PPROT),
    .PREADY(PREADY),
    .PSLVERR(PSLVERR),
    .PRDATA(PRDATA)
);
endmodule
