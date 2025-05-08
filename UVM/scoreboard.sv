
class scoreboard extends uvm_scoreboard;

  `uvm_component_utils(scoreboard);
  sequence_item items[$];
  
  sequence_item trs;

  
  uvm_analysis_imp #(sequence_item,scoreboard) score_imp;
  reg [32-1:0] Cache [1024-1:0];

  logic [31:0] rdata,temp_data;
  function new(string name , uvm_component parent);
    super.new(name,parent);
    
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
     score_imp = new("score_imp",this);
    
    
  endfunction
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
  
  endfunction

 task run_phase(uvm_phase phase);
    //super.run_phase(phase);

		
		forever begin
		
		wait(items.size());
		
		trs = items.pop_front();
		if(trs.PWRITE) begin
			case (trs.pstrb)
                		 4'b0001: Cache[trs.paddr] <= {{24{trs.pwdata[7]}}, trs.pwdata[7:0]}; // Store the least significant byte (sb)
               			 4'b0010: Cache[trs.paddr] <= {{24{trs.pwdata[15]}}, trs.pwdata[15:8], 8'h00}; // Store the second byte with zeroes in the least 8 bits
                		 4'b0011: Cache[trs.paddr] <= {{16{trs.pwdata[15]}}, trs.pwdata[15:0]}; // Store the least significant half-word (sh)
                		 4'b0100: Cache[trs.paddr] <= {{24{trs.pwdata[23]}}, trs.pwdata[23:16], 8'h00}; // Store the third byte with zeroes in the least 8 bits
                		 4'b0101: Cache[trs.paddr] <= {{16{trs.pwdata[23]}}, trs.pwdata[23:16], 8'h00, trs.pwdata[7:0]}; // Store the third and least significant bytes with zeroes
                		 4'b0110: Cache[trs.paddr] <= {{8{trs.pwdata[23]}}, trs.pwdata[23:8], 8'h00}; // Store the second and third bytes with zeroes in the least 8 bits
                		 4'b0111: Cache[trs.paddr] <= {{8{trs.pwdata[23]}}, trs.pwdata[23:0]}; // Store the least significant three bytes (sh)
                		 4'b1000: Cache[trs.paddr] <= {trs.pwdata[31:24], 24'h000000}; // Store the most significant byte without sign extension
                		 4'b1001: Cache[trs.paddr] <= {trs.pwdata[31:24], 16'h0000, trs.pwdata[7:0]}; // Store the most and least significant bytes without sign extension
               			 4'b1010: Cache[trs.paddr] <= {trs.pwdata[31:23], 8'h00, trs.pwdata[15:8], 8'h00}; // Store the most significant half-word with zeroes in the least significant byte if PSTRB[0] == 0
               			 4'b1011: Cache[trs.paddr] <= {trs.pwdata[31:23], 8'h00, trs.pwdata[15:0]}; // Store the most significant half-word and the least significant byte, zeroing the middle byte if necessary
               			 4'b1100: Cache[trs.paddr] <= {trs.pwdata[31:16], 16'h0000}; // Store the most significant and second bytes without sign extension
               			 4'b1101: Cache[trs.paddr] <= {trs.pwdata[31:16], 8'h00, trs.pwdata[7:0]}; // Store the most significant three bytes with zeroes in the least 8 bits
               			 4'b1110: Cache[trs.paddr] <= {trs.pwdata[31:8], 8'h00}; // Store the most significant three bytes with zeroes in the least 8 bits
               			 4'b1111: Cache[trs.paddr] <= trs.pwdata[31:0]; // Store the full word without sign extension
               			 default: Cache[trs.paddr] <= 32'h00000000; // Default case to handle invalid PSTRB values
          		  endcase
			//Cache[trs.paddr] = temp_data;
			//$display("trs.pstrb = %0d ,temp_data = %0d ,trs.pwdata = %0d  ", trs.pstrb,,trs.pwdata);
		end
		else begin
			if(Cache[trs.paddr] != trs.PRDATA) begin
				`uvm_error(" Scoreboard "," REEEAD ERROR ")
				//$display("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
			end
			else begin
				 `uvm_info(get_type_name()," REEEEAD PASSSSS ",UVM_HIGH)
				//$display("Cache[trs.paddr] = %0d , trs.PRDATA = %0d" , Cache[trs.paddr],trs.PRDATA);
			end
		end
		
	end
 endtask



  function write(sequence_item item);
    items.push_back(item);
	//$display("SSSSSSSSSSSSSSSSSSSSSFSFFFFFFFFFFFFFFFFFFFFFFFFFFF");
  endfunction

function strb(input [(32/8) -1 :0] pstrb, input [31:0] pwdata );
        logic [31:0] temp_data;
	begin
            case (pstrb)
                4'b0001:temp_data = {{24{pwdata[7]}}, pwdata[7:0]}; // Store the least significant byte (sb)
                4'b0010: temp_data= {{24{pwdata[15]}}, pwdata[15:8], 8'h00}; // Store the second byte with zeroes in the least 8 bits
                4'b0011: temp_data= {{16{pwdata[15]}}, pwdata[15:0]}; // Store the least significant half-word (sh)
                4'b0100:temp_data = {{24{pwdata[23]}}, pwdata[23:16], 8'h00}; // Store the third byte with zeroes in the least 8 bits
                4'b0101: temp_data= {{16{pwdata[23]}}, pwdata[23:16], 8'h00, pwdata[7:0]}; // Store the third and least significant bytes with zeroes
                4'b0110: temp_data= {{8{pwdata[23]}}, pwdata[23:8], 8'h00}; // Store the second and third bytes with zeroes in the least 8 bits
                4'b0111: temp_data= {{8{pwdata[23]}}, pwdata[23:0]}; // Store the least significant three bytes (sh)
                4'b1000: temp_data= {pwdata[31:24], 24'h000000}; // Store the most significant byte without sign extension
                4'b1001: temp_data= {pwdata[31:24], 16'h0000, pwdata[7:0]}; // Store the most and least significant bytes without sign extension
                4'b1010:temp_data= {pwdata[31:23], 8'h00, pwdata[15:8], 8'h00}; // Store the most significant half-word with zeroes in the least significant byte if PSTRB[0] == 0
                4'b1011: temp_data= {pwdata[31:23], 8'h00, pwdata[15:0]}; // Store the most significant half-word and the least significant byte, zeroing the middle byte if necessary
                4'b1100: temp_data= {pwdata[31:16], 16'h0000}; // Store the most significant and second bytes without sign extension
                4'b1101: temp_data= {pwdata[31:16], 8'h00, pwdata[7:0]}; // Store the most significant three bytes with zeroes in the least 8 bits
                4'b1110: temp_data= {pwdata[31:8], 8'h00}; // Store the most significant three bytes with zeroes in the least 8 bits
                4'b1111: temp_data= pwdata[31:0]; // Store the full word without sign extension
                default: temp_data= 32'h00000000; // Default case to handle invalid PSTRB values
            endcase
        
        end
    	return temp_data;
    endfunction

endclass