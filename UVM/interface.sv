interface APB_interface(input logic PCLK);
   

    bit PRESETn;
    //user Signals
    logic [31:0] paddr;
    logic psel1;
    logic [3 :0] pstrb;
    logic Transfer;

    logic pwrite;
    logic [31:0] pwdata;
    logic [31:0] PRDATA ;

	//
		logic PSLVERR;
		logic PREADY;
  		logic PWRITE;
  
endinterface
