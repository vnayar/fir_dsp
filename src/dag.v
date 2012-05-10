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
  (
   input 			 clk,
   input 			 re, // Read-enable
   input [2:0] 		 cbs, // Circular Buffer Select
   input 			 we, // Write-enable
   input [15:0] 	 base, // These four inputs add to 32-bits.
   input [11:0] 	 len,
   input 			 sign,
   input [2:0] 		 expt,
   output reg [15:0] a); // Address

   reg [15:0] 	 cb_base[3:0];
   reg [15:0] 	 cb_top[3:0];
   reg [15:0] 	 cb_inc[3:0];
   reg [15:0]    cb_ptr[3:0];
   
   always @(posedge clk) begin
      if (we) begin
         a <= 16'bz;
         cb_base[cbs] <= base;
         cb_ptr[cbs] <= base;
         cb_top[cbs] <= base + {3'b0, len};
         cb_inc[cbs] = 1 << expt; // Blocking assignment
         cb_inc[cbs] = sign ? -cb_inc[cbs] : cb_inc[cbs];
      end
      else if (re) begin
         a <= cb_ptr[cbs];
         cb_ptr[cbs] = cb_ptr[cbs] + cb_inc[cbs]; // Blocking assignment
         cb_ptr[cbs] = cb_ptr[cbs] >= cb_top[cbs] ? cb_base[cbs] : cb_ptr[cbs];
         cb_ptr[cbs] = cb_ptr[cbs] < cb_base[cbs] ? cb_top[cbs] : cb_ptr[cbs];
      end
      else
        a <= 16'bz;
   end // always @ (posedge clk)
endmodule // dag
