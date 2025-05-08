
class env extends uvm_env;

  `uvm_component_utils(env);
  agent Agent;
  scoreboard Scoreboard;
  coverage Coverage;
  
  
   function new(string name = "ALU_env", uvm_component parent);
    super.new(name,parent);
    
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    
    Agent = agent::type_id::create("agent",this);
    Scoreboard =scoreboard::type_id::create("scoreboard",this);
    Coverage =coverage::type_id::create("coverage",this);
    
  endfunction
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    
    Agent.Monitor.monitor_port.connect(Scoreboard.score_imp);
    Agent.Monitor.monitor_port.connect(Coverage.coverage_imp);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   
  endtask
endclass
