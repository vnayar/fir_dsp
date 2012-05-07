/**
 * Program Sequencer.
 * This module increments the program counter, and also applies loop
 * logic without the need for separate jump instructions every iteration.
 * Loop counters are stored internally and are initialized with a special
 * instruction once per loop.
 */
module prog_seq
  (
   input 			 clk, reset,
   input 			 we,    // Write-enable for loop registers
   input [7:0] 		 iter, size,
   output reg [15:0] addr);

   reg [3:0] 		 stack_index;
   reg [15:0] 		 loop_start[3:0];
   reg [15:0] 		 loop_end[3:0];
   reg [7:0] 		 loop_iter[3:0];
   
   always @(posedge clk, posedge reset) begin
	  if (reset) begin
		 addr <= 0;
		 stack_index <= 0;
	  end
	  else if (we) begin
		 stack_index = stack_index + 1;
		 loop_start[stack_index] <= addr + 1;
		 loop_end[stack_index] <= addr + 1 + size;
         loop_iter[stack_index] <= iter - 1;
         addr <= addr + 1;
	  end
	  else begin
		 if (addr == loop_end[stack_index]) begin
		    if (loop_iter[stack_index] !== 0) begin
			   loop_iter[stack_index] <= loop_iter[stack_index] - 1;
			   addr <= loop_start[stack_index];
		    end
		    else begin
			   stack_index <= stack_index - 1;
			   addr <= addr + 1;
		    end
         end
		 else
		   addr <= addr + 1;
	  end // else: !if(we)
   end // always @ (posedge clk, posedge reset)
endmodule // prog_seq
