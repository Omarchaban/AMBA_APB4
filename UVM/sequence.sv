class Base_Sequence extends uvm_sequence #(sequence_item);
  


  `uvm_object_utils(Base_Sequence)
  
 
  
  
  
  
  function new (string name= "Base_Sequence");
  
  
       super.new(name);
		 
		 `uvm_info(get_type_name()," Inside constructor of Base_Sequence ",UVM_HIGH)

		 
  endfunction: new
  
  
  
  
  
  
  endclass: Base_Sequence
  
class Rst_Seq extends Base_Sequence;

`uvm_object_utils(Rst_Seq)
 function new (string name= "Base_Sequence");
  
  
       super.new(name);
		 
		 `uvm_info(get_type_name()," Inside constructor of Base_Sequence ",UVM_HIGH)

		 
  endfunction: new
  
task body();
      sequence_item reset_pkt;
     reset_pkt = sequence_item::type_id::create("reset_pkt");
	  
	  start_item(reset_pkt);
     
	  if(!(reset_pkt.randomize() with {PRESETn==0;Transfer ==0;}))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
     
		
     finish_item(reset_pkt);
  
  endtask: body

endclass


class random_write_read extends Base_Sequence;

	`uvm_object_utils(random_write_read)
	
	sequence_item pkt ;

	function new (string name= "Base_Sequence");
  
  
       super.new(name);
		 
		 `uvm_info(get_type_name()," Inside constructor of Base_Sequence ",UVM_HIGH)

		 
  	endfunction: new

	task body();
  
     		pkt = sequence_item::type_id::create("pkt");
	  	for(int i=0 ; i<200 ; i++) begin
		 start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==i; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15; }))
	       
			 `uvm_error(" Pstrbs "," the randomization faild ")
  
         	finish_item(pkt);

		end
		for(int i=0 ; i<200; i++) begin
		 start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==i; pwrite == 0; Transfer ==1; psel1 ==1; pstrb == 0;}))
	       
			 `uvm_error(" Pstrbs "," the randomization faild ")
  
    		 finish_item(pkt);
		end
	 	/* start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==550; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15; pwdata ==1000;}))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
  
    		 finish_item(pkt);
		@(negedge intf.PCLK);
		start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==650; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15; pwdata ==1200;}))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
  
    		 finish_item(pkt);
		start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==660; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15; pwdata ==1300; pwdata ==1300;}))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
  
    		 finish_item(pkt);
		start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==670; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15; pwdata ==1400;}))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
  
    		 finish_item(pkt);
		@(negedge intf.PCLK);
		start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==650; pwrite == 0; Transfer ==1; psel1 ==1; pstrb == 0;}))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
  
    		 finish_item(pkt);
  		start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==670; pwrite == 0; Transfer ==1; psel1 ==1; pstrb == 0;}))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
  
    		 finish_item(pkt);*/
  endtask: body
  

endclass : random_write_read


class multiple_writes extends Base_Sequence;

`uvm_object_utils(multiple_writes)
 function new (string name= "multiple_writes");
  
  
       super.new(name);
		 
		 `uvm_info(get_type_name()," Inside constructor of multiple_writes ",UVM_HIGH)

		 
  endfunction: new
  
  
  

