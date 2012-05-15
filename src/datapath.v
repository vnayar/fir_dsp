/**
 * Data Path to tie together main components.
 */
module datapath
  (
   input 		 clk, reset,
   input [15:0]  pc,
   output [63:0] instr,
   input [15:0]  dm1_a, dm2_a,
   output [31:0] dm1_wd, dm2_wd,
   input [31:0]  dm1_rd, dm2_rd,
   input 		 dm1_we, dm2_we,
   input 		 loop_we,
   input 		 rf1_we1, rf2_we2, rf2_we1, rf2_we2,
   input 		 dag1_re, dag2_re, dag1_we, dag2_we,
   input [2:0] 	 alu1_ctrl, alu2_ctrl);

endmodule // datapath
