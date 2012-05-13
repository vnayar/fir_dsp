/**
 * Data Memory.
 * 16-addresses, 32-bit words
 */
module dmem
  (
   input         clk, we,
   input [15:0]  a,
   input [31:0]  wd,
   output [31:0] rd);

   reg [31:0]    ram[4 * 1024];

   // Read combinationally
   assign rd = ram[a];

   // Sequential write
   always @(posedge clk)
     if (we)
       ram[a] <= wd;
endmodule // dmem