task body();
      sequence_item pkt;
     pkt = sequence_item::type_id::create("multiple_write");
	  
	  start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==340; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15;pwdata ==0; }))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
  
         finish_item(pkt);
  	start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==340; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15; pwdata ==32'hffffffff;}))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
  
         finish_item(pkt);
	start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==340; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15; }))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
  
         finish_item(pkt);
	start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==340; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15; }))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
  
         finish_item(pkt);
	start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==340; pwrite == 0; Transfer ==1; psel1 ==1; pstrb == 0;}))
	       
			 `uvm_error(" Base_Sequence "," the randomization faild ")
  
    		 finish_item(pkt);
  endtask: body

endclass : multiple_writes


class max_min_address extends Base_Sequence;

`uvm_object_utils(max_min_address)
 function new (string name= "max_min_address");
  
  
       super.new(name);
		 
		 `uvm_info(get_type_name()," Inside constructor of max_min_address ",UVM_HIGH)

		 
  endfunction: new
  
  
  

task body();
      sequence_item pkt;
     pkt = sequence_item::type_id::create("pkt");
	  
	   start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==1023; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15; }))
	       
			 `uvm_error(" max_min_address "," the randomization faild ")
  
         finish_item(pkt);
	start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==0; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15; }))
	       
			 `uvm_error(" max_min_address "," the randomization faild ")
  
         finish_item(pkt);
  	start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==1023; pwrite == 0; Transfer ==1; psel1 ==1; pstrb == 0;}))
	       
			 `uvm_error(" max_min_address "," the randomization faild ")
  
    		 finish_item(pkt);
	start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==0; pwrite == 0; Transfer ==1; psel1 ==1; pstrb == 0;}))
	       
			 `uvm_error(" max_min_address "," the randomization faild ")
  
    		 finish_item(pkt);
  endtask: body

endclass :max_min_address

class Pstrbs extends Base_Sequence;

`uvm_object_utils(Pstrbs)
 function new (string name= "Pstrbs");
  
  
       super.new(name);
		 
		 `uvm_info(get_type_name()," Inside constructor of Pstrbs ",UVM_HIGH)

		 
  endfunction: new
  
  
  

task body();
      sequence_item pkt;
     pkt = sequence_item::type_id::create("pkt");
	  
	for(int i=0 ; i<16 ; i++) begin
		 start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==i+300; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == i; }))
	       
			 `uvm_error(" Pstrbs "," the randomization faild ")
  
         	finish_item(pkt);

	end
  	for(int i=0 ; i<16 ; i++) begin
		 start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==i+300; pwrite == 0; Transfer ==1; psel1 ==1; pstrb == 0;}))
	       
			 `uvm_error(" Pstrbs "," the randomization faild ")
  
    		 finish_item(pkt);
	end
  endtask: body

endclass : Pstrbs

class write_with_wait extends Base_Sequence;

`uvm_object_utils(write_with_wait)
 function new (string name= "write_with_wait");
  
  
       super.new(name);
		 
		 `uvm_info(get_type_name()," Inside constructor of write_with_wait ",UVM_HIGH)

		 
  endfunction: new
  
task body();
      sequence_item pkt;
     pkt = sequence_item::type_id::create("pkt");
	  
	 start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==1000; pwrite == 1; Transfer ==1; psel1 ==0;pstrb == 15;  pwdata ==1300;}))
	       
			 `uvm_error(" write_with_wait "," the randomization faild ")
  
         	finish_item(pkt);
  	start_item(pkt);
     		
		  if(!(pkt.randomize() with {PRESETn==1;paddr==1000; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15;  pwdata ==1300;}))
	       
			 `uvm_error(" write_with_wait "," the randomization faild ")
  
         	finish_item(pkt);
	 start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==1000; pwrite == 0; Transfer ==1; psel1 ==1; pstrb == 0;}))
	       
			 `uvm_error(" write_with_wait "," the randomization faild ")
  
    		 finish_item(pkt);
  endtask: body

endclass : write_with_wait


class read_with_wait extends Base_Sequence;

`uvm_object_utils(read_with_wait)
 function new (string name= "read_with_wait");
  
  
       super.new(name);
		 
		 `uvm_info(get_type_name()," Inside constructor of write_with_wait ",UVM_HIGH)

		 
  endfunction: new
  
task body();
      sequence_item pkt;
     pkt = sequence_item::type_id::create("pkt");
	  
	 
  	start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==1000; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15; }))
	       
			 `uvm_error(" write_with_wait "," the randomization faild ")
  
         	finish_item(pkt);
	 start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==1000; pwrite == 0; Transfer ==1; psel1 ==0; pstrb == 0;}))
	       
			 `uvm_error(" write_with_wait "," the randomization faild ")
  
    		 finish_item(pkt);
	start_item(pkt);
     
		  if(!(pkt.randomize() with {PRESETn==1;paddr==1000; pwrite == 0; Transfer ==1; psel1 ==1; pstrb == 0;}))
	       
			 `uvm_error(" write_with_wait "," the randomization faild ")
  
    		 finish_item(pkt);
  endtask: body

endclass : read_with_wait

class addr_err_Seq extends Base_Sequence;

`uvm_object_utils(addr_err_Seq)
 function new (string name= "addr_err_Seq");
  
  
       super.new(name);
		 
		 `uvm_info(get_type_name()," Inside constructor of addr_err_Seq ",UVM_HIGH)

		 
  endfunction: new
  
task body();
      sequence_item pkt;
     pkt = sequence_item::type_id::create("pkt");
	  
	  start_item(pkt);
     		
		  if(!(pkt.randomize() with {PRESETn==1;paddr==3000; pwrite == 1; Transfer ==1; psel1 ==1;pstrb == 15;  pwdata ==1300;}))
	       
			 `uvm_error(" addr_err_Seq "," the randomization faild ")
  
         	finish_item(pkt);
  
  endtask: body

endclass

class Pstrb_err_Seq extends Base_Sequence;

`uvm_object_utils(Pstrb_err_Seq)
 function new (string name= "Pstrb_err_Seq");
  
  
       super.new(name);
		 
		 `uvm_info(get_type_name()," Inside constructor of Pstrb_err_Seq ",UVM_HIGH)

		 
  endfunction: new
  
task body();
      sequence_item pkt;
     pkt = sequence_item::type_id::create("pkt");
	  
	  start_item(pkt);
     		
		  if(!(pkt.randomize() with {PRESETn==1;paddr==200; pwrite == 0; Transfer ==1; psel1 ==1;pstrb == 15;  }))
	       
			 `uvm_error(" write_with_wait "," the randomization faild ")
  
         	finish_item(pkt);
  
  endtask: body

endclass