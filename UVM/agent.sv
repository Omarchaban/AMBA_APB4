class agent extends uvm_agent;

  `uvm_component_utils(agent);
  
  driver Driver;
  monitor Monitor;
  sequencer	Sequencer;
  
  
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
    
    `uvm_info("agent class","inside constructor of agent class",UVM_LOW);
  endfunction
  
  function void build_phase (uvm_phase phase);
  
    super.build_phase(phase);
    
    Driver = driver::type_id::create("driver",this);
    Monitor = monitor::type_id::create("monitor",this);
    Sequencer = sequencer::type_id::create("sequencer",this);
      `uvm_info("agent class","inside build phase of agent class",UVM_LOW);

  
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("agent class","inside connect phase of agent class",UVM_LOW);
    Driver.seq_item_port.connect(Sequencer.seq_item_export);
    
    
  endfunction

	 task run_phase(uvm_phase phase);

      super.run_phase(phase);
		
     `uvm_info("agent class"," Inside run_phase of agent Class ",UVM_LOW)

	  
endtask: run_phase 
 


endclass
