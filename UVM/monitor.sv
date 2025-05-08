
class monitor extends uvm_monitor;

  `uvm_component_utils(monitor);
  
  
  sequence_item item;
  virtual APB_interface intf;
  
  uvm_analysis_port #(sequence_item) monitor_port;
  
  
  function new(string name , uvm_component parent);
    super.new(name,parent);
    
    `uvm_info("monitor class","inside constructor of monitor class",UVM_LOW);
    
  
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    `uvm_info("monitor class","inside build phase of monitor class",UVM_LOW);
	monitor_port=new("monitor_port",this);
    
    
  endfunction
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("sequencer class","inside connect phase of sequencer class",UVM_LOW);
	if(!(uvm_config_db #(virtual APB_interface) ::get(this,"*","intf",intf)))
       `uvm_error("monitor class","failed to get virtual interface");
  endfunction

  task run_phase(uvm_phase phase);
    //super.run_phase(phase);
    item = sequence_item::type_id::create ("item");
    `uvm_info("monitor class","inside run phase of monitor class",UVM_LOW);
    forever begin
	
      	
	Monitor (item);
        monitor_port.write(item);
   
	 end
  
  endtask
  
     task Monitor (sequence_item item) ;

	@(posedge intf.PCLK);
         	item.PRDATA = intf.PRDATA;
         	item.PSLVERR = intf.PSLVERR;
         	item.PREADY = intf.PREADY;
		item.PWRITE = intf.PWRITE;
		item.paddr = intf.paddr;
		item.pwdata  = intf.pwdata;
		item.pstrb = intf.pstrb;
        @(posedge intf.PCLK); 

	endtask
endclass
