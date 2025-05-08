
`timescale 1ns/1ps

  

module uvm_top();
  
 import uvm_pkg::*;
`include "uvm_macros.svh"

 `include"interface.sv"

`include"sequence_item.sv"

`include"sequence.sv"

`include"sequencer.sv"
`include"driver.sv"

`include"monitor.sv"

`include"agent.sv"
`include"scoreboard.sv"
`include"coverage.sv"
`include"env.sv"

`include"test.sv"




bit PCLK;

APB_interface intf(PCLK);


APB_top dut (.PCLK(intf.PCLK),
	     .PRESETn(intf.PRESETn),
	    .paddr(intf.paddr),
	    .psel1(intf.psel1),
	    .pstrb(intf.pstrb),
	    .Transfer(intf.Transfer),
	    .pwrite(intf.pwrite),
	    .pwdata(intf.pwdata),
	    .PRDATA(intf.PRDATA),
	    .PREADY(intf.PREADY),
	   .PWRITE(intf.PWRITE),

		.PSLVERR(intf.PSLVERR)
);

 
initial begin
	PCLK=0;
  forever begin
  	PCLK=~PCLK; #5;
  end
end
  
  initial begin 

uvm_config_db #(virtual APB_interface)::set(null, "*", "intf", intf);
    run_test("test");

end

/*initial begin 
  
  #1000;
  
  $finish();
  
end*/

property Pstrb_Err;


   @(posedge PCLK) (intf.pstrb != 0 && !intf.pwrite) |-> ##[0:1] intf.PSLVERR;


endproperty


assert property(Pstrb_Err);
cover property (Pstrb_Err);

property Addr_Err;


   @(posedge PCLK) (intf.paddr >1023 ) |-> ##[0:1] intf.PSLVERR;


endproperty


assert property(Addr_Err);
cover property (Addr_Err);


//Assertion to check that the address is stable in one normal transaction for 2 cycles
property Addr_Check;


   @(posedge PCLK) (intf.paddr != $past(intf.paddr) ) |=> (intf.paddr == $past(intf.paddr) );


endproperty


assert property(Addr_Check);
cover property (Addr_Check);

//Assertion to check that the address is stable in one normal transaction for 2 cycles
property Data_Check;


   @(posedge PCLK) (intf.pwdata != $past(intf.pwdata) ) |=> (intf.pwdata == $past(intf.pwdata) );


endproperty


assert property(Data_Check);
cover property (Data_Check);

//Assertion to check that the address and Data are stable in extended transactions while write
property Ready_Check_While_Write;


   @(posedge PCLK) (intf.PREADY == 0 && $past(intf.PREADY) == 0 && intf.pwrite) |=> (intf.pwdata == $past(intf.pwdata) &&intf.pwdata == $past(intf.pwdata) );


endproperty


assert property(Ready_Check_While_Write);
cover property (Ready_Check_While_Write);

//Assertion to check that the address and Data are stable in extended transactions while Read
property Ready_Check_While_Read;


   @(posedge PCLK) (intf.PREADY == 0 && $past(intf.PREADY) == 0 && !intf.pwrite) |=> (intf.pwdata == $past(intf.pwdata) );


endproperty


assert property(Ready_Check_While_Read);
cover property (Ready_Check_While_Read);







endmodule