/**
 * Data Address Generator.
 * May be initialized to a range of memory, which will be managed as a circular
 * buffer.  When written to, the base address, length, direction/sign, and
 * increment exponent are specified.  When read, the address saved in the
 * internal address poiner is outputted.  The internal pointer is then
 * incremented by 2^(exponent) when sign is 0, and decremented when sign is 1.
 * If the internal pointer exceeds the limits set by the base and length,
 * the address "wraps-around" to the other end of the circular buffer.
 */
module dag
  (input         clk,
   input 		 re, // Read-enable
   input [2:0] 	 cbs, // Circular Buffer Select
   input 		 we, // Write-enable
   input [31:0]  wd, // Write-data: base[31:16], len[15:4], sign[3], exp[2:0]
   output [15:0] a); // Address

   reg [15:0] 	 base[3:0];
   reg [15:0] 	 top[3:0];
   reg [15:0] 	 inc[3:0];
   reg [15:0] 	 ptr[3:0];
   
   always @(posedge clk) begin
	  if (we) begin
		 base[cbs] <= wd[31:16];
		 ptr[cbs] <= wd[31:16];
		 top[cbs] <= wd[31:16] + {3'b0, wd[15:4]};
		 inc[cbs] = 1 << wd[2:0]; // Blocking assignment
		 inc[cbs] = wd[3] ? -inc[cbs] : inc[cbs];
	  end
	  else if (re) begin
		 a <= ptr[cbs];
		 ptr[cbs] = ptr[cbs] + inc[cbs]; // Blocking assignment
		 ptr[cbs] = ptr[cbs] >= top[cbs] ? base[cbs] : ptr[cbs];
		 ptr[cbs] = ptr[cbs] < base[cbs] ? top[cbs] : base[cbs];
	  end
   end
endmodule // dag
