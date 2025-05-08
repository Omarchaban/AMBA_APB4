
class sequence_item extends uvm_sequence_item;
  `uvm_object_utils(sequence_item);
  


    rand bit PRESETn;
    //user Signals
   rand logic [32-1:0] paddr;
     rand logic psel1;
     rand logic [(32/8) -1 :0] pstrb;
     rand logic Transfer;

     rand logic pwrite;
     rand logic [32-1:0] pwdata;
      logic [31:0] PRDATA ;

	//
		  logic PSLVERR;
		  logic PREADY;
  		  logic PWRITE;
  function new(string name = "sequence_item"); 
    super.new(name);
    `uvm_info(" sequence_item "," Inside constructor of sequence_item class ",UVM_HIGH)
  endfunction
  
// constraint address {paddr < 1024;}
  
  
endclass
