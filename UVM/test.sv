
class test extends uvm_test;
  `uvm_component_utils(test);

env Env;
  
  Rst_Seq rst_pkt; 
  random_write_read random;
  write_with_wait write_w8 ;
  multiple_writes  multiple_write;
  max_min_address max_min_addr;
  Pstrbs Pstrb;
  Pstrb_err_Seq Pstrb_err;
  addr_err_Seq addr_err;
  read_with_wait read_w8;
  function new(string name = "ALU_test", uvm_component parent);
    super.new(name,parent);
    
    `uvm_info("test class","inside constructor of test class",UVM_LOW);
    
  
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
   
    Env = env::type_id::create("env",this);
    
    
  endfunction
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    phase.raise_objection(this);
    
    
    rst_pkt= Rst_Seq::type_id::create("rst_pkt");
    random = random_write_read::type_id::create("random");
    write_w8 = write_with_wait::type_id::create("write_w8");
    multiple_write = multiple_writes::type_id::create("multiple_write"); 
    max_min_addr = max_min_address::type_id::create("max_min_addr");  
    Pstrb = Pstrbs::type_id::create("Pstrb");  
	Pstrb_err = Pstrb_err_Seq::type_id::create("Pstrb_err");
   addr_err = addr_err_Seq::type_id::create("Pstrb_err");
                read_w8= read_with_wait::type_id::create("read_w8");
    rst_pkt.start(Env.Agent.Sequencer);
    
    
    
	 random.start(Env.Agent.Sequencer);
        #10;
	
  	write_w8.start(Env.Agent.Sequencer);
	#10;	
	
	 Pstrb_err.start(Env.Agent.Sequencer);
	#10;

	multiple_write.start(Env.Agent.Sequencer);
         #10;
	addr_err.start(Env.Agent.Sequencer);
	#10;
	max_min_addr.start(Env.Agent.Sequencer);
	#10;
	read_w8.start(Env.Agent.Sequencer);
         #10;
	Pstrb.start(Env.Agent.Sequencer);
    phase.drop_objection(this);
  endtask
  
  

endclass
