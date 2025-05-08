class driver extends uvm_driver  #(sequence_item);
  `uvm_component_utils(driver);
    
  	sequence_item item;
    virtual APB_interface intf;

  function new(string name, uvm_component parent);
    super.new(name,parent);
    
   
  
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
item = sequence_item::type_id::create("item");
    
  endfunction
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    
   if(!(uvm_config_db #(virtual APB_interface) ::get(this,"*","intf",intf)))
       `uvm_error("driver class","failed to get virtual interface");
    
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   
    `uvm_info("driver class","inside run phase of driver class",UVM_LOW);
    forever begin
      item = sequence_item::type_id::create("item");

      seq_item_port.get_next_item(item);

      drive(item);

      seq_item_port.item_done();
    end
  endtask

       task drive(sequence_item item);
	if(!intf.PRESETn) begin
		 @(posedge intf.PCLK);
		intf.PRESETn <= item.PRESETn;
	end
	else begin
		//if(intf.PREADY) begin
        		 @(posedge intf.PCLK);
       	 		 intf.PRESETn <= item.PRESETn;
        		 intf.paddr <= item.paddr;
        		 intf.psel1 <= item.psel1;
        		 intf.pstrb <= item.pstrb;
        		 intf.Transfer <= item.Transfer;
       	 
			intf.pwrite <= item.pwrite;
			intf.pwdata <= item.pwdata;
		
			@(posedge intf.PCLK);
			
				wait(!intf.PREADY);
				
		//end
		//else begin
		//	@(posedge intf.PCLK);
		//end
		//wait(!intf.PREADY);
	end
       endtask
  

endclass
