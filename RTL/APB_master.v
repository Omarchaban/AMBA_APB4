`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2025 04:17:01 PM
// Design Name: 
// Module Name: APB_master
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


module APB_master
    #(
        ADDR_WIDTH = 32,
        DATA_WIDTH = 32
        )
    (
    //user Signals
    input [ADDR_WIDTH-1:0] paddr,
    input psel1,
    input [(DATA_WIDTH/8) -1 :0] pstrb,
    input Transfer,

    input pwrite,
    input [DATA_WIDTH-1:0] pwdata,
    //Standard Signals
    input PCLK,
    input PRESETn,
    input PREADY,
    input [DATA_WIDTH-1:0] PRDATA,
    output reg [ADDR_WIDTH-1:0] PADDR,
    output reg [2:0] PPROT,
    output reg PSEL1,
    output reg PENABLE,
    output reg PWRITE,
    output reg [DATA_WIDTH-1:0] PWDATA,
    output reg [(DATA_WIDTH/8) -1 :0] PSTRB
    );
    
    parameter IDLE =0 , SETUP =1 , ACCESS = 2;
    
    reg [1:0] current_state;
    reg [1:0] next_state;
    
    always @(posedge PCLK or negedge PRESETn) begin
        if(!PRESETn) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    
    end
    
    always @(*) begin
    
        case (current_state) 
            IDLE: begin
                PADDR=0;
                PPROT =0;
                PSEL1=0;
                PENABLE=0;
                PWRITE=0;
                PWDATA=0;
                PSTRB=0;
                if(Transfer) begin
                    next_state = SETUP;
                end 
                else begin
                    next_state= IDLE;
                end   
            end
            SETUP: begin
                PADDR=paddr;
                
                PSEL1=psel1;
                PENABLE=0;
                PWRITE=pwrite;
                PWDATA=pwdata;
                PSTRB=pstrb;
                next_state = ACCESS;
            end
            ACCESS: begin
                PADDR=PADDR;
                PSTRB=pstrb;
                PSEL1=PSEL1;
                PENABLE=1;
                PWRITE=PWRITE;
                PWDATA=PWDATA;
                if(!PREADY) 
                    next_state =ACCESS;
                else if(PREADY && Transfer)
                    next_state =SETUP;
                else if (PREADY && !Transfer)
                     next_state= IDLE;
            end
            default: begin
                PADDR=0;
                PPROT =0;
                PSEL1=0;
                PENABLE=0;
                PWRITE=0;
                PWDATA=0;
                PSTRB=0;
                next_state= IDLE;
            end
        endcase
    end
    
    
endmodule
