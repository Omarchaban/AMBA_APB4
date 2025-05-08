
class sequencer extends uvm_sequencer #(sequence_item);

  `uvm_component_utils(sequencer);
  
  
  function new(string name ="sequencer", uvm_component parent);
    super.new(name,parent);
    
    `uvm_info("sequencer class","inside constructor of sequencer class",UVM_LOW);
    
  
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    `uvm_info("sequencer class","inside build phase of sequencer class",UVM_LOW);

    
    
  endfunction
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("sequencer class","inside connect phase of sequencer class",UVM_LOW);

  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("sequencer class","inside run phase of sequencer class",UVM_LOW);
  
  
  endtask
  
  

endclass
