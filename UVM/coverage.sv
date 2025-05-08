
class coverage extends uvm_subscriber #(sequence_item);
`uvm_component_utils(coverage)


  uvm_analysis_imp#(sequence_item, coverage) coverage_imp;
  
  sequence_item pkt_item;

//Define the coverage group and bins
covergroup cg;
//Address range bins
coverpoint pkt_item.paddr{
      bins addr_min = {0};
	  bins addr_max = {1023};
	 bins error_addr = {[1024:$]};
	  }

coverpoint pkt_item.pwdata{
     bins wdata_min = {0};
	  bins wdata_max = {32'hFFFFFFFF};
	 
	 }

coverpoint pkt_item.PWRITE{
      bins write = {1};
	  bins read  = {0};
	  }

//Error condition bins
coverpoint pkt_item.PSLVERR{
     bins pslverr_assert = {1};
	 bins pslverr_not_assert = {0};
	 }
//PSTRB bins 

coverpoint pkt_item.pstrb{
     bins pstrbs[] = {[0:15]};
	 
	 }
//Ready condition bins
coverpoint pkt_item.PREADY{
     bins pready_assert = {1};
	 bins pready_not_assert = {0};
	 }


//Psel and Penable condition bins


endgroup

  
  function new(string name ="apb_coverage_model", uvm_component parent);
  super.new(name,parent);
  cg =new;
  endfunction

  //Build Phase
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    coverage_imp = new("coverage_imp", this);
    
  endfunction

 

  virtual function void write (sequence_item t);
  pkt_item = sequence_item::type_id::create("pkt_item");
	 $cast(pkt_item,t);
	cg.sample();
endfunction


  endclass