/**
 * Register File.
 * A small memory, typically built with flip-flops, that is very fast
 * and is highly parallel.  It is typically built with a small SRAM or
 * Flip-Flops.
 */
module reg_file
  // Set to 1 to make register $0 always read as 0.
  #(parameter ZERO_REG = 0)
  (
   input         clk,
   input         we1, we2,
   input [3:0]   a1, a2, wa1, wa2,
   input [31:0]  wd1, wd2,
   output [31:0] rd1, rd2);

   // Internal register memory
   reg [31:0]    rf[3:0];
   
   // Two read-ports are combinational logic.
   assign rd1 = (ZERO_REG && a1 != 0) ? rf[a1] : 0;
   assign rd2 = (ZERO_REG && a2 != 0) ? rf[a2] : 0;

   // Sequential write logic
   always @(posedge clk) begin
      if (we1) rf[wa1] <= wd1;
      if (we2) rf[wa2] <= wd2;
   end
endmodule // reg_file
      